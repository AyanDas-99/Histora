import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? image;
  const ImageBox({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: image == null
          ? const Center(
              child: Text('Click on get picture'),
            )
          : Image.file(
              File(image!),
              fit: BoxFit.contain,
            ),
    );
  }
}
