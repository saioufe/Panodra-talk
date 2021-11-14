import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:pandora_talks/models/chat_bar.dart';

class ChatScreen extends StatefulWidget {
  final ChatBar chatBar;
  const ChatScreen({this.chatBar});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Duration duration = new Duration();

  Duration position = new Duration();

  bool isPlaying = false;

  bool isLoading = false;

  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatBar.name),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BubbleSpecialOne(
                text: 'bubble special one with tail',
                isSender: false,
                color: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              DateChip(
                date: new DateTime(now.year, now.month, now.day - 1),
              ),
              BubbleSpecialOne(
                text: 'bubble special one with tail',
                color: Color(0xFFE8E8EE),
                seen: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
