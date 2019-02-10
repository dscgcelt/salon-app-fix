import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_app_new/home/catalogue.dart';
import 'package:salon_app_new/util/custom_colors.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

class Booking extends StatefulWidget {
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
     selectedDateTime = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomColors customColors = CustomColors();
    List<Widget> widgets = List<Widget>();
    for (var i = 0; i < 10; i++) {
      widgets.add(Catalogue());
    }
    return MaterialApp(
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
                    child: Image.asset(
                      "images/haircut.jpg",
                      height: 300,
                      width: 300,
                    )),
                Text("Mohawk"),
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
                Container(
                  margin: EdgeInsets.only(top: 8.0,bottom: 16.0),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: widgets,
                  ),
                ),
                RaisedButton(onPressed: (){},child: Text("Pick your barber"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
