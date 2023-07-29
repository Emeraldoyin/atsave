import 'package:easysave/consts/app_images.dart';

import '../model/category.dart';
import '/model/slider_model.dart';
import '../view/widgets/onboarding_widget.dart';

///the texts used on the onboarding screens are contained here

List<SliderWidget> sliderList = [
  SliderWidget(
    slider: SliderModel(
        imagePath: image1,
        description: 'Take Control of your Finances with EASYSAVE'),
  ),
  SliderWidget(
    slider: SliderModel(
        imagePath: image2,
        description:
            'Stay on top of your finances and achieve your financial goals'),
  ),
  SliderWidget(
    slider: SliderModel(
        imagePath: image3,
        description: 'Eliminate financial stress and never overspend again'),
  ),
  SliderWidget(
    slider: SliderModel(
        imagePath: image4,
        description:
            'Secure your financial future and take charge of your money'),
  ),
];

///A list that corresponds with that of firebase used for displaying icons
///
List<Category> categoryList = [
  Category(name: 'Food', imagePath: image6),
  Category(name: 'Auto & Gas', imagePath: image7),
  Category(name: 'Events', imagePath: image8),
  Category(name: 'Family Needs', imagePath: image9),
  Category(name: 'Apartment', imagePath: image10),
  Category(name: 'Utility Bills', imagePath: image11),
  Category(name: 'Travels', imagePath: image12),
  Category(name: 'Books/Study', imagePath: image13),
  Category(name: 'Personal needs', imagePath: image14),
  Category(name: 'Non-specified', imagePath: image15),
];

