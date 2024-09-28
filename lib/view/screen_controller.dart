import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/home/home_screen.dart';
import 'package:histora/view/home/widgets/history_loading_screen.dart';

class ScreenController extends ConsumerStatefulWidget {
  static const String name = 'home';
  static const String path = '/';

  const ScreenController({super.key});

  @override
  ConsumerState<ScreenController> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends ConsumerState<ScreenController> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
     const tabs = <NavigationDestination>[
      NavigationDestination(
        icon: FaIcon(
          FontAwesomeIcons.house,
          color: Colors.white54,
          size: 20,
        ),
        label: 'Home',
        selectedIcon: FaIcon(
          FontAwesomeIcons.house,
          size: 22,
          color: Colors.white,
        ),
      ),
      NavigationDestination(
        icon: FaIcon(
          FontAwesomeIcons.searchengin,
          color: Colors.white54,
          size: 21,
        ),
        label: 'Search',
        selectedIcon: FaIcon(
          FontAwesomeIcons.searchengin,
          size: 23,
          color: Colors.white,
        ),
      ),
      NavigationDestination(
        icon: FaIcon(
          FontAwesomeIcons.user,
          size: 20,
          color: Colors.white54,
        ),
        label: 'Profile',
        selectedIcon: FaIcon(
          FontAwesomeIcons.user,
          size: 22,
          color: Colors.white,
        ),
      ),
    ];

    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade50,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 5,
                  centerTitle: true,
                  shadowColor: Colors.blue,
                  title: const Text(
                    'HISTORA',
                    style: TextStyle(
                        fontFamily: 'Rosarivo',
                        color: Colors.white,
                        letterSpacing: 13),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade700,
                            Colors.blue.shade500,
                            Color(0xFF00CCFF),
                            Colors.blue.shade500,
                            Colors.blue.shade700,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          tileMode: TileMode.clamp),
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                        Colors.blue,
                        Color(0xFF00CCFF),
                      ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          tileMode: TileMode.clamp)),
                  child: NavigationBar(
                    height: 60,
                    backgroundColor: Colors.transparent,
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    indicatorColor: Colors.transparent,
                    elevation: 0,
                    destinations: tabs,
                    selectedIndex: selected,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    onDestinationSelected: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: [
                    const HomeScreen(),
                    const HomeScreen(),
                    const HomeScreen()
                  ][selected],
                ),
              ),
            ),
            if (state is GPSLoading ||
                state is NearestStructureLoading ||
                state is MatchingImages ||
                state is DetailLoading)
              const HistoryLoadingScreen(),
          ],
        );
      },
    );
  }
}
