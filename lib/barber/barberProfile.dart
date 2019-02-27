import 'package:flutter/material.dart';

class BarberProfile extends StatefulWidget {
  final String name;
  final String picurl;
  final int rating;
  BarberProfile({this.name, this.picurl, this.rating});

  @override
  _BarberProfileState createState() => _BarberProfileState();
}

class _BarberProfileState extends State<BarberProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          // padding: EdgeInsets.only(top: 100.0),
          margin: EdgeInsets.fromLTRB(00.0, 100.0, 00.0, 25.0),

          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                   CircleAvatar(
                     backgroundImage: widget.picurl==null?AssetImage('images/haircut.jpg',):NetworkImage(widget.picurl),
                     radius: 80.0,
                   ),
                   SizedBox(height: 25.0),
                   Text("   "+"Barber name : "+ widget.name+"   ",
                   style: TextStyle(
                     fontSize: 27.0,
                     color: Colors.black,
                     fontStyle: FontStyle.normal,
                     fontWeight: FontWeight.bold
                   ),
                   ),
                   SizedBox(height: 25.0),
                   Text("Rating : "+ "${widget.rating}",
                   style: TextStyle(
                     fontSize: 27.0,
                     color: Colors.black,
                   ),),
                   SizedBox(height: 25.0),
                  Text('Specs : \nMohawk, FrenchCut',
                  style: TextStyle(
                     fontSize: 27.0,
                     color: Colors.black,
                   ),
                  )
                ],
              ),
            
          ),
        ),
      ),
    );
  }
}
