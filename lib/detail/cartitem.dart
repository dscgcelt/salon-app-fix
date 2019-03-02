import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app_new/util/counter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartItem extends StatefulWidget {
  final FirebaseUser user;
  final String name;
  final String photoUrl;
  final String price;
  CartItem({this.name, this.photoUrl,this.price,this.user});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  _deleteCartItem(value){
    streamCntrl.sink.add(--counter);
    saved.remove(value);
    Firestore.instance.collection("users").document(widget.user.email).
    collection("cart").document(value).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          height: 100.0,
          child: Center(
            child: ListTile(
                leading: Image.network(
                  widget.photoUrl,
                  width: 80.0,
                  height: 80.0,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.price+'\$',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: ()=>_deleteCartItem(widget.name),
                )),
          ),
        ),
      ),
    );
  }
}
