
// import 'package:easysave/config/theme/app_theme.dart';
// import 'package:flutter/material.dart';

// import '/model/slider_model.dart';

// class SliderWidget extends StatelessWidget {
//   const SliderWidget({super.key, required this.slider});
//   final SliderModel slider;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
      
//         Padding(
//           padding: const EdgeInsets.only(bottom: 250),
//           child: Center(
//             child: Container(
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: AppTheme.darkTheme.scaffoldBackgroundColor, width: 2.0)),
//               width: 300,
//               child: Center(
//                   child: CircleAvatar(
//                 radius: 150.0,
//                 backgroundColor: Colors.transparent,
//                 child: CircleAvatar(
//                   foregroundImage: AssetImage(slider.imagePath!),
//                   backgroundColor: Colors.white,
//                   radius: 130,
//                 ),
//               )),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           top: 300,
//           left: 0,
//           right: 0,
//           child: Container(
//             // height: 500,
//             // alignment: Alignment.bottomCenter,
//             decoration: const BoxDecoration(
//                 // color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20))),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 50),
//                     child: Text(
//                       slider.title!,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 35,
//                         //fontFamily: LOGO_FONT,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
//                   child: Text(
//                     slider.description!, 
//                     textAlign: TextAlign.center,
//                     softWrap: true,
//                     style: const TextStyle(fontFamily: 'Montserrat-Regular',
//                         fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
