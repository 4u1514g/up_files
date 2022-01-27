import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_files/account/account_screen.dart';
import 'package:up_files/helper/provider.dart';
import 'package:up_files/helper/ruler.dart';
import 'package:up_files/history/history_screen.dart';
import 'package:up_files/up_files/up_screen.dart';


class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _cur = 0;
  final List<Widget> _item = [const UpFilesScreen(), const SizedBox(), const SizedBox()];

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, pvd, child) =>  Scaffold(
        appBar: Ruler.appBar(color: Colors.white),
        body: IndexedStack(
          children: _item,
          index: _cur,
        ),
        bottomNavigationBar:!pvd.show?const SizedBox():  AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
          height: pvd.show?58:0,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                if (_item[index] is SizedBox) {
                  if(index==1) {
                    _item[index] = const HistoryScreen();
                  } else {
                    _item[index] = const AccountScreen();
                  }
                }
                _cur=index;
              });
            },
            selectedItemColor: Ruler.blueColor,
            unselectedItemColor: Ruler.purple2Color,
            currentIndex: _cur,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.cloud_upload_rounded),
                  label: 'Upload Files'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Account'),
            ],
          ),
        ),
      ),
    );
  }
}
