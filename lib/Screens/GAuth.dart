import 'package:fiitgn/Providers/DataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
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
  final GoogleSignIn googleSignIn = GoogleSignIn(
    hostedDomain: 'iitgn.ac.in',
  );
  //     scopes: <String>[
  //   'email',
  //   'https://www.googleapis.com/auth/calendar',
  // ]);
  static var authHeaders;

  signIn() async {
    // print("Sign In Function was called");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    // print("%%%%%%%%%%%%%%%%%%%%");
    authHeaders = await googleSignIn.currentUser.authHeaders;
    // googleSignIn.currentUser.
    // print("***************");
    // print(authHeaders);
    // print("***************");
    // print("x");
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    // print("y");
    UserCredential result = await _auth.signInWithCredential(credential);
    // print("z");
    User user = _auth.currentUser;
    // print(user.uid);
    final idTOKEN = await user.getIdToken();
    String uid = user.uid;
    // print("alpha");
    // String token = idTOKEN.token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("range 1");
    prefs.setString('uid', uid);
    prefs.setString('email', user.email);
    prefs.setString('name', user.displayName);
    prefs.setString('userDisplay', user.photoURL);
    // String uid = prefs.getString('uid');
    String email = user.email;
    String name = user.displayName;
    String userDisplay = user.photoURL;
    final data_provider = Provider.of<Data_Provider>(context, listen: false);
    data_provider.setUid(uid);
    data_provider.setEmailId(email);
    data_provider.setDisplay(userDisplay);
    data_provider.setName(name);
    // print("range 2");
    // print("Uids and tokens are set");
    // prefs.setString('token', token);
    // SignInGoogle().isSignedIn = true;
    // isSignedInPrivate = true;
    // print(SignInGoogle().isSignedIn);
    // print("Sign In Successful");
    // print("/////////////////////////");
    Navigator.pushReplacementNamed(context, SplashScreen.routeName); // return true
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
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    var key = new GlobalKey<ScaffoldState>();

    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        key: key,
        body: Stack(
          children: [
            Image.asset(
              'assets/iitgnCamp.jpg',
              height: 0.4 * _screenHeight,
              width: _screenWidth,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 0.35 * _screenHeight,
                ),
                Expanded(
                  child: Container(
                    width: _screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFFC9CCD5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.05 * _screenHeight),
                        topRight: Radius.circular(0.05 * _screenHeight),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.03 * _screenHeight),
                          child: Container(
                            height: 0.2 * _screenHeight,
                            child: Image.asset(
                              "assets/icon.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 0.04 * _screenHeight),
                          child: Text(
                            "FIITGN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 0.1 * _screenHeight,
                                color: Colors.black,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        SignInButtonBuilder(
                          height: 0.06 * _screenHeight,
                          width: 0.5 * _screenWidth,
                          text: 'Login with IITGN ID',
                          fontSize: 0.02 * _screenHeight,
                          icon: Icons.email,
                          onPressed: () async {
                            await SignInClass(context: context).signIn();
                          },
                          backgroundColor: Color(0xFF3F7B70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
