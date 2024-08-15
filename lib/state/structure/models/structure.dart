// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:histora/state/structure/models/history.dart';
import 'package:histora/state/structure/typedefs/coordinate.dart';

class Structure extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String>? images;
  final History history;
  final Coordinate coordinate;

  const Structure({
    required this.id,
    required this.title,
    required this.description,
    this.images,
    required this.history,
    required this.coordinate,
  });

  Structure copyWith({
    String? title,
    String? description,
    List<String>? images,
    History? history,
    Coordinate? coordinate,
  }) {
    return Structure(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      history: history ?? this.history,
      coordinate: coordinate ?? this.coordinate,
    );
  }

  factory Structure.fromMap(Map<String, dynamic> map) {
    return Structure(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      history: History(history: map['history'] as String),
      coordinate: (map['latitude'] as double, map['longitude'] as double),
    );
  }

  factory Structure.fromJson(String source) =>
      Structure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        title,
        description,
        images,
        history,
        coordinate,
        id,
      ];
}
