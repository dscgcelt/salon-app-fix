import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app_new/detail/booking.dart';
import 'package:salon_app_new/util/custom_colors.dart';

class Catalogue extends StatefulWidget {
//  final FirebaseUser user;
  final String photoUrl;
  final String name;
  Catalogue({this.name,this.photoUrl});

  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {

  @override
  Widget build(BuildContext context) {
    CustomColors customColors = CustomColors();
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Booking()),
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
                  IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){

                  }),
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
