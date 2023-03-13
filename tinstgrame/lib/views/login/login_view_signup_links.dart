import 'package:flutter/material.dart';
import 'package:tinstgrame/views/components/constants/strings.dart';
import 'package:tinstgrame/views/components/rich_text/base_text.dart';
import 'package:tinstgrame/views/components/rich_text/rich_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignUp extends StatelessWidget {
  const LoginViewSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll:
          Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: AppStrings.dontHaveAnAccount),
        BaseText.plain(text: AppStrings.signUpOn),
        BaseText.link(
          text: AppStrings.facebook,
          onTap: () {
            launchUrl(Uri.parse(AppStrings.facebookSignupUrl));
          },
        ),
        BaseText.plain(text: AppStrings.orCreateAnAccountOn),
        BaseText.link(
          text: AppStrings.google,
          onTap: () {
            launchUrl(Uri.parse(AppStrings.googleSignupUrl));
          },
        ),
      ],
    );
  }
}
