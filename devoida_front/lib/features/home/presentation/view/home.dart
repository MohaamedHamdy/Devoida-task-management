import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/features/board/presentation/view/BoardTasks.dart';
import 'package:devoida_front/features/board/presentation/view/board_screen.dart';
import 'package:devoida_front/features/home/presentation/view/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../workspace/presentation/view/workspace_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int currentIndex = 0;

  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  List screens = [
    const WorkspaceScreen(),
    const BoardScreen(),
    Container(),
    KanbanBoardSimple(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        // backgroundColor: Colors.white,
        elevation: 2.0,
        // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Colors.transparent,
        selectedIndex: currentIndex,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(Iconsax.people, color: Colors.white.withOpacity(0.5)),
            label: 'Workspace',
            selectedIcon: const Icon(Iconsax.people, color: kPrimaryBlue),
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.trello,
              color: Colors.white.withOpacity(0.5),
            ),
            selectedIcon: const Icon(
              FontAwesomeIcons.trello,
              color: kPrimaryBlue,
            ),
            label: 'Boards',
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0.w),
            child: NavigationDestination(
              label: 'Add',
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: const EdgeInsets.all(13.0),
                  child: const Center(
                    child: Icon(FontAwesomeIcons.plus, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.creditCard,
              color: Colors.white.withOpacity(0.5),
            ),
            selectedIcon: const Icon(
              FontAwesomeIcons.creditCard,
              color: kPrimaryBlue,
            ),
            label: 'Cards',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.profile_circle,
              color: Colors.white.withOpacity(0.5),
            ),
            selectedIcon: const Icon(
              Iconsax.profile_circle5,
              color: kPrimaryBlue,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
