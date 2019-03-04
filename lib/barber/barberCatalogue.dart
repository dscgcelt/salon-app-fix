import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app_new/detail/booking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'barberProfile.dart';

class BarberCatalogue extends StatefulWidget {
//  final FirebaseUser user;
  final String photoUrl;
  final String name;
  final int rating;
  List<String> skills = <String>[];
  BarberCatalogue({this.name,this.photoUrl,this.rating,this.skills});

  @override
  BarberCatalogueState createState() {
    return new BarberCatalogueState();
  }
}

class BarberCatalogueState extends State<BarberCatalogue> {
  Color selcolor = Colors.white;

  bool isSelected = false;

  void togglecolor(){
    setState(() {
      if(isSelected){
        selcolor = Colors.purpleAccent;
        isSelected=false;
      }else{
        selcolor = Colors.white;
        isSelected = true;
      }
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
              builder: (context) => BarberProfile(name: widget.name, picurl: widget.photoUrl, rating: widget.rating,)),
        );
      },

      onLongPress: togglecolor,

      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        color: selcolor,
        child: Padding(
          padding: const EdgeInsets.only(bottom:2.0),
          child: Card(
//            margin: EdgeInsets.only(right: 8.0),
            child: Column(
              children: <Widget>[
                widget.photoUrl==null?Image.asset("images/haircut.jpg",width: 150.0,height:150.0,fit: BoxFit.fill,)
                    :Image.network(widget.photoUrl,width: 150.0,height:150.0,fit: BoxFit.fill,),
                Text(widget.name,style: TextStyle(color: customColors.accentColor,fontSize: 20.0,),),
                Text("Rating: "+widget.rating.toString(),style: TextStyle(color: customColors.accentColor,fontSize: 20.0,),),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Text("\$10",style: TextStyle(color: customColors.primaryTextColor),),
//                  SizedBox(width: 14.0,),
//                  IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: null),
//                ],
//              ),
              ],
            ),
//          elevation: 2.0,
          ),
        ),
      ),
    );
  }
}
