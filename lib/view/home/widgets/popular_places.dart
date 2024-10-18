import 'package:flutter/material.dart';
import 'package:histora/state/structure/models/history.dart';
import 'package:histora/state/structure/models/structure.dart';
import 'package:histora/view/components/place_card.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          PlaceCard(
            structure: Structure(
                id: 'id',
                title: 'Abandoned Base of Ross Island',
                description: 'Good statue to see',
                images: [
                 'https://www.ravenouslegs.com/uploads/4/2/3/4/42340821/p1070020_1.jpg' 
                ],
                history: History(history: ''),
                coordinate: (1, 2)),
          ),
          PlaceCard(
            structure: Structure(
                id: 'id',
                title: 'Cellular Jail',
                description: 'Memories',
                images: [
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1pHjrqqYmB3wbmeQ-op5q1uBCw7ryWtQ_HA&s'
                ],
                history: History(history: ''),
                coordinate: (1, 2)),
          ),
          PlaceCard(
            structure: Structure(
                id: 'id',
                title: 'Abandoned Church in Ross Island',
                description: 'Good statue to see',
                images: [
                  'https://goandamans.in/media/blogs/12232755533_b5392f5a42_b.jpg'
                ],
                history: History(history: ''),
                coordinate: (1, 2)),
          ),
        ],
      ),
    );
  }
}
