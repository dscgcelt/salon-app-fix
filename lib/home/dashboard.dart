import 'package:flutter/material.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashBoard extends StatefulWidget {
  final FirebaseUser user;
  DashBoard({this.user});
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  CustomColors customColor = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.red,
      width: 1500,
      margin: EdgeInsets.all(10.0),
//                    child: Image.asset(
//                      "images/profile_overview.png",
//                      fit: BoxFit.fill,
//                    ),
      child: Container(
              child: Card(
          color: customColor.primaryColor,
                    child: Container(
              width: 1500,
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                // direction: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:24.0,right:18.0,left: 8.0),
                    child: CircleAvatar(
                      radius: 55.0,
                      backgroundImage: widget.user!=null?NetworkImage(widget.user.photoUrl):Image.asset("face.png"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30.0,),
                      Text(
                        "Hello, ${widget.user.displayName[0].toUpperCase()+
                            widget.user.displayName.substring(1, widget.user.displayName.indexOf(" "))+"!"}",
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                      // SizedBox(height: 15.0,),
                      // Text(widget.user.email,style: TextStyle(color: Colors.white,fontSize: 16.0),),

                      InkWell(
                        onTap: ()=>print("More tapped!!!"),
                        child: Padding(
                          padding: const EdgeInsets.only(top:50.0,left: 120.0,right:20.0),
                          child: Text("More",style: TextStyle(color: Colors.white,fontSize: 24.0),),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

        ),
      ),
    );
  }
}
