import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: SafeArea(
          child: Text("saif"),
        ),
      ),
    );
  }
}
