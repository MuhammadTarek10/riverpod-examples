import 'package:flutter/foundation.dart' show immutable;

@immutable
class PostKey {
  static const String userId = "uid";
  static const String message = "message";
  static const String postId = "post_id";
  static const String createdAt = "created_at";
  static const String thumbnailUrl = "thumbnail_url";
  static const String fileUrl = "file_url";
  static const String fileType = "file_type";
  static const String fileName = "file_name";
  static const String aspectRation = "aspect_ration";
  static const String postSettings = "post_settings";
  static const String thumbnailStorageId = "thumbnail_storage_id";
  static const String originalFileStorageId = "original_file_storage_id";

  const PostKey._();
}
