// import 'package:flutter/material.dart';

// class SplashContent extends StatelessWidget {
//   final image;
//   final title;
//   final description;

//   const SplashContent({
//     Key key,
//     this.image,
//     this.title,
//     this.description,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 35),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Spacer(
//             flex: 5,
//           ),
//           Image.asset('assets/images/$image'),
//           SizedBox(
//             height: 17,
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               color: Color(0xff333E63),
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Arial',
//             ),
//           ),
//           Spacer(
//             flex: 1,
//           ),
//           Text(
//             description,
//             style: TextStyle(
//               height: 1.9,
//               color: Color(0xff324A59),
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Poppins',
//             ),
//             textAlign: TextAlign.center,
//           ),
//           Spacer(
//             flex: 1,
//           ),
//         ],
//       ),
//     );
//   }
// }