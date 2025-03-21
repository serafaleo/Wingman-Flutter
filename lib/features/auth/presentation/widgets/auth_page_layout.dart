import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wingman/core/constants/router_constants.dart';
import 'package:wingman/core/widgets/loader_indicator.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';
import 'package:wingman/features/auth/domain/entities/signup_request_entity.dart';
import 'package:wingman/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wingman/features/auth/presentation/widgets/auth_text_form_field.dart';

class AuthPageLayout extends StatefulWidget {
  final bool isLogin;

  const AuthPageLayout({super.key, required this.isLogin});

  @override
  State<AuthPageLayout> createState() => _AuthPageLayoutState();
}

class _AuthPageLayoutState extends State<AuthPageLayout> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmFocusNode = FocusNode();

  bool _isFormExpanded = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_focusChangeListener);
    _passwordFocusNode.addListener(_focusChangeListener);
    _passwordConfirmFocusNode.addListener(_focusChangeListener);
  }

  void _focusChangeListener() {
    setState(() {
      _isFormExpanded =
          _emailFocusNode.hasFocus ||
          _passwordFocusNode.hasFocus ||
          _passwordConfirmFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmFocusNode.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    // Dismiss the keyboard when the user taps outside of the fields
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _buildBackground() {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              widget.isLogin ? 'Login' : 'Sign Up',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              widget.isLogin ? 'Welcome back' : 'Create your account',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  _buildFormCard() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: _dismissKeyboard,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height:
              _isFormExpanded
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * (3 / 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: _isFormExpanded ? Radius.zero : const Radius.circular(50),
              topRight: _isFormExpanded ? Radius.zero : const Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        focusNode: _emailFocusNode,
                        isPassword: false,
                        hintText: 'Enter your email',
                        controller: _emailController,
                        validator:
                            widget.isLogin
                                ? LoginRequestEntityValidator.validateEmail
                                : SignUpRequestEntityValidator.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      AuthTextFormField(
                        focusNode: _passwordFocusNode,
                        isPassword: true,
                        hintText: widget.isLogin ? 'Enter your password' : 'Choose your password',
                        controller: _passwordController,
                        validator:
                            widget.isLogin
                                ? LoginRequestEntityValidator.validatePassword
                                : SignUpRequestEntityValidator.validatePassword,
                      ),
                      if (!widget.isLogin) ...[
                        const SizedBox(height: 20),
                        AuthTextFormField(
                          focusNode: _passwordConfirmFocusNode,
                          isPassword: true,
                          hintText: 'Confirm your password',
                          controller: _passwordConfirmController,
                          validator:
                              (value) => SignUpRequestEntityValidator.validatePasswordConfirm(
                                value,
                                _passwordController.text,
                              ),
                        ),
                      ],
                      const SizedBox(height: 60),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            assert(
                              state is AuthFailureState ||
                                  state is AuthLoadingState ||
                                  state is LoginSuccessState,
                            );
                            if (state is AuthFailureState) {
                              state.failure.show(context);
                            } else if (state is LoginSuccessState) {
                              context.go('/');
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(200),
                                elevation: 5,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    widget.isLogin
                                        ? AuthLoginEvent(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text.trim(),
                                        )
                                        : AuthSignUpEvent(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text.trim(),
                                          passwordConfirmation:
                                              _passwordConfirmController.text.trim(),
                                        ),
                                  );
                                }
                              },
                              child:
                                  state is AuthLoadingState
                                      ? const LoaderIndicator(color: Colors.white)
                                      : Text(
                                        widget.isLogin ? 'Login' : 'Sign Up',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                      ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: widget.isLogin ? "Don't have an account? " : 'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: widget.isLogin ? 'Sign Up' : 'Login',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                if (widget.isLogin) {
                                  context.go(RouterConstants.signUp);
                                } else {
                                  context.go(RouterConstants.login);
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [_buildBackground(), _buildFormCard()]),
    );
  }
}
