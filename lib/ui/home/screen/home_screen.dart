import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/providers/UserProvider.dart';
import 'package:evently_c16/ui/home/tabs/home_tab/HomeTab.dart';
import 'package:evently_c16/ui/home/tabs/love_tab/LoveTab.dart';
import 'package:evently_c16/ui/home/tabs/map_tab/MapTab.dart';
import 'package:evently_c16/ui/home/tabs/map_tab/providers/map_tab_provider.dart';
import 'package:evently_c16/ui/home/tabs/profile_tab/ProfileTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    ChangeNotifierProvider(
      create: (context) => MapTabProvider(),
      child: const MapTab(),
    ),
    const LoveTab(),
    const ProfileTab(),
  ];
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        child: const Icon(Icons.add, size: 40),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/home.svg"),
            activeIcon: SvgPicture.asset("assets/images/home_selected.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/map.svg"),
            activeIcon: SvgPicture.asset("assets/images/map_selected.svg"),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/heart.svg"),
            activeIcon: SvgPicture.asset("assets/images/heart_selected.svg"),
            label: "Love",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/user.svg"),
            activeIcon: SvgPicture.asset("assets/images/user_selected.svg"),
            label: "Profile",
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
