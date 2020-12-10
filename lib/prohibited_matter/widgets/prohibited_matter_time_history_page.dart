import 'package:flutter/material.dart';
import 'package:kinyoku_continue/prohibited_matter/widgets/prohibited_matter_time_monthly_carousel.dart';
import 'package:kinyoku_continue/prohibited_matter/widgets/prohibited_matter_time_sum_card.dart';

class ProhibitedMatterTimeHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProhibitedMatterTimeSumCard(),
            const SizedBox(
              height: 16,
            ),
            Card(
              child: ProhibitedMatterTimeMonthlyCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}
