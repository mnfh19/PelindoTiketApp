import 'package:flutter/material.dart';
import 'package:pelindo_travel/app_color.dart';

import '../size_config.dart';

class BodyNotLogin extends StatelessWidget {
  const BodyNotLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            height: getProportionateScreenHeight(304),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/tiket_kosong.png'),
              ),
            ),
          ),
          Spacer(),
          Text(
            'OOPPSS!!!',
            style: TextStyle(
              color: Color(0xff333E63),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Anda belum melakukan login, silahkan Login terlebih dahulu untuk mengakses aplikasi!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff333E63),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                height: 1.9,
              ),
            ),
          ),
          Spacer(flex: 2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            height: 50,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
