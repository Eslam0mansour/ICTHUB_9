import 'package:flutter/material.dart';
import 'package:icthubx/widgets/my_col_widget.dart';

class MyRow extends StatelessWidget {
  const MyRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCOl(
          icon: Icons.add_card,
          clr: Colors.red,
          txt: 'flight',
        ),
        MyCOl(
          icon: Icons.ac_unit,
          clr: Colors.yellow,
          txt: ' bbbbb',
        ),
        MyCOl(
          icon: Icons.access_time_rounded,
          clr: Colors.white,
          txt: 'cccccc',
        ),
        MyCOl(
          icon: Icons.add_alert_sharp,
          clr: Colors.brown,
          txt: 'aaaaa',
        ),
      ],
    );
  }
}
