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
    final tabs = <NavigationDestination>[
      NavigationDestination(
        icon: const FaIcon(
          FontAwesomeIcons.house,
          color: Colors.grey,
          size: 20,
        ),
        label: 'Home',
        selectedIcon: FaIcon(
          FontAwesomeIcons.house,
          size: 22,
          color: Colors.grey.shade700,
        ),
      ),
      NavigationDestination(
        icon: const FaIcon(
          FontAwesomeIcons.searchengin,
          color: Colors.grey,
          size: 21,
        ),
        label: 'Search',
        selectedIcon: FaIcon(
          FontAwesomeIcons.searchengin,
          size: 23,
          color: Colors.grey.shade700,
        ),
      ),
      NavigationDestination(
        icon: const FaIcon(FontAwesomeIcons.user, size: 20, color: Colors.grey),
        label: 'Profile',
        selectedIcon: FaIcon(
          FontAwesomeIcons.user,
          size: 22,
          color: Colors.grey.shade700,
        ),
      ),
    ];

    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 1,
                shadowColor: Colors.blueGrey.shade50,
                centerTitle: true,
                title: const Text(
                  'HISTORA',
                  style: TextStyle(fontFamily: 'Rosarivo'),
                ),
              ),
              bottomNavigationBar: NavigationBar(
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                // backgroundColor: Colors.black87,
                indicatorColor: Colors.transparent,
                elevation: 0,
                destinations: tabs,
                selectedIndex: selected,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                onDestinationSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
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
