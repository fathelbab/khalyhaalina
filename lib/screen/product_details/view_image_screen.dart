import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/model/product_details_data.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewImageScreen extends StatefulWidget {
  static const String route = "/view_image";
  // final String? image;
  // ViewImageScreen({Key? key, this.image}) : super(key: key);

  @override
  _ViewImageScreenState createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  int _activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    ProductDetailsData? productDetails =
        Provider.of<ProductProvider>(context).productData;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: secondaryColor,
                      size: 30,
                    )),
              ],
            ),
            productDetails!.productGalleries != null &&
                    productDetails.productGalleries!.isEmpty
                ? Expanded(
                    child: InteractiveViewer(
                      child: Image.network(
                        Constants.imagePath + productDetails.imagePath!,
                        fit: BoxFit.contain,
                        // width: double.infinity,
                        // height: size.height / 3 + 50,
                        scale: 1,
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: CarouselSlider.builder(
                              itemCount:
                                  productDetails.productGalleries?.length,
                              itemBuilder: (BuildContext context, itemIndex,
                                  int pageViewIndex) {
                                // print(itemIndex);
                                return sliderBuilder(itemIndex,
                                    productDetails.productGalleries!);
                              },
                              // items: imageSliders,
                              options: CarouselOptions(
                                enableInfiniteScroll: true,
                                aspectRatio: 1.0,
                                disableCenter: false, viewportFraction: 1,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _activeIndex = index;
                                  });
                                },
                                // enlargeStrategy: CenterPageEnlargeStrategy.height,
                              ),
                            ),
                          ),
                        ),
                        AnimatedSmoothIndicator(
                          effect: ExpandingDotsEffect(
                            dotWidth: 8.0,
                            dotHeight: 8.0,
                            dotColor: secondaryColor,
                            activeDotColor: primaryColor,
                          ),
                          activeIndex: _activeIndex,
                          count: productDetails.avilabeProductGalleries!.length,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
            // Expanded(
            //   flex: 1,
            //   child: InteractiveViewer(
            //     child: Image.network(
            //       Constants.imagePath + widget.image!,
            //       width: double.infinity,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget sliderBuilder(int index, List<ProductGallery> productGalleries) {
    return InteractiveViewer(
      child: Image.network(
        Constants.imagePath + productGalleries[index].imagePath!,
        fit: BoxFit.contain,
        width: double.infinity,
        scale: 1,
      ),
    );
  }
}
