import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wingman/core/constants/router_constants.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/auth_session_manager.dart';
import 'package:wingman/features/auth/presentation/bloc/auth_bloc.dart';

class WingmanDrawer extends StatelessWidget {
  const WingmanDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${sl<AuthSessionManager>().userName}!',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
                BlocProvider(
                  create: (_) => AuthBloc(),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailureState) {
                        state.failure.show(context);
                      } else if (state is LogoutSuccessState) {
                        context.go(RouterConstants.login);
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () async {
                          if ((await _showLogoutDialog(context) ?? false) && context.mounted) {
                            context.read<AuthBloc>().add(AuthLogoutEvent());
                          }
                        },
                        icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.onPrimary),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.flight_takeoff, 'Flights', () {}),
          _buildDrawerItem(Icons.airplanemode_on, 'Aircrafts', () {}),
          _buildDrawerItem(Icons.settings, 'Settings', () {}),
        ],
      ),
    );
  }

  _buildDrawerItem(IconData icon, String text, void Function()? onTap) {
    return ListTile(
      title: Row(children: [Icon(icon), const SizedBox(width: 10), Text(text)]),
      onTap: onTap,
    );
  }

  Future<bool?> _showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout from current session?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Yes')),
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('No')),
          ],
        );
      },
    );
  }
}
