import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:test_app/main.dart';

class ItemDetail {
  int itemId;
  String itemName;
  double itemPrice;
  String itemDescription;
  String itemCategory;

  ItemDetail({
    this.itemId,
    this.itemCategory,
    this.itemDescription,
    this.itemName,
    this.itemPrice});

  factory ItemDetail.fromJson(List<dynamic> json) {
    var cat = '';
    if (json[0]['categ_id'] != null) {
      cat = json[0]['categ_id'][1];
    }
    return ItemDetail(
      itemId: json[0]['id'],
      itemCategory: cat,
      itemDescription: json[0]['description'],
      itemName: json[0]['display_name'],
      itemPrice: json[0]['lst_price'],
    );
  }
  Future<ItemDetail> fetchItemDetail(int _itemId) async {
    print(123);
    try {
      var res = await client.callKw({
        'model': 'product.product',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['id', '=', _itemId],
          ],
          'limit': 1,
          'fields': ['id', 'display_name', 'lst_price','categ_id', '__last_update'],
        },
      });
      return ItemDetail.fromJson(res);

    } on OdooException catch (e) {
      // Cleanup on odoo exception
      print(e.message);
      print("log out");
      return null;
    }

  }
}


class ProductList {
  List<dynamic> products;

  ProductList({this.products});

  factory ProductList.fromJson(List<dynamic> json) {

    return ProductList(
      products: json,
    );
  }
  Future<ProductList> fetchProductList() async {
    var res = await client.callKw({
      'model': 'product.product',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {},
        'domain': [
        ],
        // 'fields': ['id', 'name', '__last_update', 'image_128'],
        'fields': ['id', 'name','lst_price','__last_update'],
      },
    });
    return ProductList.fromJson(res);
  }
}


class ItemListView  {
  const ItemListView({
    this.image,
    this.title,
    this.country,
    this.price,
    this.press,
  });

  final String image, title, country;
  final double price;
  final Function press;
}
