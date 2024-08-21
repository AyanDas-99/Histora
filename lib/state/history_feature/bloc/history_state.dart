part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class GPSLoading extends HistoryState {}

final class NearestStructureLoading extends HistoryState {}

final class MatchingImages extends HistoryState {}

final class DetailLoading extends HistoryState {}

final class HistorySuccess extends HistoryState {
  final Structure structure;
  final AiResult aiResult;

  const HistorySuccess({required this.structure, required this.aiResult});
}

final class HistoryNotFound extends HistoryState {}

final class HistoryFailed extends HistoryState {
  final String message;

  const HistoryFailed(this.message);
}
