import 'package:equatable/equatable.dart';

class ChatBar extends Equatable {
  final int id;
  final String name;
  final String lastMessage;
  final String date;
  final String image;
  const ChatBar({
    this.id,
    this.name,
    this.lastMessage,
    this.date,
    this.image,
  });
  @override
  List<Object> get props => [
        id,
        name,
        lastMessage,
        date,
        image,
      ];
}
