import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/home/services/item_stream.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'HomePageRoute';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;
  String? searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ItemsStream(searchString: searchString),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      centerTitle: true,
      title: Text('Passwords'),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
              setState(() {
                searchString = null;
              });
            });
          },
          icon: isSearching ? Icon(Icons.cancel_outlined) : Icon(Icons.search),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(isSearching ? 56 : 0),
        child: isSearching ? buildSearchTextField(context) : Container(),
      ),
    );
  }

  Padding buildSearchTextField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.5,
        vertical: kDefaultPadding * 0.3,
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchString = value;
          });
        },
        autofocus: true,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                FocusScope.of(context).unfocus();
              });
            },
          ),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).bottomAppBarColor,
        ),
      ),
    );
  }
}
