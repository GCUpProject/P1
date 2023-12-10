import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
