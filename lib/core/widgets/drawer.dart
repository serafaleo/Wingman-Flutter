import 'package:flutter/material.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/auth_session_manager.dart';

class WingmanDrawer extends StatelessWidget {
  const WingmanDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Text('Hello, ${sl<AuthSessionManager>().userName}!'),
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
}
