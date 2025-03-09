import 'package:flutter/material.dart';
import 'package:wingman/features/auth/presentation/widgets/auth_page_layout.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPageLayout(isLogin: false);
  }
}
