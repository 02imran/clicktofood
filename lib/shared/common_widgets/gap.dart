import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  final double size;
  final Axis direction;

  const Gap(
      this.size, {
        this.direction = Axis.vertical,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return direction == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }
}
