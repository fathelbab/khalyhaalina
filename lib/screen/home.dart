// import 'package:eshop/constant/constant.dart';
// import 'package:eshop/data/service/services.dart';
// import 'package:eshop/model/CityData.dart';
// import 'package:eshop/model/category_data.dart';
// import 'package:eshop/model/supplier_data.dart';
// import 'package:eshop/provider/category_provider.dart';
// import 'package:eshop/provider/supplier_provider.dart';
// import 'package:eshop/screen/product_screen.dart';
// import 'package:eshop/widget/homew.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class HomeScreen extends StatefulWidget {
//   static const String route = "/category_screen";

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Category> categoryList = [];
//   List<Supplier> supplierList = [];
//   int intialId = 0;
//   ScrollController _categoryScrollController = new ScrollController();
//   int limit = 20;
//   bool isLoaded = false;
//   String cityId = "";
//   String categoryId = "";
//   String _selectedCity;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     super.initState();

//     Provider.of<CategoryProvider>(context, listen: false)
//         .fetchCategoryList(1, limit);

//     // Provider.of<CityProvider>(context, listen: false).fetchCityList(1, limit);

//     _categoryScrollController.addListener(() {
//       if (_categoryScrollController.position.pixels ==
//           _categoryScrollController.position.maxScrollExtent) {
//         limit += 5;
//         Provider.of<CategoryProvider>(context, listen: false)
//             .fetchCategoryList(1, limit);
//         // getAllCity(1, 100);
//       } else {}
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     categoryList = Provider.of<CategoryProvider>(context).categoryList;
//     // cityList = Provider.of<CityProvider>(context).cityList;

//     return FutureBuilder(
//         future: getAllCity(1, limit),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return new Text('No Data available');
//             case ConnectionState.waiting:
//               return Scaffold(
//                 appBar: AppBar(
//                   title: Text("Suppliers"),
//                 ),
//                 drawer: mainDrawer(),
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             default:
//               if (snapshot.hasError)
//                 return new Text('Error: ${snapshot.error}');
//               else {
//                 var cityList = snapshot.data;
//                 cityId = cityList[0].id.toString();
//                 Provider.of<SupplierProvider>(context, listen: false)
//                     .fetchSupplierList(categoryId, cityId, 1, limit);

//                 return Homew(cityList: cityList);
//               }
//           }
//         });
//   }

//   Scaffold buildScaffold(AsyncSnapshot snapshot, List<City> cityList) {
//     supplierList = Provider.of<SupplierProvider>(context).supplierList;
//     print("object");
//     String cityName = cityList[0].name;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("E-Shop"),
//       ),
//       drawer: mainDrawer(),
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               // alignment: Alignment.centerRight,
//               child: DropdownButton(
//                   hint: Text(cityName),
//                   value: _selectedCity,
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedCity = newValue;
//                       cityName = _selectedCity;
//                       print(_selectedCity);
//                       cityId = cityList
//                               .firstWhere(
//                                   (city) => (city.name == _selectedCity))
//                               .id
//                               .toString() ??
//                           "";
//                     });
//                     Provider.of<SupplierProvider>(context, listen: false)
//                         .fetchSupplierList(categoryId, cityId, 1, limit);
//                   },
//                   items: cityList
//                       .map(
//                         (city) => DropdownMenuItem(
//                           value: city.name,
//                           child: Text(city.name ?? ""),
//                         ),
//                       )
//                       .toList()),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: supplierList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       print("object");
//                       Navigator.pushNamed(context, ProductScreen.route,
//                           arguments: {
//                             "supplierId": supplierList[index].id.toString(),
//                             "categoryId": categoryId
//                           });
//                     },
//                     leading: supplierList[index].imagePath == null
//                         ? Text("")
//                         : Container(
//                             width: 50,
//                             height: 50,
//                             child: CachedNetworkImage(
//                               imageUrl:
//                                   imagePath + supplierList[index].imagePath,
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) =>
//                                   Center(child: CircularProgressIndicator()),
//                               errorWidget: (context, url, error) =>
//                                   Icon(Icons.error),
//                             ),
//                           ),
//                     title: Text(supplierList[index].name),
//                     subtitle: Text(supplierList[index].categoryName ?? ""),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _categoryScrollController.dispose();
//   }

//   Widget mainDrawer() {
//     return Drawer(
//       child: ListView.builder(
//         controller: _categoryScrollController,
//         itemCount: categoryList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {
//               Navigator.pop(context);
//               setState(() {
//                 categoryId = categoryList[index].id.toString();
//               });
//             },
//             trailing: Icon(Icons.arrow_forward_ios),
//             title: Text(
//               categoryList[index].name,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
