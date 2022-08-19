import 'package:flutter/material.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/screen/akun/akun_screen.dart';
import 'package:pelindo_travel/screen/beranda/beranda_screen.dart';
import 'package:pelindo_travel/screen/home/component/BottomNavBarWidget.dart';
import 'package:pelindo_travel/screen/tiket/tiket_screen.dart';
import 'package:pelindo_travel/widget/body_notlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  bool isLogin = false;

  getId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (localStorage.getString("id") != null) {
      setState(() {
        isLogin = true;
      });
    }
  }

  final screens = [
    BerandaScreen(),
    TiketScreen(),
    AkunScreen(),
  ];

  final screensNotLogin = [
    BerandaScreen(),
    BodyNotLogin(),
    BodyNotLogin(),
  ];

  @override
  void initState() {
    getId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin?screens[currentIndex]:screensNotLogin[currentIndex],
      bottomNavigationBar: BottomNavBarWidget(
        backgroundColor: Colors.white,
        color: Colors.grey,
        selectedColor: colorPrimary,
        onTabSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavBarWidgetItem(
              iconData: 'assets/icons/home.svg', text: 'Beranda'),
          BottomNavBarWidgetItem(
              iconData: 'assets/icons/tiket.svg', text: 'Tiket'),
          BottomNavBarWidgetItem(
              iconData: 'assets/icons/akun.svg', text: 'Akun'),
        ],
      ),
    );
  }
}
