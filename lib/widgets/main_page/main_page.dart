import 'package:flutter/material.dart';
import 'package:pandora_talks/models/chat_bar.dart';
import 'package:pandora_talks/widgets/main_page/chat_bar.dart';
import 'package:pandora_talks/widgets/main_page/main_appBar.dart';

class MainScreen extends StatelessWidget {
  MainScreen();

  var _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: IconButton(
            icon: Icon(
              Icons.maps_ugc_rounded,
              color: Colors.white,
            ),
            onPressed: () {}),
      ),
      appBar: MainAppBar(context),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            ChatBarTemplate(
              chatBar: ChatBar(
                id: 1,
                name: "Saif Maher",
                lastMessage: "this is the last message for the saif document",
                date: "10:00 PM",
                image:
                    "https://upload.wikimedia.org/wikipedia/commons/4/4e/A_profile.jpg",
              ),
            ),
            ChatBarTemplate(
              chatBar: ChatBar(
                id: 2,
                name: "Fatima",
                lastMessage: "Love you",
                date: "12:00 AM",
                image:
                    "https://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
