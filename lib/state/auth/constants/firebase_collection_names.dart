import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionNames {
  static String users = 'users';
  static String profilePhoto = 'profile_photo';
  static String posts = 'posts';
  static String images = 'images';
  static String videos = 'videos';
  static String thumbnails = 'thumbnails';
  static String likes = 'likes';
  static String comments = 'comments';
  const FirebaseCollectionNames._();
}
