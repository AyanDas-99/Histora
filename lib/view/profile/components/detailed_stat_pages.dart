import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:histora/view/profile/components/settings_screen.dart';
import 'package:histora/view/profile/components/travel_history_screen.dart';

class DetailedStatPages extends StatelessWidget {
  const DetailedStatPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: const Text("Travel History"),
            subtitle: const Text(
              'Last seen in Gandhi Park',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: const FaIcon(FontAwesomeIcons.personRunning, size: 20),
            trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
            onTap: () {
              print('clicked');
              // context.go(TravelHistoryScreen.path);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TravelHistoryScreen(),
              ));
            },
          ),
          const Divider(thickness: 0.2, color: Colors.blueGrey),
          ListTile(
            title: const Text("Settings"),
            subtitle: const Text(
              'Create your experience',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: const FaIcon(FontAwesomeIcons.wrench, size: 20),
            trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context) => const SettingsScreen(),)),
          ),
        ]
            .animate(interval: 50.ms)
            .slideX(begin: -0.1, curve: Curves.fastOutSlowIn)
            .fadeIn(),
      ),
    );
  }
}
