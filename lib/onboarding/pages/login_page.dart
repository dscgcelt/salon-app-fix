import 'package:flutter/material.dart';
import 'package:salon_app_new/home/home_screen.dart';
import 'package:salon_app_new/onboarding/heading.dart';
import 'package:salon_app_new/onboarding/image_with_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyLoginPage extends StatefulWidget {
  final String _subheading;
  final String _backgroundImage;
  final String _footer;


  MyLoginPage(this._subheading, this._backgroundImage, this._footer);

  @override
  MyLoginPageState createState() {
    return new MyLoginPageState();
  }
}

class MyLoginPageState extends State<MyLoginPage> {

   bool isLoggedIn = false;
  
  void _signInWithGoogle() async {

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'gid': googleUser.id,
        });
      }
    }
    isLoggedIn = await googleSignIn.isSignedIn();
    if(isLoggedIn){
      
       Fluttertoast.showToast(msg: "Sign In Successfull");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> HomeScreen(user: firebaseUser,),)
 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: <Widget>[
      ImageWithGradient(widget._backgroundImage),
      ListView(
              children:<Widget>[ Column(
          children: <Widget>[
            HeadingWidget(),
            SizedBox(height: 10.0),
            // Container(
            //   padding: EdgeInsets.all(20.0),
            // ),
            Text(widget._subheading,
                style: TextStyle(fontSize: 30.0, color: Colors.white)),
                SizedBox(height: 10.0),
                _GoogleLoginBtn(context),
                SizedBox(height: 8.0),
                Text('OR',
                style: TextStyle(color: Colors.white),
                ),
            Container(
              margin: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 25.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "you@example.com", labelText: "Email"),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Your password here...",
                            labelText: "Password"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                          child: new Text(
                            'Login',
                            style: new TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(widget._footer,
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center)
          ],
        ),
              ],
      )

    ]
      
       ),
    );
  }

  Widget _GoogleLoginBtn(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        child:MaterialButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Log in with   ',
             style: TextStyle(fontSize: 20.0),
            ),
            Image(image: AssetImage('images/google_logo.png'),
             height: 60.0,
             width: 40.0,
             fit: BoxFit.contain,
            )
          ],
           
        ),
        splashColor: Colors.green,
        height: 45.0,
        minWidth: 45.0,
        onPressed: _signInWithGoogle,
      ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.white,
        elevation: 15.0,
      ),
    );
  }

   
}
