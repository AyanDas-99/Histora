// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

///bool isSame holds whether two objects are same
///
///String message holds the message from the AI abou the two objects
///
///num confidence is the percentage value of how confident the AI is that the two objects are same
///   - For example: confidence of 0% is the AI is fully confident that the objects are different, 100% confident means Ai the fully confident that both 0bjects are exactly same.
class AiResult extends Equatable {
  bool isSame;
  String message;
  num confidence;
  AiResult({
    required this.isSame,
    required this.message,
    required this.confidence,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSame': isSame,
      'message': message,
      'confidence': confidence,
    };
  }

  factory AiResult.fromMap(Map<String, dynamic> map) {
    return AiResult(
      isSame: map['isSame'] as bool,
      message: map['message'] as String,
      confidence: map['confidence'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory AiResult.fromJson(String source) =>
      AiResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [isSame, message, confidence];
}

class UserImageBytes {
  final Uint8List image;

  UserImageBytes({required this.image});
}

class AssetImageBytes {
  final List<Uint8List> images;

  AssetImageBytes({required this.images});
}
