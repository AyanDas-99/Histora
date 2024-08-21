import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/state/AI/ai_result.dart';
import 'package:histora/state/AI/repository/ai_repository.dart';
import 'package:histora/state/gps/models/coordinate.dart';
import 'package:histora/state/gps/respository/gps_repository.dart';
import 'package:histora/state/structure/models/structure.dart';
import 'package:histora/state/structure/models/structure_meta.dart';
import 'package:histora/state/structure/repository/structure_repository.dart';
import 'dart:developer' as dev;

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GpsRepository gpsRepository;
  final StructureRepository structureRepository;
  final AiRepository aiRepository;
  HistoryBloc({
    required this.gpsRepository,
    required this.structureRepository,
    required this.aiRepository,
  }) : super(HistoryInitial()) {
    on<SearchPhoto>(searchHistory);
  }

  void searchHistory(SearchPhoto event, Emitter emit) async {
    try {
      emit(GPSLoading());
      final Coordinate coordinates = await gpsRepository.getCurrentLocation();
      emit(NearestStructureLoading());
      final List<StructureMeta> metas = await structureRepository
          .getStructureNearestToCoordinate(coordinates);
      dev.log("Nearest structures : $metas");
      emit(MatchingImages());
      for (var meta in metas) {
        final images = await _getAllImageBytes(meta.id);
        dev.log("Images for $meta : $images");
        final File userImage = File(event.imageFromUser);
        final aiResult = await aiRepository.compareImageSets(
          UserImageBytes(image: await userImage.readAsBytes()),
          AssetImageBytes(images: images),
        );
        if (aiResult.isSame) {
          emit(DetailLoading());
          final detailedStructure =
              await structureRepository.getStructureForId(meta.id);
          return emit(
            HistorySuccess(structure: detailedStructure, aiResult: aiResult),
          );
        }
      }
      emit(HistoryNotFound());
    } on GpsException catch (e) {
      emit(HistoryFailed(e.message));
    } on StructureMetaException catch (e) {
      emit(HistoryFailed(e.message));
    } on AssetException catch (e) {
      emit(HistoryFailed(e.message));
    } on HttpException catch (e) {
      emit(HistoryFailed(e.message));
    } on AiException catch (e) {
      emit(HistoryFailed(e.message));
    } on StructureException catch (e) {
      emit(HistoryFailed(e.message));
    } catch (e) {
      emit(HistoryFailed(e.toString()));
    }
  }

  Future<List<Uint8List>> _getAllImageBytes(String id) async {
    final images = await structureRepository.getImagesForId(id);
    final List<Uint8List> list = [];
    for (var image in images) {
      list.add(await structureRepository.getImageBytesFromUrl(image));
    }
    return list;
  }

  @override
  void onTransition(Transition<HistoryEvent, HistoryState> transition) {
    super.onTransition(transition);
    dev.log(transition.toString());
  }
}
