import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/doctor_data.dart' hide City;
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/service_details_data.dart' hide City;
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/provider/announcement_provider.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/images_provider.dart';
import 'package:eshop/provider/notification_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/service_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/address/city_screen.dart';
import 'package:eshop/screen/address/governorate_screen.dart';
import 'package:eshop/screen/home/doctor_section.dart';
import 'package:eshop/screen/home/service_section.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/contants.dart';

import 'package:eshop/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/model/notification_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    {"id": 5, "name": "أحذيه رجالي"},
    {"id": 6, "name": "أحذيه حريمي"},
    {"id": 7, "name": "أحذيه أطفال"},

    {"id": 16, "name": "بصريات"},
    {"id": 8, "name": "الموبايلات"},
    {"id": 9, "name": "الأجهزة ومستلزمات المطبخ "},
    {"id": 10, "name": "العقارات"},
    {"id": 11, "name": " الاثاث المنزلي والمكتبى"},
    {"id": 12, "name": "المطاعم و الحلويات"},
    {"id": 14, "name": " فلاتر المياة والتبريد و التكييف"},
    {"id": 15, "name": "هدايا وأكسسوارات"},
    {"id": 13, "name": "الصيدلية"},
    // {"id": 23, "name": "حلويات"},
    // {"id": 21, "name": "العطاره"},
    // {"id": 20, "name": "مسليات "},
    // {"id": 19, "name": "قطع غيار سيارات"},
  ];
  List<Map<String, dynamic>> categoryIcon = [
    {"icons": Icons.store, "id": 1},
    {"icons": FontAwesomeIcons.tshirt, "id": 1},
    {"icons": "assets/images/jacket.png", "id": 2},
    {"icons": "assets/images/baby-clothes.png", "id": 2},
    {"icons": "assets/images/shoes.png", "id": 2},
    {"icons": "assets/images/high-heels.png", "id": 2},
    {"icons": "assets/images/baby-shoe.png", "id": 2},
    {"icons": FontAwesomeIcons.glasses, "id": 1},
    {"icons": FontAwesomeIcons.mobile, "id": 1},
    {"icons": Icons.electrical_services, "id": 1},
    {"icons": FontAwesomeIcons.building, "id": 1},
    {"icons": FontAwesomeIcons.chair, "id": 1},
    {"icons": FontAwesomeIcons.coffee, "id": 1},
    {"icons": Icons.devices_other, "id": 1},
    {"icons": FontAwesomeIcons.gifts, "id": 1},
    {"icons": Icons.medical_services, "id": 1},
  ];
  List<City> cityList = [];
  List<DoctorSpecialistt> doctorSpeciaList = [];
  List<AnnouncementData>? announcementList = [];
  List<Notifications>? notificationsList = [];
  List<ImageData>? imageList = [];
  List<Supplier>? supplierList = [];
  List<DoctorInfo>? doctorList = [];
  List<ServiceInfo>? serviceList = [];
  List<Product>? productHotList = [];

  int intialId = 0;
  ScrollController _categoryScrollController = new ScrollController();

  int limit = 20;
  bool isLoaded = false;
  bool isSearch = false;
  bool isDoctor = false;
  bool isService = false;
  bool isHome = true;
  String? cityId = "0";
  String categoryId = "0";
  // String? _selectedCity;
  // String? _doctorSpcialistId;

  // String? _selectedDoctorSpecialist;
  final _searchController = TextEditingController();
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

    /**
     * first load all service list from api
     * second load first service provider or service shop 
     */
    // Provider.of<ServiceProvider>(context, listen: false)
    //     .fetchServiceInfoList("0");
    Provider.of<ServiceProvider>(context, listen: false)
        .fetchServiceSpecialist()
        .then((serviceSpecialistList) {
      Provider.of<ServiceProvider>(context, listen: false)
          .fetchServiceInfoList(serviceSpecialistList![0].id.toString());
    });

    //load all doctor with All specialties
    // Provider.of<DoctorProvider>(context, listen: false).fetchDoctorList("0");
    Provider.of<DoctorProvider>(context, listen: false)
        .fetchDoctorSpecialist()
        .then((value) {
      Provider.of<DoctorProvider>(context, listen: false)
          .fetchDoctorList(value![0].id.toString());
    });

    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductHotList("0", categoryId, 1, limit);
    Provider.of<Cart>(context, listen: false).fetchCartList();

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
        elevation: 0,
        // centerTitle: true,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset(
            'assets/images/app_logo.png',
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [],
          // ),
          IconButton(
              icon: Icon(FontAwesomeIcons.language),
              onPressed: () {
                Navigator.of(context).pushNamed(GovernorateScreen.route);
              }),
          IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.of(context).pushNamed(GovernorateScreen.route);
              }),

          // IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(SearchScreen.route);
          //     }),
          // Consumer<Cart>(
          //   builder: (_, cart, child) => Badge(
          //     value: cart.cartItems != null && cart.cartItems!.length > 0
          //         ? cart.cartItems!.length.toString()
          //         : "0",
          //     child: child,
          //     color: Colors.red,
          //   ),
          //   child: IconButton(
          //       icon: Icon(Icons.shopping_cart),
          //       onPressed: () {
          //         Navigator.of(context).pushNamed(CartScreen.route);
          //       }),
          // ),
        ],
      ),
      drawer: mainDrawer(),
      body: scafoldBody(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _categoryScrollController.dispose();
    _searchController.dispose();
  }

  Widget mainDrawer() {
    return Theme(
      data: Theme.of(context).copyWith(
        // Set the transparency here
        canvasColor: Colors.black.withOpacity(
            0.5), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
      ),
      child: Drawer(
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://googleflutter.com/sample_image.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getString(context, "myAccount"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(
                    getString(context, "startShoping"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "changeLocation"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "profile"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "customerService"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "aboutUs"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "termsAndConditions"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "favourite"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                // ListTile(
                //   title: Text(
                //     getString(context, ""),
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   leading: Icon(
                //     Icons.home,
                //     color: Colors.white,
                //   ),
                //   onTap: () {
                //     setState(() {
                //       Navigator.pop(context);
                //       isHome = true;
                //       isLoaded = false;
                //       isDoctor = false;
                //       isService = false;
                //     });
                //   },
                // ),
                ListTile(
                  title: Text(
                    getString(context, "rateUs"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.rate_review,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    getString(context, "share"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isHome = true;
                      isLoaded = false;
                      isDoctor = false;
                      isService = false;
                    });
                  },
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isDoctor = true;
                      isService = false;
                    });
                  },
                  leading: Icon(
                    Icons.medical_services,
                    color: Colors.white,
                  ),
                  title: Text(
                    "الدكتور",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      isService = true;
                      isDoctor = false;
                    });
                  },
                  leading: Icon(
                    Icons.home_repair_service,
                    color: Colors.white,
                  ),
                  title: Text(
                    "الخدمات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Login.route, (Route<dynamic> route) => false);
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    getString(context, "logout"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: kBottomNavigationBarHeight),
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
        Constants.imagePath + list[index].imagePath,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildAnnouncementSlider() {
    return announcementList != null && announcementList!.isEmpty
        ? Text("")
        : Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: announcementList!.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return sliderBuilder(index, announcementList!);
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
    return notificationsList != null && notificationsList!.isEmpty
        ? Text("")
        : Container(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: notificationsList!.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return sliderBuilder(index, notificationsList!);
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
    return imageList != null && imageList!.isEmpty
        ? Text("")
        : Container(
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: imageList!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CachedNetworkImage(
                          imageUrl: Constants.imagePath +
                              imageList![index].imagePath!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      );
                    });
              },
            ));
  }

  Future<void> getCityId() async {
    final prefs = await SharedPreferences.getInstance();
    cityId = prefs.getString('cityId');
  }

  Widget buildProductHotList() {
    return productHotList == null || productHotList!.isEmpty
        ? Text("")
        : LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: GridView.builder(
                    itemCount: productHotList!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItems(
                          product: productHotList![index], index: index);
                    }),
              );
            },
          );
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
                      categoryList[index]["id"].toString(), 1, limit)
                  .then((value) {
                setState(() {
                  isLoaded = false;
                });
              });

              setState(() {
                isService = false;
                isDoctor = false;
                isHome = false;
                isLoaded = true;
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
                      child: categoryIcon[index]["id"] == 1
                          ? Icon(
                              categoryIcon[index]["icons"],
                              color: Colors.white,
                              size: 30,
                            )
                          : Image.asset(
                              categoryIcon[index]["icons"],
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
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
        },
      ),
    );
  }

  scafoldBody() {
    if (isDoctor == false && isService == false)
      return Container(
        child: ListView(
          children: [
            !isHome
                ? Container(
                    margin: const EdgeInsets.only(right: 15, left: 15, top: 5),
                    padding: const EdgeInsets.only(right: 10, left: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: kElevationToShadow[6]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: TextField(
                            controller: _searchController,
                            onSubmitted: (value) {
                              // print(value);
                              Provider.of<SupplierProvider>(context,
                                      listen: false)
                                  .searchSupplierByCity(value, 1, limit);
                            },
                            decoration: InputDecoration(
                                hintText: 'البحث',
                                hintStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.close,
                                  // isSearch ? Icons.close : Icons.search,
                                  color: primaryColor,
                                ),
                              ),
                              onTap: () {
                                // print(_searchController.text);
                                if (_searchController.text.isNotEmpty) {
                                  _searchController.clear();
                                  Provider.of<SupplierProvider>(context,
                                          listen: false)
                                      .fetchCurrentSupplierList(1, limit);
                                }
                                // setState(() {
                                //   // isSearch
                                //   //     ? Provider.of<SupplierProvider>(context,
                                //   //         listen: false).searchSupplier();
                                //   //     : Provider.of<SupplierProvider>(context,
                                //   //             listen: false)
                                //   //         .fetchSupplierList(
                                //   //             "0", 1, limit);

                                //   isSearch = !isSearch;
                                // });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            isHome ? buildAnnouncementSlider() : Container(),
            buildMainCategoryListView(),
            isHome ? buildImagesSlider() : Container(),
            isHome ? buildProductHotList() : Container(),
            isHome ? buildNotificationsSlider() : Container(),
            !isHome && !isLoaded
                ? supplierList == null || supplierList!.isEmpty
                    ? Text("")
                    : LayoutBuilder(builder: (context, constraints) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: supplierList!.length,

                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          ///
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // print("object");
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .clearProductList();
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .fetchProductList(
                                        supplierList![index].id.toString(),
                                        categoryId,
                                        "",
                                        1,
                                        limit);
                                print(limit);
                                Navigator.pushNamed(
                                    context, ProductScreen.route,
                                    arguments: {
                                      "supplierId":
                                          supplierList![index].id.toString(),
                                      "categoryId": categoryId,
                                      "supplierName":
                                          supplierList![index].name.toString(),
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
                                            supplierList![index].imagePath!,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      supplierList![index].name!,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14.0),
                                    ),
                                    // Text(
                                    //   supplierList[index].categoryName ?? "",
                                    //   style: TextStyle(
                                    //       color: Color(0xFF575E67),
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 14.0),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      })
                : Container(),
            !isHome && isLoaded
                ? Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      );
    else if (isDoctor == true && isService == false)
      return DoctorSection();
    else if (isService == true && isDoctor == false) {
      return ServiceSection();
    }
  }
}
