import 'package:flutter/material.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/size_config.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff85D3FF),
        shadowColor: Color(0xff85D3FF),
        automaticallyImplyLeading: false,
        leadingWidth: 25,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff333E63),
          ),
        ),
        title: Text(
          'Lupa Password',
          style: TextStyle(
            color: Color(0xff181D2D),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpacing(),
            VerticalSpacing(),
            Container(
              padding: EdgeInsets.only(left: 16),
              width: getProportionateScreenWidth(300),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xffE8E8E8),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Image(
                      height: 12,
                      width: 17,
                      image: AssetImage(
                        'assets/icons/mail.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 17),
            Container(
              padding: EdgeInsets.only(left: 16),
              width: getProportionateScreenWidth(300),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xffE8E8E8),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  hintText: 'Password Baru',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    child: Image(
                      height: 14,
                      width: 10,
                      image: AssetImage(
                        'assets/icons/lock.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/kode-verifikasi');
              },
              child: Container(
                height: 45,
                width: 168,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(25),
                  // gradient: RadialGradient(
                  //   center: Alignment.topCenter,
                  //   radius: 45,
                  //   colors: [
                  //     Color(0xff38AFF2),
                  //     Color(0xff0ACDDA),
                  //   ],
                  // ),
                ),
                child: Center(
                  child: Text(
                    'UBAH PASSWORD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
