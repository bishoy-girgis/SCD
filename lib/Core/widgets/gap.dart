import 'package:flutter/material.dart';
class GapH extends StatelessWidget {
  const GapH({super.key, required this.h});
  final double h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:  MediaQuery.of(context).size.height * (h / 100),
    );
  }
}

class GapW extends StatelessWidget {
  const GapW({super.key, required this.w});
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  MediaQuery.of(context).size.width * (w / 100),
    );
  }
}
