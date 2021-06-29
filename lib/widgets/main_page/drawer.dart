import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/events.dart';

class DrawerWidget extends StatelessWidget {
  @override
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(-0.4, -0.8),
                    stops: [0.0, 0.5, 0.5, 1],
                    colors: [
                      Theme.of(context).appBarTheme.color,
                      Theme.of(context).appBarTheme.color,
                      Theme.of(context).appBarTheme.color.withOpacity(0.9),
                      Theme.of(context).appBarTheme.color.withOpacity(0.9),
                    ],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        maxRadius: 31,
                        backgroundImage: NetworkImage(
                          user.photoURL != null
                              ? user.photoURL
                              : "https://via.placeholder.com/150C/O https://placeholder.com/",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        "user.displayName",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      user.phoneNumber,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  DrawerItem(
                    title: "Settings",
                    titleColor: Colors.black,
                    icon: Icon(LineIcon.wrench().icon,
                        size: 30, color: Colors.grey),
                    function: () {
                      print("this is settings");
                    },
                  ),
                  DrawerItem(
                    title: "Invite Friends",
                    titleColor: Colors.black,
                    icon: Icon(LineIcon.userPlus().icon,
                        size: 30, color: Colors.grey),
                    function: () {
                      print("this is Invite Friends");
                    },
                  ),
                  const Divider(),
                  DrawerItem(
                    title: "About Talk's",
                    titleColor: Colors.black,
                    icon: Icon(LineIcon.questionCircle().icon,
                        size: 30, color: Colors.grey),
                    function: () {
                      print("this is Invite Talk's About");
                    },
                  ),
                  DrawerItem(
                    title: "Sign Out",
                    titleColor: Colors.redAccent,
                    icon: Icon(
                      LineIcon.powerOff().icon,
                      size: 30,
                      color: Colors.redAccent,
                    ),
                    function: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        LoggedOut(),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Function() function;
  final Icon icon;
  const DrawerItem({this.title, this.titleColor, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Row(
          children: [
            // Icon(icon, size: 30, color: Colors.grey),
            icon,
            const SizedBox(
              width: 45,
            ),
            Text(
              title,
              style: TextStyle(color: titleColor, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
