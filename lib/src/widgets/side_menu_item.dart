import 'package:flutter/material.dart';
import 'package:ventas_restobar/src/utils/constants.dart';
import 'package:ventas_restobar/src/utils/responsive.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    this.isActive,
    this.showBorder = false,
    required this.title,
    required this.press,
    required this.color,
  }) : super(key: key);

  final bool? isActive, showBorder;
  final Color color;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return InkWell(
      onTap: press,
      child: Container(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: responsive.ip(1.2),
                  fontWeight: FontWeight.bold,
                  color: color,
                  decoration: showBorder! ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: kOrangeColor,
                  decorationThickness: 4,
                ),
          ),
        ),
      ),
    );
  }
}
