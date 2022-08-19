import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BodyEmptyTiket extends StatelessWidget {
  const BodyEmptyTiket({
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
          VerticalSpacing(),
          Text(
            'Anda belum memiliki Tiket, silahkan \nmelakukan pemesanan tiket terdahulu!!',
            style: TextStyle(
              color: Color(0xff333E63),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              height: 1.9,
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}