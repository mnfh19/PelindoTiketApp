import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pelindo_travel/api/api.dart';
import 'package:pelindo_travel/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_color.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;
  TextEditingController emailC = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  _sendAgain() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'email': emailC.text,
    };

    var res = await ApiService().postData(data, '/sendAgain');
    var body = json.decode(res.body);
    print(body);
    if (body['respon']) {
      Navigator.pop(context);

      localStorage.setString('email_temp', emailC.text);
      EasyLoading.dismiss();
      emailC.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Kode Verifikasi Telah Terkirim Silahkan Cek Email Anda"),
      ));
    } else {
      EasyLoading.dismiss();
      // _showMsg(body['msg']);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(body['msg']),
      ));
    }
  }

  _verif() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'email': localStorage.getString('email_temp'),
      'pin': currentText,
    };

    var res = await ApiService().postData(data, '/pin');
    var body = json.decode(res.body);
    print(body);
    if (body['respon']) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      localStorage.clear();
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(body['msg']),
      ));
    } else {
      EasyLoading.dismiss();
      // _showMsg(body['msg']);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(body['msg']),
      ));
    }
  }

  _kirimUlang() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Masukkan Email Anda'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailC,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => _sendAgain(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  // width: 150,
                  // height: 20,
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Kirim Kode Verifikasi',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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
          'Kode Verifikasi',
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
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(),
              Text(
                'Masukkan OTP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              VerticalSpacing(),
              Center(
                child: Text(
                  'Masukan 4 kode yang telah dikirim ke \nemail anda',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Form(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 40, bottom: 10, left: 60, right: 60),
                  child: PinCodeTextField(
                    appContext: context,
                    // backgroundColor: Colors.white,
                    pastedTextStyle: TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    // obscureText: true,
                    // obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      // if (v!.length < 3) {
                      //   return "I'm from validator";
                      // } else {
                      //   return null;
                      // }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      activeColor: Color(0xffe0e0e0),
                      selectedFillColor: Colors.white,
                      selectedColor: colorPrimary,
                      inactiveFillColor: Color(0xffe0e0e0),
                      inactiveColor: Color(0xffe0e0e0),
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 31),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum menerima kode?',
                      style: TextStyle(
                        color: Color(0xffAAAAAA),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _kirimUlang(),
                      child: Text(
                        'Kirim Ulang',
                        style: TextStyle(
                          color: Color(0xff38AFF2),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                  onPressed: () => _verif(),
                  child: Center(
                    child: Text(
                      'VERIFIKASI',
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
            ],
          ),
        ),
      ),
    );
  }
}
