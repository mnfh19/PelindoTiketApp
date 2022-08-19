import 'package:flutter/material.dart';

// ignore: must_be_immutable
class JumlahTiketField extends StatefulWidget {
  TextEditingController textController;
  Function() refreshState;
  JumlahTiketField({Key key, this.textController, this.refreshState})
      : super(key: key);

  @override
  _JumlahTiketFieldState createState() => _JumlahTiketFieldState();
}

class _JumlahTiketFieldState extends State<JumlahTiketField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffE8E8E8), width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                var jml = int.parse(widget.textController.text);
                if (jml >= 1) {
                  var newjml = jml - 1;
                  widget.textController.text = newjml.toString();
                  widget.refreshState();
                }
              });
            },
            child: Container(
              height: 20,
              width: 25,
              decoration: BoxDecoration(
                color: Color(0xff2596D7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.remove, color: Colors.white, size: 20),
            ),
          ),
          Expanded(
            child: TextField(
              enabled: false,
              controller: widget.textController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              // onChanged: widget.refreshState(),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                var jml = int.parse(widget.textController.text);
                var newjml = jml + 1;
                widget.textController.text = newjml.toString();
                widget.refreshState();
              });
            },
            child: Container(
              height: 20,
              width: 25,
              decoration: BoxDecoration(
                color: Color(0xff2596D7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
