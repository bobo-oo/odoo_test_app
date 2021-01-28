import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/Cart.dart';
import 'package:test_app/models/Item.dart';
import 'package:test_app/screens/detail/components/title_and_price.dart';

class ItemDetailScreen extends StatelessWidget {
  ItemDetailScreen({Key key,@required this.itemId}) : super(key: key);
  final int itemId;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ItemDetailView(itemId: itemId),
    );
  }
}
class ItemDetailView extends StatefulWidget {
  ItemDetailView({
    Key key,
    @required this.itemId,
  }) : super(key: key);
  final int itemId;
  @override
  _ItemDetailViewState createState() => _ItemDetailViewState(itemId: itemId);
}

class _ItemDetailViewState extends State<ItemDetailView> {

  _ItemDetailViewState({
    this.itemId
  });
  int itemId;
  ItemDetail _itemDetail = new ItemDetail();
  var _item;

  @override
  void initState() {
    _item = _itemDetail.fetchItemDetail(itemId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return FutureBuilder<ItemDetail>(
      future: _item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Size size = MediaQuery.of(context).size;
          var name = snapshot.data.itemName;
          var unique = name.toString().replaceAll(new RegExp(r'[^0-9]'), '');
          var pid = snapshot.data.itemId;
          var image = '$baseUrl/web/image?model=product.product&field=image_1920&id=$pid&unique=$unique';
          var category = snapshot.data.itemCategory;
          var price = snapshot.data.itemPrice;
          return Container(
            child: Column(
              children: [
                // ImageAndIconCard(),
                TitleAndPrice(image: image, title: name, category: category,price: price),
                SizedBox(height: kDefaultPadding,),
                Row(
                  children: [
                    SizedBox(
                      width: size.width / 2,
                      height: 84,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                        ),
                        color: kPrimaryColor,
                        onPressed: () {
                          cart.addItem(pid.toString(), name, price);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Item added to cart.'),
                          ));
                        },
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text("Description"),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: kDefaultPadding * 2,),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        else {
          return Container(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          );
        }
        // By default, it show a loading spinner.
      },
    );
  }
}
