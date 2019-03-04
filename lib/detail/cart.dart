import 'package:flutter/material.dart ';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cartitem.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:salon_app_new/util/counter.dart';

class CartDetails extends StatefulWidget {
  final FirebaseUser user;
  CartDetails({this.user});

  @override
  _CartDetailsState createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  CustomColors customColors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: customColors.primaryColor,
        title: Text("Cart", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("users")
              .document(widget.user.email)
              .collection("cart")
              .snapshots(),
          builder: (BuildContext context, snapshot) {
//                print(snapshot.data.documents[0]['photo']);
            if (!snapshot.hasData) {
              return Center(
                  child: Text(
                "Your bag is empty",
                style: TextStyle(color: Colors.grey),
              ));
            }
            return saved.isNotEmpty
                ? Column(
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, int i) {
                            return CartItem(
                              name: snapshot.data.documents[i]['name'],
                              photoUrl: snapshot.data.documents[i]['photo'],
                              price: snapshot.data.documents[i]['price'],
                              user: widget.user,
                            );
                          },
                          itemCount: snapshot.data.documents.length,
                        ),
                      ),
                      FlatButton(
                          onPressed: null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                  child: Text(
                                "BOOK NOW",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                              width: 1000.0,
                              height: 50.0,
                              color: customColors.accentColor,
                            ),
                          ))
                    ],
                  )
                : Center(
                    child: Text(
                      "Your cart is empty!!",
                      style: TextStyle(
                          color: customColors.secondaryTextColor,
                          fontSize: 26.0,
                          fontWeight: FontWeight.normal),
                    ),
                  );
          }),
    );
  }
}
