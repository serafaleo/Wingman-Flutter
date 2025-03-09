import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wingman/core/configs/theme.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/auth_session_manager.dart';
import 'package:wingman/core/services/router_manager.dart';
import 'package:wingman/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wingman/features/home/presentation/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await sl<AuthSessionManager>().tryRestoreSession();
  sl<RouterManager>().initRouter();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc()), BlocProvider(create: (_) => HomeBloc())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wingman',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      routerConfig: sl<RouterManager>().router,
    );
  }
}
