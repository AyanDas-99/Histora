import 'package:flutter/material.dart';
import 'package:histora/state/structure/models/structure.dart';
import 'package:histora/view/history/frosted_container.dart';
import 'package:histora/view/history/images_view.dart';

class HistoryScreen extends StatefulWidget {
  final Structure structure;
  const HistoryScreen({super.key, required this.structure});

  static const String name = 'history';
  static const String path = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int imageSliderPage = 0;

  onImageSliderChange(int index) {
    setState(() {
      imageSliderPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.structure.images[imageSliderPage]),
              opacity: 0.3,
              fit: BoxFit.cover,
            ),
          ), duration: const Duration(milliseconds: 600),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'HISTORA',
              style: TextStyle(fontFamily: 'Rosarivo'),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.structure.title,
                    style: const TextStyle(
                      fontFamily: 'Rosarivo',
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FrostedContainer(child: Text(widget.structure.description)),
                  const SizedBox(height: 20),
                  ImagesView(
                    images: widget.structure.images, onChange: onImageSliderChange,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontFamily: 'Rosarivo',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FrostedContainer(child: widget.structure.history.build()),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      '... Happy Journey ...',
                      style: TextStyle(
                        fontFamily: 'Rosarivo',
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
