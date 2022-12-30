import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/modules/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<SettingsProvider>().getProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: kLargePadding,
          child: Text('Settings'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kLargePadding,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: profile.photoURL != null ? Image.network(profile.photoURL!) : const Icon(Icons.person),
                  ),
                  Text(
                    profile.displayName!.isEmpty ? profile.email ?? 'Unknown' : 'Unknown',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {},
                trailing: const Icon(Icons.help),
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  context.read<SettingsProvider>().logout();
                },
                trailing: const Icon(Icons.logout),
              )
            ],
          ),
        ),
      ),
    );
  }
}
