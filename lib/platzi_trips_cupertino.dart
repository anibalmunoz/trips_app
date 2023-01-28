import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/User/bloc/bloc_user.dart';
import 'package:platzi_trips/User/ui/screens/profile_trips.dart';
import 'Place/ui/screens/home_trips.dart';
import 'Place/ui/screens/search_trips.dart';

class PlatziTripsCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   /* final List<Widget> widgetsChildren = [
      HomeTrips(),
      SearchTrips(),
      BlocProvider(child: ProfileTrips(), bloc: BlocUser())
    ];

    */

    final scafold = Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.indigo), label: ("")),
           BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.indigo), label: ("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.indigo), label: ("")),
        ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider(
                    bloc: BlocUser(),
                    child: HomeTrips(),
                  );
                },
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => SearchTrips(),
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider<BlocUser>(
                    bloc: BlocUser(),
                    child: ProfileTrips(),
                  );
                },
              );
              break;
            default:
              return CupertinoTabView(
                builder: (BuildContext context) => HomeTrips(),
              );
              break;
          }
        },
      ),
    );

    return scafold;
  }
}
