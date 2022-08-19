import 'package:flutter/material.dart';
import 'package:pelindo_travel/size_config.dart';

class VerifikasiScreen extends StatefulWidget {
  const VerifikasiScreen({ Key key}) : super(key: key);

  @override
  _VerifikasiScreenState createState() => _VerifikasiScreenState();
}

class _VerifikasiScreenState extends State<VerifikasiScreen> {
  // FocusNode? pin1FocusNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    // pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    // pin1FocusNode!.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void focusField(String value, FocusNode focusNode) {
      focusNode.requestFocus();
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
                  padding: const EdgeInsets.only(top: 40, bottom: 31, left: 60, right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(15),
                          ),
                          color: Color(0xffE0E0E0),
                        ),
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          autofocus: true,
                          // focusNode: pin1FocusNode,
                          // obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenWidth(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // maxLength: 1,
                          onChanged: (value) {
                            if (value != '') {
                            focusField(value, pin2FocusNode);
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(15),
                          ),
                          color: Color(0xffE0E0E0),
                        ),
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          focusNode: pin2FocusNode,
                          // obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenWidth(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // maxLength: 1,
                          onChanged: (value) {
                            if (value != '') {
                            focusField(value, pin3FocusNode);
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(15),
                          ),
                          color: Color(0xffE0E0E0),
                        ),
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          focusNode: pin3FocusNode,
                          // obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenWidth(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // maxLength: 1,
                          onChanged: (value) {
                            if (value != '') {
                            focusField(value, pin4FocusNode);
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(15),
                          ),
                          color: Color(0xffE0E0E0),
                        ),
                        width: getProportionateScreenWidth(50),
                        child: TextFormField(
                          focusNode: pin4FocusNode,
                          // obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenWidth(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // maxLength: 1,
                          onChanged: (value) {
                            if (value != '') {
                            pin4FocusNode.unfocus();
                            // Then you need to check is the code is correct or not
                            }
                          },
                        ),
                      ),
                    ],
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
              TextButton(
                onPressed: () {},
                child: Container(
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
