import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String image;
  const ImageBox({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File(image),
              fit: BoxFit.contain,
            ),
          );
  }
}
