// import 'package:flutter/material.dart';
// import 'package:icthubx/data/data_source/products_data_source.dart';
// import 'package:icthubx/screens/product_screen.dart';
//
// class ItemOfList extends StatelessWidget {
//   final int index;
//   const ItemOfList({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductScreen(
//               dataK: DataSource.myList[index],
//             ),
//           ),
//         );
//       },
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.2,
//         width: MediaQuery.of(context).size.width * 0.4,
//         decoration: BoxDecoration(
//           color: const Color(0xFFFFFFFF),
//           borderRadius: BorderRadius.circular(30),
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: Image.network(
//               DataSource.myList[index].image,
//             ).image,
//           ),
//         ),
//         alignment: Alignment.bottomCenter,
//         margin: const EdgeInsets.all(10),
//         child: Container(
//           height: 50,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30))),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Text(
//                   DataSource.myList[index].name,
//                 ),
//               ),
//               Text(
//                 '${DataSource.myList[index].price.toString()} EGP',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
