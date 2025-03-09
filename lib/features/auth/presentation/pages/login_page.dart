import 'package:flutter/material.dart';
import 'package:wingman/core/utils/extension_methods/show_snackbar.dart';
import 'package:wingman/features/auth/presentation/widgets/auth_page_layout.dart';

class LoginPage extends StatelessWidget {
  final bool showSessionExpiredWarning;
  const LoginPage({super.key, this.showSessionExpiredWarning = false});

  @override
  Widget build(BuildContext context) {
    if (showSessionExpiredWarning) {
      showSnackBar(context, 'Session expired. Please, log in again.');
    }
    return const AuthPageLayout(isLogin: true);
  }
}
