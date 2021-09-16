import 'package:eshop/model/bar_item.dart';
import 'package:eshop/utils/bar_style.dart';
import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem>? barItems;
  final Duration animationDuration;
  final Function? onBarTap;
  final BarStyle? barStyle;

  AnimatedBottomBar(
      {this.barItems,
      this.animationDuration = const Duration(milliseconds: 500),
      this.onBarTap,
      this.barStyle});
  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 20.0, top: 8.0, left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = [];

    for (int i = 0; i < widget.barItems!.length; i++) {
      BarItem item = widget.barItems![i];
      bool isSelected = selectedBarIndex == i;
      _barItems.add(
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              selectedBarIndex = i;
              widget.onBarTap!(selectedBarIndex);
            });
          },
          child: AnimatedContainer(
            duration: widget.animationDuration,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  30,
                ),
              ),
              color: isSelected
                  ? item.color!.withOpacity(0.15)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(
                  item.iconData,
                  color: isSelected ? item.color : Colors.grey[700],
                  size: widget.barStyle!.iconSize,
                ),
                SizedBox(
                  width: 5,
                ),
                AnimatedSize(
                  duration: widget.animationDuration,
                  vsync: this,
                  curve: Curves.easeInOut,
                  child: Text(
                    isSelected ? item.text! : "",
                    style: TextStyle(
                      color: item.color,
                      fontWeight: widget.barStyle!.fontWeight,
                      fontSize: widget.barStyle!.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _barItems;
  }
}
