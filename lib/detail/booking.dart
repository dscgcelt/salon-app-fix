import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app_new/home/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_app_new/barber/barberCatalogue.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

class Booking extends StatefulWidget {
  final FirebaseUser user;
  final String name;
  final String photoUrl;
  Booking({this.user,this.name,this.photoUrl});
  
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  DateTime date;
  TimeOfDay time;
    static var selectedDate = DateTime.now();
    static var selectedDateTime = DateTime.now();
    static var selectedTime = TimeOfDay.now();
    static var _dateFormat = DateFormat('dd-MM-yyyy');
    static var _timeFormat = DateFormat("h:mm a");

  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay pickedTime = await showTimePicker(
       context: context,
       initialTime: selectedTime,
       
    );
    if(pickedTime != null && pickedTime != selectedTime)
    setState(() {
      selectedTime = pickedTime;
    });
  }

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
       context: context,
       initialDate: selectedDate,
       firstDate: DateTime(2009),
       lastDate: DateTime(2110),
    ); 
    if(picked !=null && picked != selectedDate)
    setState(() {
     selectedDate = picked; 
     selectedDateTime = picked; //for emergencycase
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomColors customColors = CustomColors();
//    CollectionReference collectionReference = Firestore.instance.collection("users");
    List<Widget> widgets = List<Widget>();
//    for (var i = 0; i < 9; i++) {
//      widgets.add(Catalogue());
//    }
//    widgets.add(Catalogue(user: widget.user,));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Book your appointment"),
          backgroundColor: customColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8.0)),
                Center(
                    child: widget.photoUrl==null?CircularProgressIndicator():Image.network(
                      widget.photoUrl,
                      height: 300,
                      width: 300,
                    )),
                Text(widget.name),
                // new ListTile(
                //   leading: const Icon(Icons.calendar_today),
                //   title: new TextField(
                //     decoration: new InputDecoration(
                //       hintText: "Date",
                      
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.fromLTRB(80.0, 0.0, 20.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text("${_dateFormat.format(selectedDate)}",
          
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                      ),
                      SizedBox(width: 30.0),
                      FloatingActionButton(onPressed: () => _selectDate(context),
                      child: const Icon(Icons.calendar_today) ,
                      elevation: 8.0,
                      heroTag: "fab1",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.0,),
                // new ListTile(
                //   leading: const Icon(Icons.access_time),
                //   title: new TextField(
                //     decoration: new InputDecoration(
                //       hintText: "Timing",
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.fromLTRB(80.0, 0.0, 20.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text("${selectedTime.format(context)}",
                      // Text("${_timeFormat.format(selectedDateTime)}",
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                      ),
                      SizedBox(width: 55.0,),
                      FloatingActionButton(onPressed: () =>_selectTime(context),
                        child: const Icon(Icons.access_time),
                        elevation: 8.0,
                        heroTag: "fab2",
                      ),
                    ],
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.speaker_notes),
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Extra Notes",
                    ),
                  ),
                ),
                const Divider(
                  height: 8.0,
                ),
                Text(
                  "Pick Your barber",
                  style: TextStyle(color: customColors.primaryColor),
                ),
//                Container(
//                  margin: EdgeInsets.only(top: 8.0,bottom: 16.0),
//                  height: 223.0,
//                  child: ListView(
//                    scrollDirection: Axis.horizontal,
//                    children: widgets,
//                  ),
//                ),

                 Container(
                   margin:EdgeInsets.only(top: 8.0,bottom: 16.0),
                   height: 223.0,
                   child: StreamBuilder(
              stream: Firestore.instance.collection("barbers").snapshots(),
              builder: (BuildContext context,snapshot){
//                print(snapshot.data.documents[0]['photo']);
                if(!snapshot.hasData)
                {
                     return CircularProgressIndicator();
                }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, int i) {
                        print("HI>>"+i.toString());
                        print(snapshot.data.documents[i]['photoUrl'].toString());
                        return BarberCatalogue(name: snapshot.data.documents[i]['name'],
                          photoUrl: snapshot.data.documents[i]['photo'],
                          rating: snapshot.data.documents[i]['rating'],
                          skills: null,
                        );
                      },
                      itemCount: snapshot.data.documents.length,
                    );

              }

            ),
                 ),


                RaisedButton(onPressed: (){
                  print(widget.user.email);
                  Firestore.instance.collection('users').document(widget.user.email)
                  .collection("bookings").document(selectedDate.toIso8601String()+selectedTime.toString()).
                  setData
                  ({
                    'date' : selectedDate.toString(),
                    'time' : selectedTime.toString(),
                  });
                  Fluttertoast.showToast(msg: "Booked ${widget.user.uid}", toastLength: Toast.LENGTH_SHORT);
                 Navigator.pop(context);
                },
                child: Text("Book your date"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
