import 'package:flutter/material.dart';

class HealthManagementPage extends StatefulWidget {
  @override
  _HealthManagementState createState() => _HealthManagementState();
}

class _HealthManagementState extends State<HealthManagementPage> {
  final String healthManagement = '体調管理';
  final String basicInformation = '基本情報';
  TextStyle menuItemStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: Colors.black);

  int _selectedIndex = 0;



  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(healthManagement),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.account_circle,
                    // size: 26.0,
                  ),
                )),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: '入力',
              ),
              Tab(text: '一覧'),
              Tab(text: 'グラフ')
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('メニュー',
                    style: menuItemStyle.copyWith(color: Colors.white)),
                decoration: BoxDecoration(color: Colors.green),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(
                  healthManagement,
                  style: menuItemStyle,
                ),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
                focusColor: Colors.green,
                hoverColor: Colors.green,
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  basicInformation,
                  style: menuItemStyle,
                ),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'ログアウト',
                  style: menuItemStyle,
                ),
                onTap: () {
                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyHomePage()), (route) => false);
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
