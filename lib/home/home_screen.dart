import 'package:flutter/material.dart';
import 'package:salon_app_new/home/catalogue.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app_new/onboarding/pages/login_page.dart';
import 'package:salon_app_new/home/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;
  HomeScreen({this.user});
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<Choice> choices = <Choice>[
    Choice(icon: Icons.settings, title: "Setings"),
    Choice(icon: Icons.exit_to_app, title: "Log Out"),
  ];

  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    CustomColors customColor = CustomColors();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cut & Trim"),
          backgroundColor: customColor.primaryColor,
          actions: <Widget>[
            PopupMenuButton<Choice>(
              elevation: 3.2,
              onSelected: _handleChoiceSelect,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        Icon(choice.icon),
                        Padding(padding: const EdgeInsets.only(right: 10.0)),
                        Text(
                          choice.title,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
//                  Container(
//                    width: 1000,
//                    margin: EdgeInsets.all(10.0),
////                    child: Image.asset(
////                      "images/profile_overview.png",
////                      fit: BoxFit.fill,
////                    ),
//                    child: Card(
//                      color: customColor.primaryColor,
//                      child: Container(
//                        width: 1000,
//                        height: 180,
//                        child: Center(
//                            child: Text(
//                          "Hello, ${widget.user.displayName}",
//                          style: TextStyle(color: Colors.white, fontSize: 30.0),
//                        )),
//                      ),
//                    ),
//                  ),
                  DashBoard(user: widget.user,),
                  LastVisitCard(),
                  HaircutListMenu(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignOut(BuildContext context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyLoginPage("Need an Appointment?",
                "images/salon_shop.png", "We won't disappoint you")),
      );
      Fluttertoast.showToast(msg: "Logout sucessful");
    }).catchError((e) {
      print("Logout failed");
    });
  }

  void _handleChoiceSelect(Choice choice) {
    //handling selected Choice from apppbar actions(popupmenu button)

    if (choice == choices[0]) {
       Fluttertoast.showToast(msg: "Settings");
    } else if (choice == choices[1]) {
      // Fluttertoast.showToast(msg: "Log out");
      _handleSignOut(context);
      googleSignIn.disconnect();
    }
  }

}

class Choice {
  Choice({
    this.icon,
    this.title,
  });
  final IconData icon;
  final String title;
}

class LastVisitCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomColors customColor = CustomColors();
    return Card(
        elevation: 2.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  "Last Visit",
                  style: TextStyle(
                      color: customColor.primaryColor, fontSize: 30.0),
                ),
                Text(
                  "3 months ago",
                  style: TextStyle(color: customColor.primaryTextColor),
                )
              ],
            )),
            RaisedButton(
              onPressed: () {},
              color: customColor.primaryColor,
              textColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "28 \nSeptember",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            )
          ],
        ));
  }
}

class HaircutListMenu extends StatelessWidget {
  final CustomColors customColor = CustomColors();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    for (var i = 0; i < 10; i++) {
      widgets.add(Catalogue());
    }
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 15.0),
      child: Column(
        children: <Widget>[
          Text(
            "Haircuts",
            textAlign: TextAlign.left,
            style: TextStyle(color: customColor.primaryColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widgets,
            ),
          ),
          Text(
            "Beard",
            textAlign: TextAlign.left,
            style: TextStyle(color: customColor.primaryColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widgets,
            ),
          )
        ],
      ),
    );
  }
}


