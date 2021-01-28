import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/main.dart';
import 'package:test_app/models/Cart.dart';
import 'package:test_app/models/User.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);
    double ttl = cart.totalAmount;
    return Container(
      padding: EdgeInsets.only(
        top: kDefaultPadding ,
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            child: FlatButton(
              // color: Colors.white,
              textColor: Colors.white,
              onPressed: () async {
                if(cart.itemCount > 0) {
                  try {
                    var orderId = await client.callKw({
                      'model': 'sale.order',
                      'method': 'create',
                      'args': [
                        {
                          'partner_id': user.id,
                          'website_id': 1
                        },
                      ],
                      'kwargs': {},
                    });
                    cart.items.forEach((key, cartItem) async {
                      await client.callKw({
                        'model': 'sale.order.line',
                        'method': 'create',
                        'args': [
                          {
                            'product_id': int.parse(cartItem.id),
                            'product_uom_qty': cartItem.quantity,
                            'order_id': orderId
                          }
                        ],
                        'kwargs': {},
                      });
                    });
                    cart.clearCart();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Made order successfully.'),
                    ));
                  } on OdooException catch (e) {
                    // Cleanup on odoo exception
                    print(e);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Could not make order.'),
                    ));
                  }
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('No items to make order.'),
                  ));
                }
              },
              child: Row(
                children: <Widget>[
                  Text(
                    "Make Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.shopping_cart, color: Colors.white),
                ],
              ),
            ),
          ),
          Text(
            "Total: ",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
            ),
          ),
          Text(
            "\$$ttl",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
            ),
          ),

        ],
      ),
      // Row(
      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //
      //     // IconButton(
      //     //   icon: SvgPicture.asset("assets/icons/flower.svg"),
      //     //   onPressed: (){},
      //     // ),
      //     // IconButton(
      //     //   icon: SvgPicture.asset("assets/icons/heart-icon.svg"),
      //     //   onPressed: (){},
      //     // ),
      //     // IconButton(
      //     //   icon: SvgPicture.asset("assets/icons/user-icon.svg"),
      //     //   onPressed: (){},
      //     // ),
      //   ],
      // ),
    );
  }
}