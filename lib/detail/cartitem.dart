import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String name;
  final String photoUrl;

  CartItem({this.name,this.photoUrl});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 16.0,backgroundImage: NetworkImage(widget.photoUrl),),
      title: Text(widget.name,style: TextStyle(fontSize: 16.0),),
    );
  }
}
