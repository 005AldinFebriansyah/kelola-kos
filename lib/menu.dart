import 'package:flutter/material.dart';
import 'package:data_penghuni_kos/homepage.dart';
import 'package:data_penghuni_kos/profilepage.dart';
import 'package:data_penghuni_kos/viewdata.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _index = 0;

  List _page = [HomePage(), ViewPage(), ProfilePage("a")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_index],
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.all(10),
          child: GNav(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.blue,
              tabBackgroundColor: Colors.blue,
              duration: Duration(milliseconds: 300), // tab animation duration
              activeColor: Colors.white,
              color: Colors.white,
              textStyle: TextStyle(fontFamily: 'Poppins', color: Colors.white),
              gap: 8, // the tab button gap between icon and text
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.article,
                  text: 'Data',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profil',
                )
              ]),
        ),
      ),
    );
  }
}