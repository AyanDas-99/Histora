// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:histora/state/structure/typedefs/coordinate.dart';

class StructureMeta extends Equatable {
  final String structureId;
  final Coordinate coordinate;

  const StructureMeta({
    required this.structureId,
    required this.coordinate,
  });

  StructureMeta copyWith({
    String? structureId,
    Coordinate? coordinate,
  }) {
    return StructureMeta(
      structureId: structureId ?? this.structureId,
      coordinate: coordinate ?? this.coordinate,
    );
  }

  factory StructureMeta.fromMap(Map<String, dynamic> map) {
    return StructureMeta(
      structureId: map['structureId'] as String,
      coordinate: (map['latitude'] as double, map['longitude'] as double),
    );
  }

  factory StructureMeta.fromJson(String source) =>
      StructureMeta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [structureId, coordinate];
}
