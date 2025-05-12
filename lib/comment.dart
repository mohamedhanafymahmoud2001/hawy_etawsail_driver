//home

// Row(children: [
//   Expanded(
//     child: Container(
//       width: double.infinity,
//       height: 80,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xFFF6F6F6),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "طلباتك ",
//                 style: AppTextStyles.style12W500(context),
//               ),
//             ],
//           ),
//           Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "13",
//                 style: AppTextStyles.style16W400(context)
//                     .copyWith(fontFamily: "Lemonada"),
//               ),
//               Text(
//                 " طلب توصيل",
//                 style: AppTextStyles.style12W500(context).copyWith(
//                     color: AppColors.greenWhite,
//                     fontFamily: "Lemonada"),
//               ),
//             ],
//           ),
//           Spacer(),
//         ],
//       ),
//     ),
//   ),
//   SizedBox(
//     width: 16,
//   ),
//   Expanded(
//     child: Container(
//       height: 80,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xFFF6F6F6),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "رصيدك ",
//                 style: AppTextStyles.style12W500(context),
//               ),
//             ],
//           ),
//           Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "1333",
//                 style: AppTextStyles.style16W400(context)
//                     .copyWith(fontFamily: "Lemonada"),
//               ),
//               Text(
//                 " ريال سعودي",
//                 style: AppTextStyles.style12W500(context).copyWith(
//                     color: AppColors.greenWhite,
//                     fontFamily: "Lemonada"),
//               ),
//             ],
//           ),
//           Spacer(),
//         ],
//       ),
//     ),
//   ),
// ]),


//GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const MyOrder(),
//       ),
//     );
//   },
//   child: Container(
//     width: double.infinity,
//     height: 80,
//     decoration: BoxDecoration(
//       color: Color(0xFF464855),
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Stack(children: [
//       Positioned(
//         top: 0,
//         right: 3,
//         child: Image.asset(
//           Assets.imagesShapes,
//         ),
//       ),
//       Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.white,
//                 size: 16,
//               ),
//               SizedBox(
//                 width: 8,
//               ),
//               Text(
//                 "طلباتي",
//                 style: AppTextStyles.style16W400(context).copyWith(
//                   color: AppColors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Spacer(),
//               Image.asset(
//                 Assets.imagesBox,
//                 width: 40,
//               ),
//             ],
//           ),
//         ),
//       )
//     ]),
//   ),
// ),
