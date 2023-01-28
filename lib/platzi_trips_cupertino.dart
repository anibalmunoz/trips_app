import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/User/ui/screens/profile_trips.dart';
import 'Place/ui/screens/home_trips.dart';
import 'Place/ui/screens/search_trips.dart';

class PlatziTripsCupertino extends StatelessWidget {
  const PlatziTripsCupertino({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scafold = Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.indigo), label: ("")),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.indigo), label: ("")),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.indigo), label: ("")),
        ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => BlocProvider(bloc: BlocUser(), child: HomeTrips()),
              );
            case 1:
              return CupertinoTabView(builder: (BuildContext context) => SearchTrips());
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) => BlocProvider<BlocUser>(bloc: BlocUser(), child: ProfileTrips()),
              );
            default:
              return CupertinoTabView(builder: (BuildContext context) => HomeTrips());
          }
        },
      ),
    );

    return scafold;
  }
}
