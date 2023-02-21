import 'package:flutter/foundation.dart' show immutable;
import 'package:tinstgrame/state/constants/firebase_collection_name.dart';
import 'package:tinstgrame/state/constants/firebase_field_names.dart';
import 'package:tinstgrame/state/posts/typedef/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinstgrame/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? "",
        });
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
}
