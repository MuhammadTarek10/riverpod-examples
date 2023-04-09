import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:tinstgrame/state/image_upload/models/file_type.dart';
import 'package:tinstgrame/state/post_settings/models/post_settings.dart';
import 'package:tinstgrame/state/posts/models/post_key.dart';

@immutable
class Post {
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRation;
  final Map<PostSettings, bool> postSettings;
  final String thumbnailStorageId;
  final String originalFileStorageId;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        fileType = FileType.values.firstWhere(
            (fileType) => fileType.name == json[PostKey.fileType],
            orElse: () => FileType.image),
        fileName = json[PostKey.fileName],
        aspectRation = json[PostKey.aspectRation],
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSettings.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value,
        },
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalFileStorageId = json[PostKey.originalFileStorageId];

  bool get allowLikes => postSettings[PostSettings.allowLikes] ?? false;
  bool get allowComments => postSettings[PostSettings.allowComments] ?? false;
}
