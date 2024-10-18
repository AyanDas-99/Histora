import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailedStatPages extends StatelessWidget {
  const DetailedStatPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("Travel History"),
            subtitle: Text(
              'Last seen in Gandhi Park',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: FaIcon(FontAwesomeIcons.personRunning, size: 20),
            trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20),
          ),
          Divider(thickness: 0.2, color: Colors.blueGrey),
          ListTile(
            title: Text("Settings"),
            subtitle: Text(
              'Create your experience',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: FaIcon(FontAwesomeIcons.wrench, size: 20),
            trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20),
          ),
        ]
            .animate(interval: 50.ms)
            .slideX(begin: -0.1, curve: Curves.fastOutSlowIn)
            .fadeIn(),
      ),
    );
  }
}
