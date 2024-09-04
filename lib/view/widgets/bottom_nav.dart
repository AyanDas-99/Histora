import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav(
      {super.key, required this.onClick, required this.currentPage});
  final Function(int index) onClick;
  final int currentPage;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(35)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => widget.onClick(0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor:
                  widget.currentPage == 0 ? Colors.white : Colors.black,
              child: FaIcon(
                FontAwesomeIcons.house,
                color: widget.currentPage == 0 ? Colors.black : Colors.white,
              ).animate(target: widget.currentPage == 0 ? 1 : 0).scale(
                  begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
            ),
          ),
          GestureDetector(
            onTap: () => widget.onClick(1),
            child: CircleAvatar(
                    radius: 30,
                    backgroundColor:
                        widget.currentPage == 1 ? Colors.white : Colors.black,
                    child: Icon(
                      Icons.search,
                      size: 35,
                      color:
                          widget.currentPage == 1 ? Colors.black : Colors.white,
                    ))
                .animate(target: widget.currentPage == 1 ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),
          GestureDetector(
              onTap: () => widget.onClick(2),
              child: CircleAvatar(
                radius: 30,
                backgroundColor:
                    widget.currentPage == 2 ? Colors.white : Colors.black,
                child: FaIcon(
                  FontAwesomeIcons.user,
                  color: widget.currentPage == 2 ? Colors.black : Colors.white,
                ).animate(target: widget.currentPage == 2 ? 1 : 0).scale(
                    begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
              )),
        ],
      ),
    );
  }
}