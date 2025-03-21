import 'package:flutter/material.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/history_screen.dart';
import 'package:project/screens/list_station_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _bottomNavIndex;
  late List<(String, String)> _list;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _bottomNavIndex = 0;
    _list = [
      ('Trang Chủ', 'assets/home.png'),
      ('Lặp Lịch', 'assets/calendar.png'),
      ('Lịch Sử', 'assets/history.png'),
      ('Tài Khoản', 'assets/solid_people.png'),
    ];

    _screens = [
      HomeScreen(),
      ListStationScreen(),
      HistoryScreen(),
      Container()
    ];
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_list[_bottomNavIndex].$1),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: _screens[_bottomNavIndex],
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return SizedBox(
      height: 80,
      width: 80,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          onPressed: () {},
          shape: CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset(
              'assets/bk.png',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return AnimatedBottomNavigationBar.builder(
      height: 75,
      itemCount: _list.length,
      tabBuilder: (index, isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _list[index].$2,
              width: 40,
              height: 40,
              color: isActive ? Color(0xFF042B90) : Colors.white,
            ),
            Text(
              _list[index].$1,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Color(0xFF042B90) : Colors.white,
              ),
            ),
          ],
        );
      },
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      leftCornerRadius: 12,
      rightCornerRadius: 12,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      backgroundColor: Color(0xFF1487DA).withAlpha(153),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
