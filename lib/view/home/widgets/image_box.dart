import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? image;
  const ImageBox({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
     child: image == null
          ? null
          : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
                File(image!),
                fit: BoxFit.contain,
              ),
          ),
    );
  }
}
