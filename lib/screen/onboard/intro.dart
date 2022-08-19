import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pelindo_travel/screen/beranda/beranda_screen.dart';
import 'package:pelindo_travel/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('introkun', "true");
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "Cek Jadwal",
          body:
              "Cek jadwal kapal dan harga tiket kapal \ndi Pelindo Travel App",
          image: Center(
            child: Image.asset("assets/images/onboard1.png", height: 175.0),
          ),
        ),
        PageViewModel(
          title: "Pesan Tiket",
          body:
              "Lakukan pemesanan tiket kapal secara cepat dan mudah dimana saja dan kapanpun",
          image: Center(
            child: Image.asset("assets/images/onboard2.png", height: 175.0),
          ),
        )
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
