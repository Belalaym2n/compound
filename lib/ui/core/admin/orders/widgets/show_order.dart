import 'package:flutter/cupertino.dart';

class ShowOrder extends StatelessWidget {
  ShowOrder({
    super.key,
    required this.message,
    required this.heading,
  });

  String heading;
  String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(heading), Text(message)],
    );
  }
}
