import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  static const String allowLikesStorageKey = "allow_likes";
  static const String allowLikes = "Allow Likes";
  static const String allowLikesDescription = "allow other users to like";
  static const String allowCommentsStorageKey = "allow_comments";
  static const String allowComments = "Allow Comments";
  static const String allowCommentsDescription = "allow other users to comment";

  const Constants._();
}
