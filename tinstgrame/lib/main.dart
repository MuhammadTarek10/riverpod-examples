import 'dart:developer' as devtools show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tinstgrame/state/auth/providers/auth_state_provider.dart';
import 'package:tinstgrame/state/auth/providers/is_logged_in_provider.dart';

import 'firebase_options.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          return isLoggedIn ? const MainView() : const LoginView();
        },
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main View'),
        ),
        body: SafeArea(
          child: Center(
            child: Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: ref.read(authStateProvider.notifier).logOut,
                  child: const Text("Log out"),
                );
              },
            ),
          ),
        ));
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                child: const Text('Sign in with Google'),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Sign in with Facebook'),
          ),
        ],
      ),
    );
  }
}
