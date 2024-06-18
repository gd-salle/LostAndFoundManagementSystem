import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 185,
      left: MediaQuery.of(context).size.width / 2 - 185,
      child: Opacity(
        opacity: 0.1, 
        child: Image.asset(
          'assets/images/university_logo.png', 
          width: 370,
          height: 370,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
