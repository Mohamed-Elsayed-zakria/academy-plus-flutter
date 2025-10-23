import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCartIllustration extends StatelessWidget {
  const EmptyCartIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/undraw_empty-cart_574u.svg',
      height: 200,
      width: 200,
      fit: BoxFit.contain,
    );
  }
}
