import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/view/home/widgets/popular_places.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.white,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 120,
            toolbarHeight: 70,
            title: Text('Explore'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by name or coordinate',
                            hintStyle: TextStyle(
                                fontSize: 14, fontFamily: 'Rosarivo'),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                )),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.filter,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: PopularPlaces(),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20,)),
          SliverToBoxAdapter(child: Text('Will be available on next update. Possibly till final year.', textAlign: TextAlign.center,),),
          // SliverPadding(
          //   padding: const EdgeInsets.all(8.0),
          //   sliver: SliverList.builder(
          //     itemCount: 10,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         margin: const EdgeInsets.all(8),
          //         height: 180,
          //         clipBehavior: Clip.hardEdge,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: Stack(
          //           fit: StackFit.expand,
          //           children: [
          //             SizedBox(
          //               height: 150,
          //               child: Image.network(
          //                 alignment: Alignment.topCenter,
          //                 'https://indiafacts.org/wp-content/uploads/2018/11/Erotic-Sentiment-in-Indian-Temple-Sculptures-680x500.jpg',
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             Positioned(
          //               bottom: 0,
          //               left: 0,
          //               right: 0,
          //               child: Container(
          //                 height: 50,
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(
          //                     begin: Alignment.bottomCenter,
          //                     end: Alignment.topCenter,
          //                     colors: [
          //                       Colors.black.withOpacity(0.9),
          //                       Colors.black.withOpacity(0.3),
          //                     ],
          //                   ),
          //                 ),
          //                 padding: const EdgeInsets.all(10),
          //                 child: Text(
          //                   'title',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
