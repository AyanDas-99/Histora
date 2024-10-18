import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final User user;
  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (user.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 33,
              ),
            if(user.photoURL == null)
              const CircleAvatar(
                radius: 33,
                child: Icon(Icons.person),
              ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? 'User',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                Text(
                  user.email ?? '',
                  style: const TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
          ],
        ),
        
      ],
    );
  }
}
