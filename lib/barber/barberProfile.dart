import 'package:flutter/material.dart';
import 'package:salon_app_new/detail/booking.dart';

class BarberProfile extends StatefulWidget {
  final String name;
  final String picurl;
  final int rating;
  BarberProfile({this.name, this.picurl, this.rating});

  @override
  _BarberProfileState createState() => _BarberProfileState();
}

class _BarberProfileState extends State<BarberProfile>{

  // @override
  // didPopRoute(){
  //   Navigator.pushReplacement(context, 
  //  MaterialPageRoute(
  //    builder: (context)=>Booking()
  //  ));
  //   return Future<bool>.value(true);
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
             onWillPop: () async => false,
          child: Scaffold(
  
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
                        ),
                        SizedBox(height: 25.0),
                        MaterialButton(
                          child: Text('BACK to Booking',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          color: Colors.purple,
                          padding: EdgeInsets.all(5.0),
                          onPressed: () => Navigator.of(context).pop(true),
                        )
                      ],
                    ),
                  
                ),
              ),
            ),
          
      ),
    );
  }
}
