import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_the_library/pages/resource_center/components/pdf_category_list.dart';
import 'package:save_the_library/pages/resource_center/components/pdf_list.dart';

class ResourceCenterPage extends StatefulWidget {
  ResourceCenterPage({Key key}) : super(key: key);

  @override
  _ResourceCenterPageState createState() => _ResourceCenterPageState();
}

class _ResourceCenterPageState extends State<ResourceCenterPage> {
  int _currentIndex = 0;
  List<Widget> widgetList = [
    PdfList(),
    PdfCategoryList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Resource Center'),
        centerTitle: true,
        elevation: 1,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: widgetList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Latest'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          )
        ],
      ),
    );
  }
}
