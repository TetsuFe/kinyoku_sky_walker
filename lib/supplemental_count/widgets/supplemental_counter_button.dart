import 'package:flutter/material.dart';
import 'package:kinyoku_continue/supplemental_count/widgets/supplemental_counter_page.dart';

class SupplementalCounterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        width: 60,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                settings: const RouteSettings(name: '/supplementalCounter'),
                builder: (BuildContext context) =>
                    const SupplementalCounterPage()));
          },
          icon: const Icon(
            Icons.add_circle_outline,
          ),
        ),
      ),
      const Text(
        '補助',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
