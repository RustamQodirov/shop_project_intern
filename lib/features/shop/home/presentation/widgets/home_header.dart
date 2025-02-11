import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../map/presentation/screens/map_page.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Магазины',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen()));
          },

          icon: SvgPicture.asset(
            'assets/icons/icon.svg',
            width: 22,
            height: 22,
          ),
        ),
      ],
    );
  }
}
