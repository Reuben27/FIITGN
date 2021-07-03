import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SplashScreen.dart';

// ignore: must_be_immutable
class SignInGoogle extends StatefulWidget {
  static const routeName = '\SignInScreen';
  bool isSignedIn = false;
  setIsSignedIn(bool val) {
    isSignedIn = val;
  }

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

logoutUser() async {
  final GoogleSignIn googleSignInObject = GoogleSignIn();
  // FirebaseUser fireBaseUser;
  // final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  print('Logging Out');
  await googleSignInObject.signOut();
  await FirebaseAuth.instance.signOut();
}

class SignInClass {
  BuildContext context;
  SignInClass({this.context});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(); //hostedDomain: 'iitgn.ac.in',
  //     scopes: <String>[
  //   'email',
  //   'https://www.googleapis.com/auth/calendar',
  // ]);
  static var authHeaders;

  signIn() async {
    print("Sign In Function was called");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print("%%%%%%%%%%%%%%%%%%%%");
    authHeaders = await googleSignIn.currentUser.authHeaders;
    // googleSignIn.currentUser.
    print("***************");
    print(authHeaders);
    print("***************");
    print("x");
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("y");
    UserCredential result = await _auth.signInWithCredential(credential);
    print("z");
    User user = _auth.currentUser;
    print(user.uid);
    final idTOKEN = await user.getIdToken();
    String uid = user.uid;
    print("alpha");
    // String token = idTOKEN.token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("range 1");
    prefs.setString('uid', uid);
    prefs.setString('email', user.email);
    prefs.setString('name', user.displayName);
    prefs.setString('userDisplay', user.photoURL);
    print("range 2");
    print("All user creds have been set");
    // prefs.setString('token', token);
    // SignInGoogle().isSignedIn = true;
    // isSignedInPrivate = true;
    // print(SignInGoogle().isSignedIn);
    print("Sign In Successful");
    print("/////////////////////////");
    Navigator.pushReplacementNamed(
        context, SplashScreen.routeName); // return true
  }

  logoutUser() async {
    print('Logging Out');
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}

class _SignInGoogleState extends State<SignInGoogle> {
  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: key,
      body: Stack(
        children: [
          Image.asset(
            'assets/iitgnCamp.jpg',
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.height / 20),
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.height / 20),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.asset(
                            "assets/iitgnlogo-emblem.png",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Text(
                            "FIITGN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width / 7,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                          child: Text(
                            "THE COMPLETE FITNESS APP",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 18,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        SignInButtonBuilder(
                          text: 'Login with IITGN ID',
                          icon: Icons.email,
                          onPressed: () async {
                            await SignInClass(context: context).signIn();

                            // if (outCome == false) {
                            //   // _showSnackBar();
                            // }
                          },
                          backgroundColor: Color(0xFF3F7B70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
