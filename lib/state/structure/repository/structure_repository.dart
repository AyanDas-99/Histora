import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/state/gps/utils/haversine_distance.dart';
import 'package:histora/state/structure/models/structure.dart';
import 'package:histora/state/structure/models/structure_meta.dart';
import 'package:histora/state/gps/models/coordinate.dart';
import 'package:http/http.dart' as http;

abstract class StructureRepository {
  ///Get 2 [StructureMeta] nearest to the coordinate
  ///
  ///Uses HaverSine formula to calculate the distance between coordinates
  ///
  ///Throws [StructureMetaException] on error
  Future<List<StructureMeta>> getStructureNearestToCoordinate(
      Coordinate coordinate);

  ///Get [List<String>] images of the id
  ///
  ///Throws [AssetException] on error
  Future<List<String>> getImagesForId(String id);

  ///Get [Structure] from id
  ///
  ///Throws [StructureException] on error
  Future<Structure> getStructureForId(String id);

  /// Get [List<StructureMeta>]
  ///
  /// Throws [StructureMetaException] on error
  Future<List<StructureMeta>> getAllStructureMeta();

  /// Get [Uint8List] from image download url
  ///
  /// Throws [HttpException] on error
  Future<Uint8List> getImageBytesFromUrl(String url);
}

class StructureRepositoryImpl implements StructureRepository {
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;
  final http.Client httpClient;

  ///Radius to use for nearest structure to user location in mtrs
  static const radius = 200;

  StructureRepositoryImpl({
    required this.storage,
    required this.firestore,
    required this.httpClient,
  });

  @override
  Future<List<String>> getImagesForId(String id) async {
    final urls = <String>[];
    final ref = storage.ref().child('assets');
    try {
      final result = await ref.child(id).listAll();
      if (result.items.isEmpty) {
        throw AssetException('Images not found for id: $id');
      }
      for (var item in result.items) {
        urls.add(await item.getDownloadURL());
      }
      return urls;
    } on FirebaseException catch (e) {
      throw AssetException(e.message ?? e.code);
    }
  }

  @override
  Future<Structure> getStructureForId(String id) async {
    try {
      final result = await firestore
          .collection('details')
          .where('id', isEqualTo: id)
          .limit(1)
          .get();

      return Structure.fromMap(result.docs.first.data());
    } on FirebaseException catch (e) {
      throw AssetException(e.message ?? e.code);
    }
  }

  @override
  Future<List<StructureMeta>> getStructureNearestToCoordinate(
      Coordinate coordinate) async {
    final allStructures = await getAllStructureMeta();
    List<StructureMeta> nearestStructures = allStructures.where((meta) {
      return HaversineDistance()
              .haversine(coordinate, meta.coordinate, Unit.METER)
              .abs() <=
          200;
    }).toList();

    return nearestStructures;
  }

  @override
  Future<List<StructureMeta>> getAllStructureMeta() async {
    final result = await firestore.collection('metadata').get();
    final structureMetas =
        result.docs.map((doc) => StructureMeta.fromMap(doc.data())).toList();
    return structureMetas;
  }

  @override
  Future<Uint8List> getImageBytesFromUrl(String url) async {
    final result = await httpClient.get(Uri.parse(url));
    return result.bodyBytes;
  }
}
