import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/view/profile/components/about_screen.dart';
import 'package:histora/view/profile/components/contact_screen.dart';

class ExtrasProfile extends StatefulWidget {
  const ExtrasProfile({super.key});

  @override
  State<ExtrasProfile> createState() => _ExtrasProfileState();
}

class _ExtrasProfileState extends State<ExtrasProfile> {
  logoutClicked() async {
    bool? logout = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Do you want to log out?'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  TextButton(
                    child: const Text(
                      'Log out',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (logout != true) {
      return;
    }

    if (mounted) {
      context.read<AuthBloc>().add(Logout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            onTap: logoutClicked,
            title: const Text("Logout"),
            subtitle: const Text(
              'Why would you? But still.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: const FaIcon(FontAwesomeIcons.key, size: 20),
            trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
          ),
          const Divider(thickness: 0.2, color: Colors.blueGrey),
          ListTile(
            title: const Text("About Us"),
            subtitle: const Text(
              'We are an open book. Just ask.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: const FaIcon(FontAwesomeIcons.wrench, size: 20),
            trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AboutScreen(),
            )),
          ),
          const Divider(thickness: 0.2, color: Colors.blueGrey),
          ListTile(
            title: const Text("Contact Us"),
            subtitle: const Text(
              "Need help? We're there for you.",
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: const FaIcon(FontAwesomeIcons.wrench, size: 20),
            trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 20),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ContactScreen(),
            )),
          ),
        ]
            .animate(interval: 50.ms)
            .slideX(begin: -0.1, curve: Curves.fastOutSlowIn)
            .fadeIn(),
      ),
    );
  }
}
