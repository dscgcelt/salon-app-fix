import 'package:flutter/material.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app_new/onboarding/pages/login_page.dart';
import 'package:salon_app_new/home/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_app_new/detail/booking.dart';

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

  int count = 0;
  List<int> listnew = [];

  GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    CustomColors customColor = CustomColors();
    List<Widget> widgets = List<Widget>();
    for (var i = 0; i < 10; i++) {
      widgets.add(catalogue(context, "Style", null));
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cut & Trim"),
          backgroundColor: customColor.primaryColor,
          actions: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: () {
                     // Integrate cart page
                    },
                    child: new Stack(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: null,
                        ),
                        listnew.length == 0
                            ? new Container()
                            : new Positioned(
                                child: new Stack(
                                children: <Widget>[
                                  new Icon(Icons.brightness_1,
                                      size: 20.0, color: Colors.green[800]),
                                  new Positioned(
                                      top: 3.0,
                                      right: 4.0,
                                      child: new Center(
                                        child: new Text(
                                          listnew.length.toString(),
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ],
                              )),
                      ],
                    ),
                  )),
            ),
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
                  DashBoard(
                    user: widget.user,
                  ),
                  LastVisitCard(),
                  // HaircutListMenu(user: widget.user,key:key),
                  Container(
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
                          height: 223.0,
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
                          height: 223.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: widgets,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final CustomColors customColors = new CustomColors();

  Widget catalogue(BuildContext context, String name, String photoUrl) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Booking()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Card(
            margin: EdgeInsets.only(right: 8.0),
            child: Column(
              children: <Widget>[
                photoUrl == null
                    ? Image.asset(
                        "images/haircut.jpg",
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        photoUrl,
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.fill,
                      ),
                Text(
                  name,
                  style: TextStyle(
                    color: customColors.accentColor,
                    fontSize: 20.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "\$10",
                      style: TextStyle(color: customColors.primaryTextColor),
                    ),
                    SizedBox(
                      width: 14.0,
                    ),
                    IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          setState(() {
                            count++;
                            listnew.add(count);
                          });
                        }),
                  ],
                ),
              ],
            ),
//          elevation: 2.0,
          ),
        ),
      );

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
