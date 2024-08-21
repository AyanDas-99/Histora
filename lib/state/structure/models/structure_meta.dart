// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:histora/state/gps/models/coordinate.dart';

class StructureMeta extends Equatable {
  final String id;
  final Coordinate coordinate;

  const StructureMeta({
    required this.id,
    required this.coordinate,
  });

  StructureMeta copyWith({
    String? id,
    Coordinate? coordinate,
  }) {
    return StructureMeta(
      id: id ?? this.id,
      coordinate: coordinate ?? this.coordinate,
    );
  }

  factory StructureMeta.fromMap(Map<String, dynamic> map) {
    return StructureMeta(
      id: map['id'] as String,
      coordinate: (
        (map['lat'] as num).toDouble(),
        (map['lon'] as num).toDouble(),
      ),
    );
  }

  factory StructureMeta.fromJson(String source) =>
      StructureMeta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id, coordinate];
}
