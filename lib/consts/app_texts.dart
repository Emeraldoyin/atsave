import '/model/slider_model.dart';
import '../view/widgets/onboarding_widget.dart';

List<SliderWidget> sliderList = [
  SliderWidget(
    slider: SliderModel(
        imagePath: 'assets/images/onboard_img1.png',
        description: 'Take Control of your Finances with EASYSAVE'),
  ),
  SliderWidget(
    slider: SliderModel(
        imagePath: 'assets/images/onboard_img2.png',
        description:
            'Stay on top of your finances and achieve your financial goals'),
  ),
  SliderWidget(
    slider: SliderModel(
        imagePath: 'assets/images/onboard_img3.png',
        description: 'Eliminate financial stress and never overspend again'),
  ),
  SliderWidget(
    slider: SliderModel(
        imagePath: 'assets/images/onboard_img4.png',
        description:
            'Secure your financial future and take charge of your money'),
  ),
];
