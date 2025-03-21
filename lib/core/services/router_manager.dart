import 'package:go_router/go_router.dart';
import 'package:wingman/core/constants/router_constants.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/auth_session_manager.dart';
import 'package:wingman/core/utils/extension_methods/string_extensions.dart';
import 'package:wingman/features/auth/presentation/pages/login_page.dart';
import 'package:wingman/features/auth/presentation/pages/signup_page.dart';
import 'package:wingman/features/home/presentation/pages/home_page.dart';

final class RouterManager {
  late final GoRouter _router;

  GoRouter get router => _router;

  void initRouter() {
    String? initialLocation;
    if (sl<AuthSessionManager>().accessToken.isNullOrEmpty()) {
      initialLocation = RouterConstants.login;
    }
    _router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: RouterConstants.home, builder: (context, state) => const HomePage()),
        GoRoute(
          path: RouterConstants.login,
          builder: (context, state) {
            final bool showSessionExpiredWarning = bool.parse(
              state.pathParameters[RouterConstants.loginPageShowSessionExpiredWarning] ?? 'false',
            );
            return LoginPage(showSessionExpiredWarning: showSessionExpiredWarning);
          },
        ),
        GoRoute(path: RouterConstants.signUp, builder: (context, state) => const SignUpPage()),
      ],
    );
  }

  void goNamed(String location, {Map<String, String> pathParameters = const <String, String>{}}) {
    _router.goNamed(location, pathParameters: pathParameters);
  }
}
