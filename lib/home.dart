import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakat/components/button.dart';
import 'package:siakat/screen/login/register.dart';
import 'package:siakat/screen/page/dashboard.dart';
import 'package:siakat/screen/page/jadwal.dart';
import 'package:siakat/screen/page/mk.dart';
import 'package:siakat/ultis/helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  var _isTitle;

  int currentTab = 0;
  final List<Widget> screen = [DashboardPage(), MkPage(), JadwalPage()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardPage();

  String sToken = '';

  @override
  void initState() {
    super.initState();
    cekToken();
  }

  void cekToken() async {
    sToken = await Helper.getUserData();
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: 'Transaction Completed Successfully!',
    );
  }

  void singOut() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Perhatian',
      text: 'Do you want to logout',
      confirmBtnText: 'Action',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_isTitle ?? 'Dashbaord');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              onPressed: () async {
                await Helper.deleteUserData();
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
          title: Text(_isTitle ?? 'Dashbaord'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        ),
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      onPressed: () {
                        setState(() {
                          _isTitle = 'Dashboard';
                          currentScreen = DashboardPage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: currentTab == 0
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      onPressed: () {
                        setState(() {
                          _isTitle = 'MataKuliah';
                          currentScreen = MkPage();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'MK',
                            style: TextStyle(
                                color: currentTab == 1
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      onPressed: () {
                        setState(() {
                          _isTitle = 'Jadwal';
                          currentScreen = JadwalPage();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.earbuds,
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Jadwal',
                            style: TextStyle(
                                color: currentTab == 2
                                    ? Colors.blue
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
