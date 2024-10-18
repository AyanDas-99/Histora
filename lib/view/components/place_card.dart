import 'package:flutter/material.dart';
import 'package:histora/state/structure/models/structure.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.structure});
  final Structure structure;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 250,
      height: 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(5, 10),
              blurRadius: 10,
            )
          ]),
      child: Stack(
        children: [
          SizedBox(
            width: 250,
            height: 150,
            child: Image.network(
              alignment: Alignment.topCenter,
              structure.images.first,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                structure.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
