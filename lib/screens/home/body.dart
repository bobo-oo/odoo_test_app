import 'package:flutter/material.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/screens/home/components/featured_item.dart';
import 'package:test_app/screens/home/components/header_with_search.dart';
import 'package:test_app/screens/home/components/item_list.dart';
import 'package:test_app/screens/home/components/title_with_more_btn.dart';

class Body  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column (
        children: <Widget> [
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: "Featured Items",press: () {}),
          FeaturedItemCard(),
          TitleWithMoreBtn(title: "Recommended",press: () {}),
          ItemListCard(),
          SizedBox(
            height: kDefaultPadding,
          )
        ],
      ),
    );
  }
}

