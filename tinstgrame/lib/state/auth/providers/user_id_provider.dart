import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tinstgrame/state/auth/providers/auth_state_provider.dart';
import 'package:tinstgrame/state/posts/typedef/user_id.dart';

final userIdProvider = Provider<UserId?>(
  (ref) => ref.watch(authStateProvider).userId,
);
