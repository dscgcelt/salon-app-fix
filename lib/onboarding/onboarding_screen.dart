import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_app_new/onboarding/pages/first_page.dart';
import 'package:salon_app_new/onboarding/pages/login_page.dart';
import 'package:salon_app_new/onboarding/pages/second_page.dart';
import 'package:salon_app_new/onboarding/pages/third_page.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_app_new/home/home_screen.dart';


class OnBoardingApp extends StatefulWidget {

  @override
  OnBoardingAppState createState() {
    return new OnBoardingAppState();
  }
}

class OnBoardingAppState extends State<OnBoardingApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero,(){
      _signinHome();
    });

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    List<Image> icons = List<Image>();
    icons.add(Image.asset("images/scissor_icon.png"));
    icons.add(Image.asset("images/massage_icon.png"));
    icons.add(Image.asset("images/shave_icon.png"));

    List<String> backgroundImages = List<String>();
    backgroundImages.add("images/haircut.jpg");
    backgroundImages.add("images/massage_pic.png");
    backgroundImages.add("images/shaving_pic.png");
    backgroundImages.add("images/salon_shop.png");

    final myController = PageController(
      initialPage: 0,
    );
    PageView pageView = PageView(
      controller: myController,
      children: <Widget>[
        MyFirstPage("Need a Haircut?",icons[0],backgroundImages[0],"Our barbers are \nthe best in town"),
        MySecondPage("Need a Massage?",icons[1],backgroundImages[1],"Let our massagers \nrelax you"),
        MyThirdPage("Need a Shave?",icons[2],backgroundImages[2],"Get your beard \ncleaned and trimmed"),
        MyLoginPage("Need an Appointment?",backgroundImages[3],"We won't disappoint you"),
      ],
      physics: BouncingScrollPhysics(),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(children: <Widget>[
        PageIndicatorContainer(
          pageView: pageView,
          length: 4,
          indicatorSpace: 10.0,
          indicatorSelectorColor:Color(0xFFf15e5e),
        ),
      ]),
    );
  }

  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount _googleSignInAccount;
  FirebaseUser _user;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void _signinHome() async{
    GoogleSignInAuthentication googleAuth;
    bool isSignedIn = await googleSignIn.isSignedIn();
    if(isSignedIn){
      _googleSignInAccount = await googleSignIn.signIn();
      googleAuth = await _googleSignInAccount.authentication;
      _user = await firebaseAuth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ).catchError((e)=>Fluttertoast.showToast(msg: "Sign In Failed"));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(user: _user,)
        ),
      );
    }else{
      return;
    }
  }

}
