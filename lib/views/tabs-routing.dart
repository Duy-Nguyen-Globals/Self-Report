import 'package:flutter/material.dart';
import 'package:flutter_demo_1/views/basic-information.dart';
import 'package:flutter_demo_1/views/health_management.dart';

class TabsRoutingPage extends StatefulWidget {
  @override
  _TabsRoutingState createState() => _TabsRoutingState();
}

class _TabsRoutingState extends State<TabsRoutingPage> {
  static const String healthManagement = '体調管理';
  static const String basicInformation = '基本情報';
  int _selectedIndex = 0;
  TextStyle menuItemStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: Colors.black);

  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[HealthManagementPage(), BasicInformationPage()],
    );
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text(healthManagement),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.person), title: Text(basicInformation)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: buildBottomNavBarItems()[_selectedIndex].title,
      //     centerTitle: true,
      //     actions: <Widget>[
      //       Padding(
      //           padding: EdgeInsets.only(right: 20.0),
      //           child: GestureDetector(
      //             onTap: () {},
      //             child: Icon(
      //               Icons.account_circle,
      //               // size: 26.0,
      //             ),
      //           )),
      //     ]
      // ),
      body: buildPageView(),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Text('メニュー',
      //             style: menuItemStyle.copyWith(color: Colors.white)),
      //         decoration: BoxDecoration(color: Colors.green),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.favorite),
      //         title: Text(
      //           healthManagement,
      //           style: menuItemStyle,
      //         ),
      //         onTap: () {
      //           _onItemTapped(0);
      //           Navigator.pop(context);
      //         },
      //         focusColor: Colors.green,
      //         hoverColor: Colors.green,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: Text(
      //           basicInformation,
      //           style: menuItemStyle,
      //         ),
      //         onTap: () {
      //           _onItemTapped(1);
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.exit_to_app),
      //         title: Text(
      //           'ログアウト',
      //           style: menuItemStyle,
      //         ),
      //         onTap: () {
      //           // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyHomePage()), (route) => false);
      //           Navigator.popUntil(context, ModalRoute.withName('/login'));
      //         },
      //       )
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: buildBottomNavBarItems(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
