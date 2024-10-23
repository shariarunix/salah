import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salah/models/feature_model.dart';
import 'package:salah/utils/image_utils.dart';

class FeaturesRow extends StatelessWidget {

  final void Function(int index) onPressed;

  FeaturesRow({super.key, required this.onPressed});

  final List<FeatureModel> featuresList = [
    FeatureModel(icon: ImageUtils.APP_LOGO_SVG, title: 'Al-Quran'),
    FeatureModel(icon: ImageUtils.APP_LOGO_SVG, title: 'Hadith'),
    FeatureModel(icon: ImageUtils.APP_LOGO_SVG, title: 'Dua'),
    FeatureModel(icon: ImageUtils.APP_LOGO_SVG, title: 'Tasbih'),
    FeatureModel(icon: ImageUtils.APP_LOGO_SVG, title: 'Qibla'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < featuresList.length; i++)
          Column(
              children: [
                GestureDetector(
                  onTap: (){
                    onPressed(i);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        featuresList[i].icon,
                        height: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  featuresList[i].title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
      ],
    );
  }
}
