import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarWidgetItem {
  BottomNavBarWidgetItem({ this.iconData,  this.text});
  final iconData;
  String text;
}

class BottomNavBarWidget extends StatefulWidget {
  BottomNavBarWidget({
     this.items,
    //  this.centerItemText,
    this.height: 60.0,
    this.iconSize: 20.0,
     this.backgroundColor,
     this.color,
     this.selectedColor,
    //  this.notchedShape,
     this.onTabSelected,
  }) {
    // assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<BottomNavBarWidgetItem> items;
  // final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  // final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => BottomNavBarWidgetState();
}

class BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    // items.insert(items.length >> 1, _buildMiddleTabItem());

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: BottomAppBar(
        // shape: widget.notchedShape,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
        color: widget.backgroundColor,
      ),
    );
  }

  // Widget _buildMiddleTabItem() {
  //   return Expanded(
  //     child: SizedBox(
  //       height: widget.height,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           SizedBox(height: widget.iconSize),
  //           Text(
  //             widget.centerItemText,
  //             style: TextStyle(color: widget.color),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTabItem({
    BottomNavBarWidgetItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Icon(item!.iconData, color: color, size: widget.iconSize),
                SvgPicture.asset(
                  item.iconData,
                  color: color,
                  height: widget.iconSize,
                  width: widget.iconSize,
                ),
                SizedBox(height: 5,),
                Text(
                  item.text,
                  style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700 ,fontFamily: 'Quicksand'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
