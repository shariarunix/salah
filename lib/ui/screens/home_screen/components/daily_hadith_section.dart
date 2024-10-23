import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salah/models/hadith_model.dart';

import 'hadith_card.dart';

class DailyHadithSection extends StatefulWidget {
  final List<HadithModel> hadithList;
  
  const DailyHadithSection({super.key, required this.hadithList});
  
  @override
  State<DailyHadithSection> createState() => _DailyHadithSectionState();
}

class _DailyHadithSectionState extends State<DailyHadithSection> {
  final _hadithPagerController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: PageView.builder(
            controller: _hadithPagerController,
            itemCount: widget.hadithList.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return HadithCard(hadith : widget.hadithList[index]);
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.hadithList.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentIndex == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
