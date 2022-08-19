import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BodyEmptyRiwayat extends StatelessWidget {
  const BodyEmptyRiwayat({  Key key }) : super(key: key);

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
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/riwayat_kosong.png'),
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
              'Riwayat Anda Kosong, Silahkan Melakukan Pemesanan Terlebih Dahulu',
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