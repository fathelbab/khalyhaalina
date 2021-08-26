import 'package:eshop/provider/announcement_provider.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/provider/contact_us_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/gifmodels_provider.dart';
import 'package:eshop/provider/images_provider.dart';
import 'package:eshop/provider/notification_provider.dart';
import 'package:eshop/provider/order_provider.dart';
import 'package:eshop/provider/pharmacy_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/service_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (context) => CategoryProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProductProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => CityProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SupplierProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => PharmacyProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => GifModelsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => Auth(),
  ),
  ChangeNotifierProvider(
    create: (context) => AnnouncementProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ImagesProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => Cart(),
  ),
  ChangeNotifierProvider(
    create: (context) => OrderProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => DoctorProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ContactUsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ServiceProvider(),
  ),
  // ChangeNotifierProvider(
  //   create: (context) => ConnectivityProvider(),
  // ),
  ChangeNotifierProvider(
    create: (context) => NotificationProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SettingsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ConfigurationProvider(),
  )
];
