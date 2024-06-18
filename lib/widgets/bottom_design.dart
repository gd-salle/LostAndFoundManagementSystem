import 'package:flutter/material.dart';

class BottomDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 10,
            color: Colors.red,
          ),
          Container(
            height: 10,
            color: Colors.grey[300],
          ),
          Container(
            height: 60,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
