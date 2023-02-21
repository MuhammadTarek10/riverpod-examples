import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppStrings {
  static const String loading = "Loading...";

  static const String allowLikesTitle = "Allow Likes";
  static const String allowLikesDescription =
      "By allowing likes, users will be able to press the like button on your post";
  static const String allowLikesStorageKey = "allow-likes";
  static const String allowCommentsTitle = "Allow Comments";
  static const String allowCommentsDescription =
      "By allowing comments, users will be able to comment on your post";
  static const String allowCommentsStorageKey = "allow-comments";

  static const String comment = "comment";

  static const String person = "person";
  static const String people = "people";
  static const String likedThis = "like This";

  static const String delete = "Delete";
  static const String areYouSure = "Are you sure you want to delete This";

  static const String logout = "Log out";
  static const String logoutDescription = "Are you sure you want to log out?";

  static const String cancel = "Cancel";

  const AppStrings._();
}
