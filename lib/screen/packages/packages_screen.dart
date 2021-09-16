import 'package:eshop/provider/packages_provider.dart';
import 'package:eshop/screen/packages/order_package_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PackagesScreen extends StatefulWidget {
  static const String route = "/packages";
  PackagesScreen({Key? key}) : super(key: key);

  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  late String locale;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
    Provider.of<PackagesProviders>(context, listen: false).getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getString(context, "packages"),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<PackagesProviders>(
        builder: (context, packages, child) => packages.packages.isNotEmpty
            ? ListView.builder(
                itemCount: packages.packages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor, width: 2),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Text(
                          locale == "ar"
                              ? packages.packages[index].nameAr.toString()
                              : packages.packages[index].nameEn ??
                                  packages.packages[index].nameAr.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Html(
                          data: locale == "ar"
                              ? packages.packages[index].descriptionAr
                              : packages.packages[index].descriptionEn ??
                                  packages.packages[index].descriptionAr
                                      .toString(),
                        ),
                        Text(
                          "${packages.packages[index].price.toString()}${getString(context, "currency")}",
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderPackageScreen(
                                    package: packages.packages[index],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              getString(context, "buyPackage"),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            : Container(
                child: Center(
                  child: SpinKitSpinningCircle(
                    color: secondaryColor,
                  ),
                ),
              ),
      ),
    );
  }
}
