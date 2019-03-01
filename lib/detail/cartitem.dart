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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          child: ListTile(
            leading: Container(child:Image.network(widget.photoUrl),width: 50.0,height: 50.0,),
            title: Text(widget.name,style: TextStyle(fontSize: 16.0),),
          ),
        ),
      ),
    );
  }
}
