import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/app_color.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;

  TextEditingController userC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController telpC = TextEditingController();
  TextEditingController passC = TextEditingController();

  _register() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'username': userC.text,
      'telp': telpC.text,
      'email': emailC.text,
      'pass': passC.text,
    };

    var res = await ApiService().postData(data, '/register');
    var body = json.decode(res.body);
    print(body);
    if (body['respon']) {
      localStorage.setString('email_temp', emailC.text);
      Navigator.pushNamed(context, '/kode-verifikasi');
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      // _showMsg(body['msg']);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(body['msg']),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          'Daftar',
          style: TextStyle(
            color: Color(0xff181D2D),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight * 0.87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 29),
              Center(
                child: Text(
                  'Silahkan mengisi data anda dengan benar',
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 31),
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
                  controller: userC,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    hintText: 'Nama Lengkap',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Image(
                        height: 16,
                        width: 19,
                        image: AssetImage(
                          'assets/icons/user.png',
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
                  controller: telpC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    hintText: 'Telepon',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Image(
                        height: 18,
                        width: 14,
                        image: AssetImage(
                          'assets/icons/smartphone.png',
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
                  controller: emailC,
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
                  controller: passC,
                  obscureText: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    hintText: 'Password',
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
              SizedBox(height: 27),
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(-8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 23),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Dengan mendaftar berarti Anda menyetujui',
                              style: TextStyle(
                                color: Color(0xff324A59),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'syarat dan ketentuan',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              Text(
                                ' yang berlaku.',
                                style: TextStyle(
                                  color: Color(0xff324A59),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 45,
                width: 168,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 45,
                    colors: [
                      Color(0xff38AFF2),
                      Color(0xff0ACDDA),
                    ],
                  ),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                 
                  onPressed: () => _register(),
                  child: Center(
                    child: Text(
                      'DAFTAR',
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: TextStyle(
                        color: Color(0xffAAAAAA),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Color(0xff38AFF2),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
