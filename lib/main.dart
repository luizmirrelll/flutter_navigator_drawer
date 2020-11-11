import 'package:flutter/material.dart';

import 'homefragment.dart';
import 'profilefragment.dart';
import 'settingfragment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Drawer',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  Function body;
  DrawerItem(this.title, this.icon, this.body);
}

class MyHomePage extends StatefulWidget {
  final drawerFragments = [
    new DrawerItem("Home", Icons.home, () => new HomeFragment()),
    new DrawerItem(
        "Profile", Icons.supervised_user_circle, () => new ProfileFragment()),
    new DrawerItem("Settings", Icons.settings, () => new SettingsFragment())
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerFragmentIndex = 0;

  _getDrawerFragmentWidgetIndex(int pos) {
    if (widget.drawerFragments[pos] != null) {
      return widget.drawerFragments[pos].body();
    } else {
      return new Text("Error");
    }
  }

  _onSelectFragment(int index) {
    setState(() => _selectedDrawerFragmentIndex = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];

    for (var i = 0; i < widget.drawerFragments.length; i++) {
      var d = widget.drawerFragments[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerFragmentIndex,
        onTap: () => _onSelectFragment(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            widget.drawerFragments[_selectedDrawerFragmentIndex].title),
      ),
      drawer: new SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Luiz Mirel"),
                  accountEmail: new Text("luizmirel@gmail.com")),
              new Column(children: drawerOptions)
            ],
          ),
        ),
      ),
      body: _getDrawerFragmentWidgetIndex(_selectedDrawerFragmentIndex),
    );
  }
}
