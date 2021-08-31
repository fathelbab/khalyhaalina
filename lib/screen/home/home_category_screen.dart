import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/screen/packages/packages_screen.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:share/share.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/configurations_data.dart';
import 'package:eshop/model/doctor_data.dart' hide City;
import 'package:eshop/model/gif_models_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/notification_data.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/service_details_data.dart' hide City;
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/provider/announcement_provider.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/gifmodels_provider.dart';
import 'package:eshop/provider/images_provider.dart';
import 'package:eshop/provider/notification_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/service_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/address/governorate_screen.dart';
import 'package:eshop/screen/favourite/favourite_screen.dart';
import 'package:eshop/screen/home/sections/doctor_section.dart';
import 'package:eshop/screen/home/sections/main_category.dart';
import 'package:eshop/screen/home/sections/service_section.dart';
import 'package:eshop/screen/info/info_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/screen/online_support/online_support_screen.dart';
import 'package:eshop/screen/rewards/rewards_screen.dart';
import 'package:eshop/screen/search/search_screen.dart';
import 'package:eshop/screen/settings/language.dart';
import 'package:eshop/screen/terms_conditions/terms_conditions_screen.dart';
import 'package:eshop/screen/wallet/wallet_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/widget/product_item.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCategoryScreen extends StatefulWidget {
  static const String route = "/category_screen";

  @override
  _HomeCategoryScreenState createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  List<City> cityList = [];
  int _gifModelsActiveIndex = 0;
  List<AnnouncementData>? announcementList = [];
  List<GifModels>? _gifModelsList = [];
  List<Notifications>? notificationsList = [];
  List<ImageData>? imageList = [];
  List<Supplier>? supplierList = [];
  List<DoctorInfo>? doctorList = [];
  List<ServiceInfo>? serviceList = [];
  List<Product>? discountHotProduct = [];
  List<Product>? statusHotProduct = [];
  List<Product>? newHotProduct = [];
  ScrollController _categoryScrollController = new ScrollController();
  ScrollController _hotProductScrollController = new ScrollController();
  late Size size;
  int limit = 20;
  bool isLoaded = false;
  bool isSearch = false;
  bool isDoctor = false;
  bool isService = false;
  bool isHome = true;
  String categoryId = "0";
  late String cityName;
  late String userName;
  late String governorateName;
  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ConfigurationsData? configuration;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    userName = CacheHelper.getPrefs(key: "userName");
    // Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    Provider.of<CategoryProvider>(context, listen: false)
        .fetchMainCategoryList(1, 100);
    Provider.of<GifModelsProvider>(context, listen: false).getGifModelsList();
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
    governorateName = CacheHelper.getPrefs(key: "governorateName") ?? "";
    cityName = CacheHelper.getPrefs(key: "cityName") ?? "";
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
    // Provider.of<SupplierProvider>(context, listen: false)
    //     .fetchSupplierList(categoryId, 1, limit);
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotificationList();
    Provider.of<ImagesProvider>(context, listen: false).fetchImageList();
    _categoryScrollController.addListener(() {
      if (_categoryScrollController.position.pixels ==
          _categoryScrollController.position.maxScrollExtent) {
        limit += 5;
        Provider.of<CategoryProvider>(context, listen: false)
            .fetchMainCategoryList(1, limit);
      } else {}
    });
    _hotProductScrollController.addListener(() {
      if (_hotProductScrollController.position.pixels ==
          _hotProductScrollController.position.maxScrollExtent) {
        limit += 5;
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProductHotList("0", categoryId, 1, limit);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // categoryList = Provider.of<CategoryProvider>(context).categoryList;
    // cityList = Provider.of<CityProvider>(context, listen: false).cityList;
    _gifModelsList = Provider.of<GifModelsProvider>(context).gifModelsList;
    announcementList =
        Provider.of<AnnouncementProvider>(context).announcementList;
    notificationsList =
        Provider.of<NotificationProvider>(context).notificationList;
    imageList = Provider.of<ImagesProvider>(context).imagesList;
    supplierList = Provider.of<SupplierProvider>(context).supplierList;
    doctorList = Provider.of<DoctorProvider>(context).doctorList;

    discountHotProduct =
        Provider.of<ProductProvider>(context).discountHotProduct;
    statusHotProduct =
        Provider.of<ProductProvider>(context).statusHotProductList;
    newHotProduct = Provider.of<ProductProvider>(context).newHotProduct;
    configuration = Provider.of<ConfigurationProvider>(context).configuration;
    size = MediaQuery.of(context).size;
    return buildScaffold(supplierList);

    // : NoInternet();
  }

  Scaffold buildScaffold(supplierList) {
    return Scaffold(
      key: _scaffoldKey,
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
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(FontAwesomeIcons.th),
        ),
        actions: [
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [],
          // ),
          IconButton(
            icon: Icon(FontAwesomeIcons.language),
            onPressed: () {
              Navigator.of(context).pushNamed(LanguageScreen.route);
            },
          ),
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
      body: scaffoldBody(),
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
        child: SafeArea(
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
                          image: AssetImage('assets/images/person.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      // getString(context, "myAccount"),
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHome = true;
                                  isLoaded = false;
                                  isDoctor = false;
                                  isService = false;
                                });
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, FavouriteScreen.route);
                              },
                              child: Image.asset(
                                'assets/images/like.png',
                                width: constraints.maxWidth / 4,
                                height: 40,
                              ),
                            ),
                            Text(
                              getString(context, "favourite"),
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                                isHome = true;
                                isLoaded = false;
                                isDoctor = false;
                                isService = false;
                              });
                              Navigator.pushNamed(context, RewardsScreen.route);
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/online_shopping.png',
                                  width: constraints.maxWidth / 4,
                                  height: 40,
                                ),
                                Text(
                                  getString(context, "rewards"),
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                                isHome = true;
                                isLoaded = false;
                                isDoctor = false;
                                isService = false;
                              });
                              Navigator.pop(context);
                              if (configuration != null &&
                                  configuration!.minLimt != 0.0) {
                                Navigator.pushNamed(
                                    context, WalletScreen.route);
                              } else {
                                _showDialog(getString(context, "emptyWallet"));
                              }
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/wallet.png',
                                  width: constraints.maxWidth / 4,
                                  height: 40,
                                ),
                                Text(
                                  getString(context, "wallet"),
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  );
                }),
                ListTile(
                  title: Text(
                    getString(context, "startShopping"),
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
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
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
                          color: primaryColor,
                        ),
                        title: Text(
                          getString(context, "doctor"),
                          style: TextStyle(
                              color: primaryColor,
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
                          color: primaryColor,
                        ),
                        title: Text(
                          getString(context, "services"),
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          getString(context, "packages"),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(
                          Icons.local_offer,
                          color: primaryColor,
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            isHome = true;
                            isLoaded = false;
                            isDoctor = false;
                            isService = false;
                          });
                          // Navigator.pop(context);
                          Navigator.pushNamed(context, PackagesScreen.route);
                        },
                      ),
                    ],
                  ),
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
                    Navigator.of(context).pushNamed(GovernorateScreen.route);
                  },
                ),
                // ListTile(
                //   title: Text(
                //     getString(context, "profile"),
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   leading: Icon(
                //     Icons.person,
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
                // ListTile(
                //   title: Text(
                //     getString(context, "rewards"),
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   leading: Icon(
                //     Icons.money,
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
                //     Navigator.pushNamed(context, RewardsScreen.route);
                //   },
                // ),
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
                    Navigator.pop(context);
                    Navigator.pushNamed(context, OnlineSupportScreen.route);
                    // setState(() {
                    //   Navigator.pop(context);
                    //   isHome = true;
                    //   isLoaded = false;
                    //   isDoctor = false;
                    //   isService = false;
                    // });
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

                    // Navigator.pop(context);
                    Navigator.pushNamed(context, InfoScreen.route);
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
                    Icons.verified_user,
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
                    // Navigator.pop(context);
                    Navigator.pushNamed(
                        context, TermsAndConditionsScreen.route);
                  },
                ),
                // ListTile(
                //   title: Text(
                //     getString(context, "favourite"),
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   leading: Icon(
                //     Icons.favorite,
                //     color: Colors.white,
                //   ),
                //   onTap: () {
                //     setState(() {
                //       isHome = true;
                //       isLoaded = false;
                //       isDoctor = false;
                //       isService = false;
                //     });
                //     Navigator.pop(context);
                //     Navigator.pushNamed(context, FavouriteScreen.route);
                //   },
                // ),
                // ListTile(
                //   title: Text(
                //     getString(context, "wallet"),
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   leading: Icon(
                //     Icons.account_balance_wallet_rounded,
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
                //     Navigator.pop(context);
                //     if (configuration != null &&
                //         configuration!.minLimt != 0.0) {
                //       Navigator.pushNamed(context, WalletScreen.route);
                //     } else {
                //       _showDialog(getString(context, "emptyWallet"));
                //     }
                //   },
                // ),

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

                    // _launchURL(
                    //     "https://play.google.com/store/apps/details?id=com.kira.eshop");
                    _onShareAppLink(context);
                  },
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
                // SizedBox(height: kBottomNavigationBarHeight),
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

  Widget buildGifModelsSlider() {
    return _gifModelsList != null && _gifModelsList!.isEmpty
        ? Text("")
        : Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: _gifModelsList!.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return GestureDetector(
                      onTap: () {
                        if (_gifModelsList![index].hasSupplier!) {
                          Provider.of<ProductProvider>(context, listen: false)
                              .clearProductList();
                          Provider.of<SupplierProvider>(context, listen: false)
                              .getSupplierCategory(
                                  _gifModelsList![index].supplierId.toString(),
                                  200);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                  supplierId:
                                      supplierList![index].id.toString()),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: Image.network(
                          Constants.imagePath +
                              _gifModelsList![index].imagePath.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _gifModelsActiveIndex = index;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              AnimatedSmoothIndicator(
                effect: ExpandingDotsEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  dotColor: secondaryColor,
                  activeDotColor: primaryColor,
                ),
                activeIndex: _gifModelsActiveIndex,
                count: _gifModelsList!.length,
              ),
            ],
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
                      return GestureDetector(
                        onTap: () {
                          if (imageList![index].hasProduct!) {
                            // Log.w(imageList![index].productId.toString());
                            Provider.of<ProductProvider>(context, listen: false)
                                .clearProductList();
                            Provider.of<ProductProvider>(context, listen: false)
                                .getProductById(imageList![index].productId);
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.route);
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CachedNetworkImage(
                            imageUrl: Constants.imagePath +
                                imageList![index].imagePath!,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                              child: const SpinKitChasingDots(
                                  color: Color(0XFFE5A352)),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      );
                    });
              },
            ));
  }

  Widget buildProductHotList(List<Product> hotProduct) {
    return hotProduct == null || hotProduct.isEmpty
        ? Text("")
        : LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                color: Colors.grey[300],
                height: MediaQuery.of(context).size.height / 1.8,
                padding: const EdgeInsets.all(5),
                child: GridView.builder(
                    itemCount: hotProduct.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    controller: _hotProductScrollController,
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItems(
                          product: hotProduct[index], index: index);
                    }),
              );
            },
          );
  }

  scaffoldBody() {
    if (isDoctor == false && isService == false) {
      return Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 30,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SearchScreen.route);
                      },
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search_sharp,
                              color: Colors.grey,
                            ),
                            Text(
                              getString(context, "search"),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 5),
                  Text(
                    getString(context, "deliveryText"),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "$cityName - $governorateName",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            // buildAnnouncementSlider(),
            if (_gifModelsList != null) buildGifModelsSlider(),
            MainCategorySection(),
            buildImagesSlider(),
            notificationsList != null && notificationsList!.isEmpty
                ? Text("")
                : Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: Constants.imagePath +
                          notificationsList![0].imagePath!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child:
                            const SpinKitChasingDots(color: Color(0XFFE5A352)),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
            if (newHotProduct != null) buildProductHotList(newHotProduct!),
            notificationsList != null && notificationsList!.isEmpty
                ? Text("")
                : Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: Constants.imagePath +
                          notificationsList![1].imagePath!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child:
                            const SpinKitChasingDots(color: Color(0XFFE5A352)),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
            if (discountHotProduct != null)
              buildProductHotList(discountHotProduct!),
            notificationsList != null && notificationsList!.isEmpty
                ? Text("")
                : Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: Constants.imagePath +
                          notificationsList![2].imagePath!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child:
                            const SpinKitChasingDots(color: Color(0XFFE5A352)),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
            if (statusHotProduct != null)
              buildProductHotList(statusHotProduct!),
            notificationsList != null && notificationsList!.isEmpty
                ? Text("")
                : Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: Constants.imagePath +
                          notificationsList![3].imagePath!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child:
                            const SpinKitChasingDots(color: Color(0XFFE5A352)),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
            // buildNotificationsSlider(),
          ],
        ),
      );
    } else if (isDoctor == true && isService == false)
      return DoctorSection();
    else if (isService == true && isDoctor == false) {
      return ServiceSection();
    }
  }

  _showDialog(String text) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Icon(
          Icons.report,
          color: Colors.red,
          size: 30,
        ),
        content: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              getString(context, "cancel"),
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  _onShareAppLink(BuildContext context) async {
    await Share.share("https://khlihaalina.page.link/shopping");
  }
}
