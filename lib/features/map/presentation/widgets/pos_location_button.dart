import 'package:flutter/material.dart';

class PositionedLocationButton extends StatelessWidget {
  final VoidCallback onTap;

  const PositionedLocationButton({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 170,
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/location.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}