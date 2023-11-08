import 'package:flutter/material.dart';

class RoundedBackgroundRectangle extends StatelessWidget {
  final Widget child;
  const RoundedBackgroundRectangle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: child,
        ));
  }
}
