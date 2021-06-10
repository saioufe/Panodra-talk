import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                    Text(
                      user.displayName,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
                    icon: Icons.settings_outlined,
                    function: () {
                      print("this is settings");
                    },
                  ),
                  DrawerItem(
                    title: "Invite Friends",
                    icon: Icons.person_add_alt_1_outlined,
                    function: () {
                      print("this is Invite Friends");
                    },
                  ),
                  const Divider(),
                  DrawerItem(
                    title: "About Talk's",
                    icon: Icons.help_outline_rounded,
                    function: () {
                      print("this is Invite Talk's About");
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
  final Function() function;
  final IconData icon;
  const DrawerItem({this.title, this.function, this.icon});

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
            Icon(icon, size: 30, color: Colors.grey),
            const SizedBox(
              width: 45,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
