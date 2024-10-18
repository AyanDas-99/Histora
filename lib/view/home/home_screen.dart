import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/utils/pick_images.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/history/history_screen.dart';
import 'package:histora/view/home/widgets/animated_globe.dart';
import 'package:histora/view/home/widgets/popular_places.dart';
import 'package:histora/view/widgets/custom_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  static String get path => '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedImage;

  onUncoverClicked(BuildContext content, bool fromCamera) async {
    final image = await pickImage(fromCamera);

    if (image == null) {
      return;
    } else {
      if (mounted) {
        context.read<HistoryBloc>().add(SearchPhoto(imageFromUser: image.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              text: state.message,
              type: SnackBarType.error,
            ),
          );
        }
        if (state is HistoryNotFound) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(text: 'Not found :(', type: SnackBarType.error),
          );
        }
        if (state is HistorySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
                text: 'Found structure ${state.structure.title}',
                type: SnackBarType.success),
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HistoryScreen(structure: state.structure),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending Sights',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const PopularPlaces(),
                const SizedBox(height: 10),
                // const Text(
                //   "Let's discover the unique, and know the unknown !",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily: 'Rosarivo',
                //     fontSize: 17,
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ClipRRect(
                //       borderRadius: BorderRadius.circular(20),
                //       child: Image.asset('assets/images/man-with-cam.avif')),
                // ),
                // const SizedBox(height: 20),
                // const Text(
                //   "Search for history of unique place by uploading an image of the place",
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 20),
                // Row(
                //   children: [
                //     Expanded(
                //       child: TextButton(
                //         style: ButtonStyle(
                //             backgroundColor:
                //                 WidgetStatePropertyAll(Colors.orange.shade600),
                //             shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10)))),
                //         onPressed: () => onUncoverClicked(context, true),
                //         child: const Text(
                //           'Use Camera',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     Expanded(
                //       child: TextButton(
                //         style: ButtonStyle(
                //             backgroundColor:
                //                 const WidgetStatePropertyAll(Colors.blue),
                //             shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10)))),
                //         onPressed: () => onUncoverClicked(context, false),
                //         child: BlocConsumer<HistoryBloc, HistoryState>(
                //           listener: (context, state) {
                //             if (state is HistoryFailed) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 customSnackBar(
                //                   text: state.message,
                //                   type: SnackBarType.error,
                //                 ),
                //               );
                //             }
                //             if (state is HistoryNotFound) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 customSnackBar(
                //                     text: 'Not found :(',
                //                     type: SnackBarType.error),
                //               );
                //             }
                //             if (state is HistorySuccess) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 customSnackBar(
                //                     text:
                //                         'Found structure ${state.structure.title}',
                //                     type: SnackBarType.success),
                //               );
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder: (context) =>
                //                       HistoryScreen(structure: state.structure),
                //                 ),
                //               );
                //             }
                //           },
                //           builder: (context, state) {
                //             return const UncoverBtn();
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                // AI
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blueAccent.shade100,
                          Colors.blue,
                        ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Histora AI',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 5),
                      ),
                      AnimatedGlobe(),
                      const SizedBox(height: 10),
                      Text(
                        "Share your image and location and know what you're looking at",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => onUncoverClicked(context, true),
                              child: Container(
                                height: 100,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned.fill(
                                      child: Opacity(
                                        opacity: 0.4,
                                        child: Image.asset(
                                          'assets/images/cam.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              onTap: () => onUncoverClicked(context, false),
                              child: Container(
                                height: 100,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned.fill(
                                        child: Opacity(
                                      opacity: 0.4,
                                      child: Image.asset(
                                        'assets/images/gallery.jpeg',
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UncoverBtn extends StatelessWidget {
  const UncoverBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Use Gallery',
      style: TextStyle(color: Colors.white),
    );
  }
}
