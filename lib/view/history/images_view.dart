import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ImagesView extends StatefulWidget {
  final Function(int) onChange;
  final List<String> images;
  const ImagesView({
    super.key,
    required this.images,
    required this.onChange,
  });

  @override
  State<ImagesView> createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  OverlayEntry? overlayEntry;

  addOverlay(String imageLink) {
    removeOverlay();
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                removeOverlay();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                imageLink,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ).animate().scaleXY(begin: 0, end: 1, duration: 200.ms),
          ],
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry?.dispose();
      overlayEntry = null;
    }
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.images.map((e) {
        return GestureDetector(
          onTap: () {
            addOverlay(e);
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                e,
                fit: BoxFit.cover,
                width: 1000,
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 300,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          widget.onChange(index);
        },
      ),
    );
  }
}
