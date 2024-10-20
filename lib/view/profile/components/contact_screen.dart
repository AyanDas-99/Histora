import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Have a doubt? or want to share your thoughts?',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text('Write to us'),
              subtitle: Text('ayandas9531@gmail.com'),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: 'ayandas9531@gmail.com'));
                  },
                  icon: FaIcon(FontAwesomeIcons.copy)),
            ),
            ListTile(
              title: Text('Talk to us on call'),
              subtitle: Text('91-99100110101'),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: '91-99100110101'));
                },
                icon: FaIcon(FontAwesomeIcons.copy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
