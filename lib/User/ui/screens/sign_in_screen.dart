import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/User/model/user.dart' as Model;
import 'package:platzi_trips/platzi_trips_cupertino.dart';
import 'package:platzi_trips/widgets/gradient_back.dart';
import 'package:platzi_trips/widgets/button_green.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  late BlocUser blocUser;
  late double screedWidht;

  @override
  Widget build(BuildContext context) {
    screedWidht = MediaQuery.of(context).size.width;
    blocUser = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: blocUser.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUi();
        } else {
          return const PlatziTripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUi() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(altura: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  width: (screedWidht - 10.0),
                  child: const Text(
                    "Bienvenido \nEsta es tu app de viajes",
                    style:
                        TextStyle(fontSize: 37.0, fontFamily: "Lato", color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ButtonGreeen(
                texto: "Login with Gmail",
                onPressed: () {
                  blocUser.signOut();
                  blocUser.signInWithGoogle().then((UserCredential? user) {
                    blocUser.updateUserData(
                      Model.User(
                        uid: user?.user!.uid,
                        name: (user?.user!.displayName).toString(),
                        email: (user?.user!.email).toString(),
                        photoURL: (user?.user!.photoURL).toString(),
                      ),
                    );
                  });
                },
                altura: 300.0,
                ancho: 50.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
