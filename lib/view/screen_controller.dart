import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/state/history_feature/bloc/history_bloc.dart';
import 'package:histora/view/explore/explore_screen.dart';
import 'package:histora/view/home/home_screen.dart';
import 'package:histora/view/home/widgets/history_loading_screen.dart';
import 'package:histora/view/profile/profile_screen.dart';

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
    final tabs = <NavigationDestination>[
      NavigationDestination(
        icon: FaIcon(
          FontAwesomeIcons.house,
          color: Colors.grey,
          size: 20,
        ),
        label: 'Home',
        selectedIcon: FaIcon(
          FontAwesomeIcons.house,
          size: 22,
          color: Colors.blue.shade400,
        ),
      ),
      NavigationDestination(
        icon: FaIcon(
          FontAwesomeIcons.searchengin,
          color: Colors.grey,
          size: 21,
        ),
        label: 'Search',
        selectedIcon: FaIcon(
          FontAwesomeIcons.searchengin,
          size: 23,
          color: Colors.blue.shade400,
        ),
      ),
      NavigationDestination(
        icon: FaIcon(
          FontAwesomeIcons.user,
          size: 20,
          color: Colors.grey,
        ),
        label: 'Profile',
        selectedIcon: FaIcon(
          FontAwesomeIcons.user,
          size: 22,
          color: Colors.blue.shade400,
        ),
      ),
    ];

    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.grey.shade200,
              bottomNavigationBar: Container(
               child: NavigationBar(
                  height: 80,
                  backgroundColor: Colors.white,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  shadowColor: Colors.grey,
                  indicatorColor: Colors.transparent,
                  elevation: 10,
                  destinations: tabs,
                  selectedIndex: selected,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  onDestinationSelected: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                ),
              ),
              body: [
                const HomeScreen(),
                const ExploreScreen(),
                const ProfileScreen()
              ][selected],
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
