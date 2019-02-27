import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app_new/detail/booking.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:salon_app_new/util/counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Catalogue extends StatefulWidget {
  final FirebaseUser user;
  final String photoUrl;
  final String name;

  Catalogue({this.name,this.photoUrl,this.user});

  @override
  CatalogueState createState() {
    return new CatalogueState();
  }
}

class CatalogueState extends State<Catalogue> {
  int c = 0 ;

  List<String> _saved = List<String>();
  _saveItem(String value){
//    streamCntrl.sink.add(++counter);
      Firestore.instance.collection("users").document(widget.user.email).
            collection("cart").document(value).setData(
              {
                "name": value.toString(),
                "photo": widget.photoUrl,
                "price": "10",
              }
      );

    setState(() {
//      ++counter;
      _saved.add(value);
    });
  }

  _discardItem(String value){

    Firestore.instance.collection("users").document(widget.user.email).
    collection("cart").document(value).delete();

    setState(() {
//      streamCntrl.sink.add(--counter);
//      --counter;
      _saved.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomColors customColors = CustomColors();
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Booking(user: widget.user,name: widget.name,photoUrl: widget.photoUrl,)),
        );
      },

      child: Padding(
        padding: const EdgeInsets.only(bottom:2.0),
        child: Card(
          margin: EdgeInsets.only(right: 8.0),
          child: Column(
            children: <Widget>[
              widget.photoUrl==null?Image.asset("images/haircut.jpg",width: 150.0,height:150.0,fit: BoxFit.fill,)
            :Image.network(widget.photoUrl,width: 150.0,height:150.0,fit: BoxFit.fill,),
            Text(widget.name,style: TextStyle(color: customColors.accentColor,fontSize: 20.0,),),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("\$10",style: TextStyle(color: customColors.primaryTextColor),),
                  SizedBox(width: 14.0,),
                  _saved.contains(widget.name)?IconButton(icon: Icon(Icons.add_shopping_cart,color:Colors.green), onPressed: () {
                    streamCntrl.sink.add(--counter);
                    _discardItem(widget.name);
                    print(_saved.toString());
                    print(counter);
                  },
                  ):IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.grey,), onPressed: () {
                    streamCntrl.sink.add(++counter);
                    _saveItem(widget.name);
                    print(_saved.toString());
                    print(counter);
                  },
                  ),

                ],
              ),

            ],
          ),
//          elevation: 2.0,
        ),
      ),
    );
  }
}
