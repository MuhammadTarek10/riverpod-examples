import 'package:tinstgrame/state/post_settings/constants/constants.dart';

enum PostSettings {
  allowLikes(
    title: Constants.allowLikes,
    description: Constants.allowLikesDescription,
    storageKey: Constants.allowLikesStorageKey,
  ),
  allowComments(
    title: Constants.allowComments,
    description: Constants.allowCommentsDescription,
    storageKey: Constants.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;
  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
