// import 'package:flutter/material.dart';
// import 'package:pelindo_travel/app_color.dart';
// import 'package:pelindo_travel/screen/onboard/component/splash_content.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OnBoardScreen extends StatefulWidget {
//   const OnBoardScreen({Key key}) : super(key: key);

//   @override
//   _OnBoardScreenState createState() => _OnBoardScreenState();
// }

// class _OnBoardScreenState extends State<OnBoardScreen> {
//   final PageController _pageController = new PageController();
//   int currentPage = 0;
//   bool isLogin = false;
//   List<Map<String, String>> splashData = [
//     {
//       'image': "onboard1.png",
//       'title': "Cek Jadwal",
//       'description':
//           "Cek jadwal kapal dan harga tiket kapal \ndi Pelindo Travel App"
//     },
//     {
//       'image': "onboard2.png",
//       'title': "Pesan Tiket",
//       'description':
//           "Lakukan pemesanan tiket kapal secara cepat \ndan mudah dimana saja dan kapanpun"
//     },
//   ];

//   getId() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     if (localStorage.getString("id") != null) {
//       setState(() {
//         isLogin = true;
//       });
//     }
//   }

//   @override
//   void initState() {
//     getId();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               child: Expanded(
//                 flex: 3,
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (value) {
//                     setState(() {
//                       currentPage = value;
//                     });
//                   },
//                   itemCount: splashData.length,
//                   itemBuilder: (context, index) => SplashContent(
//                     image: splashData[index]['image'],
//                     title: splashData[index]['title'],
//                     description: splashData[index]['description'],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 color: Colors.white,
//                 child: Column(
//                   children: [
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ...List.generate(
//                           splashData.length,
//                           (index) => buildDot(index: index),
//                         ),
//                       ],
//                     ),
//                     Spacer(
//                       flex: 2,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, '/home');
//                             },
//                             child: Container(
//                               width: 100,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Color(0xff191D21), width: 0.72),
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Lewat',
//                                   style: TextStyle(
//                                     color: Color(0xff191D21),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Nunito',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               if (currentPage == splashData.length - 1) {
//                                 Navigator.pushReplacementNamed(
//                                     context, '/home');
//                               }
//                               _pageController.animateToPage(currentPage + 1,
//                                   duration: Duration(milliseconds: 150),
//                                   curve: Curves.bounceIn);
//                             },
//                             child: Container(
//                               width: 100,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: colorPrimary,
//                                 border: Border.all(
//                                     color: Color(0xff191D21), width: 0.72),
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Lanjut',
//                                   style: TextStyle(
//                                     color: Color(0xff191D21),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Nunito',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   buildDot({int index}) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       margin: EdgeInsets.only(right: 5),
//       height: 10,
//       width: 10,
//       decoration: BoxDecoration(
//         color: currentPage == index ? Colors.black : Colors.grey,
//         borderRadius: BorderRadius.circular(5),
//       ),
//     );
//   }
// }
