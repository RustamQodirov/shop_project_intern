import 'package:flutter/material.dart';
import 'package:shop/features/home/presentation/screens/home_page.dart';

class PositionedBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 53,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff040415).withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}