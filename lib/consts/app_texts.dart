import 'package:easysave/consts/app_images.dart';

import '/model/slider_model.dart';
import '../model/category.dart';
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
  Category(name: 'Food', imagePath: image6, id: 1),
  Category(name: 'Auto & Gas', imagePath: image7, id: 2),
  Category(name: 'Events', imagePath: image8, id: 3),
  Category(name: 'Family Needs', imagePath: image9, id: 4),
  Category(name: 'Apartment', imagePath: image10, id: 5),
  Category(name: 'Utility Bills', imagePath: image11, id: 6),
  Category(name: 'Travels', imagePath: image12, id: 7),
  Category(name: 'Pets', imagePath: image13, id: 8),
  Category(name: 'Personal needs', imagePath: image14, id: 9),
  Category(name: 'Non-specified', imagePath: image15, id: 10),
];
