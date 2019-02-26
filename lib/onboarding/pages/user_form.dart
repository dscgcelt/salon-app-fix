import 'package:flutter/material.dart';
import 'package:salon_app_new/home/home_screen.dart';
import 'package:salon_app_new/onboarding/heading.dart';
import 'package:salon_app_new/onboarding/image_with_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserForm extends StatefulWidget {
//  final String _subheading;
  final String _backgroundImage;
//  final String _footer;
  final FirebaseUser firebaseUser;
  final GoogleSignInAccount googleUser;
  UserForm(this._backgroundImage,this.firebaseUser,this.googleUser);

  @override
  UserFormState createState() {
    return new UserFormState();
  }
}

class UserFormState extends State<UserForm> {

//  bool isLoggedIn = false;
//
//  void _signInWithGoogle() async {
//
//    final GoogleSignIn googleSignIn = GoogleSignIn();
//    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//    GoogleSignInAccount googleUser = await googleSignIn.signIn();
//
//    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    if (firebaseUser != null) {
//      final QuerySnapshot result = await Firestore.instance
//          .collection('users')
//          .where('id', isEqualTo: firebaseUser.uid)
//          .getDocuments();
//      final List<DocumentSnapshot> documents = result.documents;
//
//      if (documents.length == 0) {
//        Firestore.instance
//            .collection('users')
//            .document(firebaseUser.email)
//            .setData({
//          'nickname': firebaseUser.displayName,
//          'photoUrl': firebaseUser.photoUrl,
//          'id': firebaseUser.uid,
//          'gid': googleUser.id,
//        });
//      }
//    }
//    isLoggedIn = await googleSignIn.isSignedIn();
//    if(isLoggedIn){
//
//      Fluttertoast.showToast(msg: "Sign In Successfull");
//
//      Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (context)=> HomeScreen(user: firebaseUser,),)
//
//      );
//    }
//  }



  _handleSubmit() async {
//
    Firestore.instance
        .collection('users')
        .document(widget.firebaseUser.email)
        .setData({
          'nickname': widget.firebaseUser.displayName,
          'photoUrl': widget.firebaseUser.photoUrl,
          'id': widget.firebaseUser.uid,
          'gid': widget.googleUser.id,
          'name': name,
          'email':widget.firebaseUser.email,
          'DOB': DOB,
          'phone':phone,
        });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> HomeScreen(user: widget.firebaseUser,),)

    );
  }

  TextEditingController _nameController;
//  TextEditingController _emailController;
  TextEditingController _phoneController;
//  TextEditingController _passwordController;
//  TextEditingController _confrimPassController;
  TextEditingController _DOBController;

  String name;
//  String email;
  String phone;
  String pass;
  String confirmPass;
  String DOB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            ImageWithGradient(widget._backgroundImage),
            ListView(
              children:<Widget>[ Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
//                  HeadingWidget(),
//                  SizedBox(height: 10.0),
                  // Container(
                  //   padding: EdgeInsets.all(20.0),
                  // ),
//                  Text(widget._subheading,
//                      style: TextStyle(fontSize: 30.0, color: Colors.white)),
//                  SizedBox(height: 10.0),
//                  _GoogleLoginBtn(context),
//                  SizedBox(height: 8.0),
//                  Text('OR',
//                    style: TextStyle(color: Colors.white),
//                  ),
                  Container(

                    margin: EdgeInsets.fromLTRB(28.0, 76.0, 28.0, 10.0),
                    alignment: Alignment.center,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              onSubmitted: (value)=>name = value,
                              onChanged: (value)=>name=value,
                              decoration: InputDecoration(
                                  hintText: "Type your name...", labelText: "Name"),
                            ),
                            SizedBox(height: 10.0,),
//                            TextField(
//                              controller: _emailController,
//                              keyboardType: TextInputType.emailAddress,
//                              decoration: InputDecoration(
//                                  hintText: "you@example.com", labelText: "Email"),
//                            ),
//                            SizedBox(height: 10.0,),
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              onSubmitted: (value)=>phone = value,
                                onChanged: (value)=>phone=value,
                              decoration: InputDecoration(
                                  hintText: "Please type your Phone No.", labelText: "Phone No."),
                            ),
                            SizedBox(height: 10.0,),
//                            TextField(
//                              controller: _passwordController,
//                              obscureText: true,
//                              decoration: InputDecoration(
//                                  hintText: "Your password here...",
//                                  labelText: "Password"),
//                            ),
//                            SizedBox(height: 10.0,),
//                            TextField(
//                              controller: _confrimPassController,
//                              obscureText: true,
//                              decoration: InputDecoration(
//                                  hintText: "Retype the password...",
//                                  labelText: "Confirm Password"),
//                            ),
                            TextField(
                              controller: _DOBController,
                              keyboardType: TextInputType.text,
                              onSubmitted: (value)=>DOB = value,
                              onChanged: (value)=>DOB=value,
                              decoration: InputDecoration(
                                  hintText: "Please type your date of birth", labelText: "D.O.B."),
                            ),
                            SizedBox(height: 10.0,),

                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: RaisedButton(
                                child: new Text(
                                  'Submit',
                                  style: new TextStyle(color: Colors.white),
                                ),
                                onPressed: _handleSubmit,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                      ),
                    ),
                  ),
//                  Text(widget._footer,
//                      style: TextStyle(
//                          fontSize: 30.0,
//                          color: Colors.white,
//                          fontStyle: FontStyle.italic),
//                      textAlign: TextAlign.center)
                ],
              ),
              ],
            ),

          ]

      ),
    );
  }

//  Widget _GoogleLoginBtn(BuildContext context){
//    return Padding(
//      padding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 0.0),
//      child: Material(
//        borderRadius: BorderRadius.circular(30.0),
//        child:MaterialButton(
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text('Log in with   ',
//                style: TextStyle(fontSize: 20.0),
//              ),
//              Image(image: AssetImage('images/google_logo.png'),
//                height: 60.0,
//                width: 40.0,
//                fit: BoxFit.contain,
//              )
//            ],
//
//          ),
//          splashColor: Colors.green,
//          height: 45.0,
//          minWidth: 45.0,
//          onPressed: _signInWithGoogle,
//        ),
//        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//        color: Colors.white,
//        elevation: 15.0,
//      ),
//    );
//  }


}
