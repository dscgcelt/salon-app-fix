import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app_new/detail/booking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'barberProfile.dart';

class BarberCatalogue extends StatelessWidget {
//  final FirebaseUser user;
  final String photoUrl;
  final String name;
  final int rating;
  List<String> skills = <String>[];
  BarberCatalogue({this.name,this.photoUrl,this.rating,this.skills});

  @override
  Widget build(BuildContext context) {
    CustomColors customColors = CustomColors();
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarberProfile(name: name, picurl: photoUrl, rating: rating,)),
        );
      },

      child: Padding(
        padding: const EdgeInsets.only(bottom:2.0),
        child: Card(
          margin: EdgeInsets.only(right: 8.0),
          child: Column(
            children: <Widget>[
              photoUrl==null?Image.asset("images/haircut.jpg",width: 150.0,height:150.0,fit: BoxFit.fill,)
                  :Image.network(photoUrl,width: 150.0,height:150.0,fit: BoxFit.fill,),
              Text(name,style: TextStyle(color: customColors.accentColor,fontSize: 20.0,),),
              Text("Rating: "+rating.toString(),style: TextStyle(color: customColors.accentColor,fontSize: 20.0,),),
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
    );
  }
}
