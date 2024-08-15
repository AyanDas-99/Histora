import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldNames {
  static String displayName = 'display_name';
  static String userId = 'user_id';
  static String email = 'email';
  static String friendsList = 'friends_list';
  static String photoUrl = 'photo_url';
  static String photoStorageId = 'photo_storage_id';
  static String bio = 'user_bio';
  static String favouriteTags = 'favourite_tags';
  static String postId = 'post_id';
  static String title = 'title';
  static String message = 'message';
  static String allowComments = 'allow_comments';
  static String fileType = 'file_type';
  static String thumbnailUrl = 'thumbnail_url';
  static String thumbnailStorageId = 'thumbnail_storage_id';
  static String originalFileUrl = 'original_file_url';
  static String originalFileStorageId = 'original_file_storage_id';
  static String aspectRatio = 'aspect_ratio';
  static String createdAt = 'created_at';
  static String tag = 'tag';
  static String commentType = 'comment_type';
  static String replyTo = 'reply_to';
  const FirebaseFieldNames._();
}
