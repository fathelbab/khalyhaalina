import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/category_data.dart';
import 'package:eshop/model/doctor_data.dart' hide City;
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/product_details_data.dart' hide Supplier;
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/provider/announcement_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/images_provider.dart';
import 'package:eshop/provider/notification_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/city/city_screen.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:eshop/widget/badge.dart';
import 'package:eshop/widget/custom_city_dropdown_button.dart';
import 'package:eshop/widget/custom_doctor_specialist_dropdown.dart';
import 'package:eshop/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/model/notification_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart/cart_screen.dart';
import 'doctor_details_screen.dart';
import 'search/search_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const String route = "/category_screen";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Map<String, dynamic>> categoryList = [
    {"id": 1, "name": "الماركت"},
    {"id": 2, "name": "ملابس رجالي"},
    {"id": 3, "name": "ملابس حريمي"},
    {"id": 4, "name": "ملابس أطفال"},
    {"id": 16, "name": "بصريات"},
    {"id": 8, "name": "الموبايلات"},
    {"id": 22, "name": "مستلزمات المطبخ"},
    {"id": 10, "name": "العقارات"},
    {"id": 11, "name": "الاثاث المنزلي"},
    {"id": 12, "name": "المطاعم و الكافيهات"},
    {"id": 14, "name": "التبريد و التكييف"},
    {"id": 15, "name": "هدايا وأكسسوارات"},
    {"id": 13, "name": "الصيدليات"},
    {"id": 23, "name": "حلويات"},
    {"id": 21, "name": "العطاره"},
    {"id": 20, "name": "مسليات "},
    {"id": 19, "name": "قطع غيار سيارات"},
    {"id": 17, "name": "المسكرات"},
    {"id": 9, "name": "الأجهزة الكهربائية "},
    {"id": 7, "name": "أحذيه أطفال"},
    {"id": 6, "name": "أحذيه حريمي"},
    {"id": 5, "name": "أحذيه رجالي"},
  ];
  List<IconData> categoryIcon = [
    Icons.store,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.glasses,
    FontAwesomeIcons.mobile,
    FontAwesomeIcons.tools,
    FontAwesomeIcons.building,
    FontAwesomeIcons.chair,
    FontAwesomeIcons.coffee,
    Icons.devices_other,
    FontAwesomeIcons.gifts,
    Icons.medical_services,
    Icons.shop,
    Icons.store,
    Icons.store,
    Icons.car_repair,
    Icons.local_drink,
    Icons.electrical_services,
    Icons.store,
    Icons.store,
    Icons.store,
  ];
  List<City> cityList = [];
  List<DoctorSpecialistt> doctorSpeciaList = [];
  List<AnnouncementData> announcementList = [];
  List<Notifications> notificationsList = [];
  List<ImageData> imageList = [];
  List<Supplier> supplierList = [];
  List<DoctorInfo> doctorList = [];
  List<Product> productHotList = [];

  int intialId = 0;
  ScrollController _categoryScrollController = new ScrollController();
  int limit = 50;
  bool isLoaded = false;
  bool isDoctor = false;
  String cityId = "0";
  String categoryId = "0";
  String _selectedCity;
  String _doctorSpcialistId;

  String _selectedDoctorSpecialist;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    // Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    // Provider.of<CategoryProvider>(context, listen: false)
    //     .fetchCategoryList(1, limit);
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductHotList("0", categoryId, 1, limit);
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctorList("0");
    Provider.of<Cart>(context, listen: false).fetchCartList();
    Provider.of<CityProvider>(context, listen: false).fetchCityList(1, limit);
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctorSpecialist();
    Provider.of<AnnouncementProvider>(context, listen: false)
        .fetchAnnouncementList();
    Provider.of<SupplierProvider>(context, listen: false)
        .fetchSupplierList(categoryId, 1, limit);
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotificationList();
    Provider.of<ImagesProvider>(context, listen: false).fetchImageList();
    _categoryScrollController.addListener(() {
      if (_categoryScrollController.position.pixels ==
          _categoryScrollController.position.maxScrollExtent) {
        limit += 5;
        Provider.of<CategoryProvider>(context, listen: false)
            .fetchCategoryList(1, limit);
        getAllCity(1, 100);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // categoryList = Provider.of<CategoryProvider>(context).categoryList;
    // cityList = Provider.of<CityProvider>(context, listen: false).cityList;

    announcementList =
        Provider.of<AnnouncementProvider>(context).announcementList;
    notificationsList =
        Provider.of<NotificationProvider>(context).notificationList;
    imageList = Provider.of<ImagesProvider>(context).imagesList;
    supplierList = Provider.of<SupplierProvider>(context).supplierList;
    doctorList = Provider.of<DoctorProvider>(context).doctorList;
    productHotList = Provider.of<ProductProvider>(context).productHotList;

    return buildScaffold(supplierList);

    // : NoInternet();
  }

  Scaffold buildScaffold(supplierList) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: FittedBox(
          child: Image.asset(
            'assets/images/app_logo.png',
            fit: BoxFit.cover,
            height: kToolbarHeight,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.of(context).pushNamed(CityScreen.route);
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              }),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.cartItems != null && cart.cartItems.length > 0
                  ? cart.cartItems.length.toString()
                  : "0.0",
              child: child,
              color: Colors.red,
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                }),
          ),
        ],
      ),
      drawer: mainDrawer(),
      body: isDoctor == false
          ? Container(
              child: ListView(
                children: [
                  buildAnnouncementSlider(),
                  buildMainCategoryListView(),
                  buildImagesSlider(),
                  buildProductHotList(),
                  buildNotificationsSlider(),
                  supplierList == null || supplierList.isEmpty
                      ? Text("")
                      : GridView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: supplierList.length,

                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          ///
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print("object");
                                Navigator.pushNamed(
                                    context, ProductScreen.route, arguments: {
                                  "supplierId":
                                      supplierList[index].id.toString(),
                                  "categoryId": categoryId
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70.0,
                                      width: 65.0,
                                      child: CachedNetworkImage(
                                        imageUrl: imagePath +
                                            supplierList[index].imagePath,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      supplierList[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      supplierList[index].categoryName ?? "",
                                      style: TextStyle(
                                          color: Color(0xFF575E67),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            )
          : SingleChildScrollView(
            
            child: Container(
                child: Column(
                  children: [
                    // isDoctor=true
                    CustomDoctorDropDownButton(),
                    doctorList == null || doctorList.isEmpty
                        ? Expanded(
                            child:
                                Center(child: Text("لايوجد طبيب فى هذه المنطقة")))
                        : GridView.builder(
                            padding: const EdgeInsets.all(5),
                            itemCount: doctorList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print("object");
                                  Navigator.pushNamed(
                                    context,
                                    DoctorDetailsScreen.route,
                                  );
                                  Provider.of<DoctorProvider>(context,listen: false)
                                      .getDoctorById(
                                          doctorList[index].id.toString());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 70.0,
                                        width: 65.0,
                                        child: CachedNetworkImage(
                                          imageUrl: imagePath +
                                              doctorList[index].imagePath,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        doctorList[index].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 15.0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            doctorList[index].phoneNumber ?? "",
                                            style: TextStyle(
                                                color: Color(0xFF575E67),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.phone,
                                            color: Theme.of(context).primaryColor,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _categoryScrollController.dispose();
  }

  Widget mainDrawer() {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: primaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "التخصصات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  controller: _categoryScrollController,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        // if (!isDoctor) {
                        Provider.of<SupplierProvider>(context, listen: false)
                            .fetchSupplierList(
                                categoryList[index]["id"].toString(), 1, limit);

                        setState(() {
                          isDoctor = false;
                        });
                      },
                      leading: Icon(
                        categoryIcon[index],
                        color: Colors.white,
                      ),
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: Colors.white,
                      // ),
                      title: Text(
                        categoryList[index]["name"],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.white,
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isDoctor = true;
                    });
                  },
                  title: Text(
                    "الدكتور",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderBuilder(int index, List<dynamic> list) {
    return Container(
      width: double.infinity,
      child: Image.network(
        imagePath + list[index].imagePath,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildAnnouncementSlider() {
    return announcementList != null && announcementList.isEmpty
        ? Text("")
        : Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: announcementList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return sliderBuilder(index, announcementList);
              },
              // items: imageSliders,
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
          );
  }

  Widget buildNotificationsSlider() {
    return notificationsList != null && notificationsList.isEmpty
        ? Text("")
        : Container(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: notificationsList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return sliderBuilder(index, notificationsList);
              },
              // items: imageSliders,
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
          );
  }

  Widget buildImagesSlider() {
    return imageList != null && imageList.isEmpty
        ? Text("")
        : Container(
            width: double.infinity,
            child: GridView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: imageList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2),
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CachedNetworkImage(
                      imageUrl: imagePath + imageList[index].imagePath,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  );
                }),
          );
  }

  Future<void> getCityId() async {
    final prefs = await SharedPreferences.getInstance();
    cityId = prefs.getString('cityId');
  }

  Widget buildProductHotList() {
    return productHotList == null || productHotList.isEmpty
        ? Text("")
        : GridView.builder(
            itemCount: productHotList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return ProductItems(product: productHotList[index], index: index);
            });
  }

  Widget buildMainCategoryListView() {
    return Container(
      height: 120,
      width: 120,
      child: ListView.builder(
        controller: _categoryScrollController,
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<SupplierProvider>(context, listen: false)
                  .fetchSupplierList(
                      categoryList[index]["id"].toString(), 1, limit);

              setState(() {
                isDoctor = false;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Center(
                      child: Icon(
                        categoryIcon[index],
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Text(
                  categoryList[index]["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0XFFE5A352),
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
          // return ListTile(
          //   onTap: () {
          //     Navigator.pop(context);
          //     // if (!isDoctor) {
          //     Provider.of<SupplierProvider>(context, listen: false)
          //         .fetchSupplierList(
          //             categoryList[index]["id"].toString(), 1, limit);

          //     setState(() {
          //       isDoctor = false;
          //     });
          //   },
          //   leading: Icon(
          //     categoryIcon[index],
          //     color: Colors.white,
          //   ),
          //   // trailing: Icon(
          //   //   Icons.arrow_forward_ios,
          //   //   color: Colors.white,
          //   // ),
          //   title: Text(
          //     categoryList[index]["name"],
          //     style: TextStyle(
          //         color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          //   ),
          // );
        },
      ),
    );
  }
}
