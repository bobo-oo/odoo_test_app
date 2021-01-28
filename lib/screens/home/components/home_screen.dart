import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:test_app/components/bottom_nav_bar.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/Cart.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/screens/forms/components/form_fields.dart';
import 'package:test_app/screens/home/body.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreen createState() => _HomeScreen();
}
class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    var itemCount = cart.items.length;
    return AppBar(
      elevation: 0,
      leading:
      IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          return ShoppingCart();
        },
      ),
      actions: [
        IconButton(
          icon: showCart(itemCount),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingCart(),
              ),
            );
          },
        ),
      ],
    );
  }
  showCart (count) {
    if (count > 0) {
      return Stack(
        children: [
          Icon(Icons.shopping_cart),
          Positioned(
            top: 1.0,
            right: 0.0,
            child: Stack(
              children: <Widget>[
                Icon(Icons.brightness_1,
                    size: 18.0, color: Colors.green[800]),
                Positioned(
                  top: 1.0,
                  right: 4.0,
                  child: Text("$count",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500)
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Stack(
        children: [
          Icon(Icons.shopping_cart)
        ],
      );
    }

  }
}


class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCart createState() => _ShoppingCart();
}
class _ShoppingCart extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(context),
      body: cartList(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading:
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          return  Navigator.pop(context);
        },
      ),
    );
  }
  cartList()  {
    final cart = Provider.of<Cart>(context);
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        var pid = cart.items.values.toList()[index].id;
        var name = cart.items.values.toList()[index].name;
        var price = cart.items.values.toList()[index].price;
        var quantity = cart.items.values.toList()[index].quantity;
        var _qtyController = new TextEditingController();
        _qtyController.text = cart.items.values.toList()[index].quantity.toString();
        var unique = name.toString().replaceAll(new RegExp(r'[^0-9]'), '');
        var image = '$baseUrl/web/image?model=product.product&field=image_1920&id=$pid&unique=$unique';
        var subTtl = quantity * price;
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23)
                  )
                ]
            ),
            margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 0.75,horizontal: kDefaultPadding),
            child: Row(
              children: [
                Container(
                  height: size.height * 0.25,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("$image"),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container (
                    padding: EdgeInsets.all(kDefaultPadding),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: size.height * 0.3,
                    child: Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding/5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: '$name',
                                    style: TextStyle(color: kTextColor,fontSize: 16.0),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '\$$price',
                                  style: TextStyle(fontSize: 14.0,color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Row (
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  cart.addItem(pid.toString(), name, price);
                                },
                                icon: Icon(Icons.add, color: Colors.black),
                                // backgroundColor: Colors.white,
                              ),
                            ),
                            Expanded(
                            child:
                              TextFormField(
                                controller: _qtyController,
                                onChanged: (qty) {
                                  cart.updateQuantity(pid.toString(), int.parse(qty));
                                },
                               // initialValue: quantity.toString(),
                               keyboardType: TextInputType.number,
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  cart.removeSingleItem(pid.toString());
                                },
                                icon: Icon(Icons.remove, color: Colors.black),
                                // backgroundColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  cart.removeItem(pid.toString());
                                },
                                icon: Icon(Icons.delete, color: Colors.black),
                                // backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Sub Total:',
                                  style: TextStyle(color: kTextColor,fontSize: 14.0),
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '\$$subTtl',
                                style: TextStyle(fontSize: 14.0,color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          );
      },
    );
  }
}
