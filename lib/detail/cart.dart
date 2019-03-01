import 'package:flutter/material.dart ';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cartitem.dart';
import 'package:salon_app_new/util/custom_colors.dart';

class CartDeatails extends StatefulWidget {

  final FirebaseUser user;
  CartDeatails({this.user});

  @override
  _CartDeatailsState createState() => _CartDeatailsState();
}

class _CartDeatailsState extends State<CartDeatails> {

  CustomColors customColors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: customColors.primaryColor,
        title: Text("Cart",style:TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder(
    stream: Firestore.instance.collection("users").document(widget.user.email).
          collection("cart").snapshots(),
    builder: (BuildContext context,snapshot){
//                print(snapshot.data.documents[0]['photo']);
    if(!snapshot.hasData)
    {
        return CircularProgressIndicator();
    }
        return Column(
          children: <Widget>[
         Flexible(
           child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (_, int i) {
              return CartItem(name: snapshot.data.documents[i]['name'],
                photoUrl: snapshot.data.documents[i]['photo'],);
            },
            itemCount: snapshot.data.documents.length,
        ),
         ),
            FlatButton(
                onPressed: null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(child: Text("BUY NOW",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),)),
              width: 1000.0,
              height: 50.0,
              color: customColors.accentColor,
            ),
                ))
          ],
        );

    }
    ),
      
      
    );


  }
}
