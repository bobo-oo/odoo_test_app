import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/Cart.dart';
import 'package:test_app/models/Item.dart';
import 'package:test_app/screens/detail/components/item_detail.dart';

class ItemListCard extends StatefulWidget {
  ItemListCard({Key key}) : super(key: key);

  @override
  _ItemListCard createState() => _ItemListCard();
}

class _ItemListCard extends State<ItemListCard> {
  var products;
  ProductList productList = new ProductList();

  @override
  void initState() {
    super.initState();
    products = productList.fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);
    return FutureBuilder<ProductList>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.products;
          return  Container(
            height: size.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length, itemBuilder: (context,int index) {
                var name = data[index]['name'].toString();
                var unique = name.replaceAll(new RegExp(r'[^0-9]'),'');
                var pid = data[index]['id'];
                var price = data[index]['lst_price'];
                var image = '$baseUrl/web/image?model=product.product&field=image_128&id=$pid&unique=$unique';
                return Container(
                  margin: EdgeInsets.all(20),
                  child: Column (
                    children: <Widget> [
                      GestureDetector(
                        onTap: () {
                          return Navigator.push(
                            context,MaterialPageRoute(
                            builder: (context) => ItemDetailScreen(itemId: pid),
                          ),
                          );
                        },
                        child: Container (
                          padding: EdgeInsets.all(kDefaultPadding / 2),
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
                          child: Column(
                            children: [
                              Image.network(image),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "$name\n".toUpperCase(),
                                              style: Theme.of(context).textTheme.button,
                                            ),
                                            TextSpan(
                                              text: '\$$price',
                                              style: TextStyle(
                                                color: kPrimaryColor.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        child:
                                          IconButton(
                                            icon: Icon(Icons.shopping_cart, color: Colors.green[800]),
                                            onPressed: () {
                                              cart.addItem(pid.toString(), name, price);
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text('Item added to cart.'),
                                              ));
                                            },
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        else {
          return CircularProgressIndicator();
        }
        // By default, it show a loading spinner.
      },
    );
  }
}
