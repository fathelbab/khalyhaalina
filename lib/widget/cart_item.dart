import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final int? id;
  final String? productId;
  final double? price;
  final int? quantity;
  final String? title;
  final String? image;
  final String? description;

  const CartItem({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.image,
    this.description,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (cxt) => AlertDialog(
            // title: Text(AppLocale.of(context).getString("alert")),
            content: Text(AppLocale.of(context)!.getString("alertBody")!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocale.of(context)!.getString("no")!),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Provider.of<Cart>(context, listen: false)
                      .removeItems(widget.id.toString());
                  Provider.of<Cart>(context, listen: false).fetchCartList();
                },
                child: Text(AppLocale.of(context)!.getString("yes")!),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false)
            .removeItems(widget.id.toString());
        Provider.of<Cart>(context, listen: false).fetchCartList();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  child: FittedBox(
                    child: CachedNetworkImage(
                      imageUrl: Constants.imagePath + widget.image!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child:
                            const SpinKitChasingDots(color: Color(0XFFE5A352)),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                title: Text(
                  widget.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                        '${AppLocale.of(context)!.getString("total")} ${widget.price! * widget.quantity!} ج.م'),
                  ],
                ),
                trailing: Text(
                    '${AppLocale.of(context)!.getString("quantity")} : ${widget.quantity} '),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (cxt) => AlertDialog(
                          // title: Text(AppLocale.of(context).getString("alert")),
                          content: Text(
                              AppLocale.of(context)!.getString("alertBody")!),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child:
                                  Text(AppLocale.of(context)!.getString("no")!),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<Cart>(context, listen: false)
                                    .removeItems(widget.id.toString());
                                Provider.of<Cart>(context, listen: false)
                                    .fetchCartList();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                  AppLocale.of(context)!.getString("yes")!),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 1))
                            ]),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.minus,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {
                            if (widget.quantity! > 1) {
                              Provider.of<Cart>(context, listen: false)
                                  .decreaseQuantity(
                                widget.id!,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${widget.quantity}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 1))
                            ]),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {
                            if (widget.quantity! >= 0) {
                              Provider.of<Cart>(context, listen: false)
                                  .increaseQuantity(
                                widget.id!,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Row buildQuantityIncrementer() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: 30,
  //         height: 30,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15),
  //             color: primaryColor,
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.grey[200]!,
  //                   spreadRadius: 3,
  //                   blurRadius: 7,
  //                   offset: Offset(0, 1))
  //             ]),
  //         child: IconButton(
  //           icon: FaIcon(
  //             FontAwesomeIcons.minus,
  //             color: Colors.white,
  //             size: 15,
  //           ),
  //           onPressed: () {
  //             if (widget.quantity == 0 || widget.quantity < 0)
  //               setState(() {
  //                 currentQuantity = 1;
  //               });
  //             else if (widget.quantity > 0)
  //               setState(() {
  //                 print(widget.quantity);
  //                 quantity--;
  //               });
  //             print(widget.quantity);
  //           },
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Text(
  //           "${widget.quantity}",
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 25.0,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         width: 30,
  //         height: 30,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15),
  //             color: primaryColor,
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.grey[200]!,
  //                   spreadRadius: 5,
  //                   blurRadius: 7,
  //                   offset: Offset(0, 1))
  //             ]),
  //         child: IconButton(
  //           icon: FaIcon(
  //             FontAwesomeIcons.plus,
  //             color: Colors.white,
  //             size: 15,
  //           ),
  //           onPressed: () {
  //             // if (quantity >= 0)
  //             //   setState(() {
  //             //     quantity++;
  //             //   });

  //             // print(quantity);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
  // leading: CircleAvatar(
  //             backgroundColor: Theme.of(context).primaryColor,
  //             child: FittedBox(
  //               child: Text(
  //                 'ج.م $price ',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),