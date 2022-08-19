import 'package:flutter/material.dart';

class RincianPemesanWidget extends StatelessWidget {
  final namaPemesan;
  final emailPemesan;
  final noHpPemesan;
  const RincianPemesanWidget({
     Key key,
     this.namaPemesan,
     this.emailPemesan,
     this.noHpPemesan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 110,
              child: Text(
                'Nama Pemesan',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  ': $namaPemesan',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Container(
              width: 110,
              child: Text(
                'Email',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  ': $emailPemesan',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Container(
              width: 110,
              child: Text(
                'No. Hp',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  ': $noHpPemesan',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}