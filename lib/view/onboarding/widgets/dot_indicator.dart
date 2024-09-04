import 'package:flutter/material.dart';

class DotIndicator extends StatefulWidget {
  final int length;
  final int index;
  const DotIndicator({
    super.key,
    required this.length,
    required this.index,
  });

  @override
  State<DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.length,
          (index) => AnimatedContainer(
            margin: const EdgeInsets.all(5),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            width: 10,
            decoration: BoxDecoration(
              color: widget.index == index ? Colors.black : Colors.white,
              shape: BoxShape.circle,
              border: Border.all()
            ),
          ),
        ),
      ),
    );
  }
}
