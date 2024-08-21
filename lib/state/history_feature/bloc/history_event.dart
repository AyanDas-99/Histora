part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class SearchPhoto extends HistoryEvent {
  final String imageFromUser;

  const SearchPhoto({required this.imageFromUser});

  @override
  List<Object> get props => [imageFromUser];
}
