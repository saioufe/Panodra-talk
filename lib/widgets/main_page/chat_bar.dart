import 'package:flutter/material.dart';
import 'package:pandora_talks/models/chat_bar.dart';

class ChatBarTemplate extends StatelessWidget {
  final ChatBar chatBar;
  const ChatBarTemplate({
    Key key,
    @required this.chatBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    maxRadius: 31,
                    backgroundImage: NetworkImage(chatBar.image),
                  ),
                ),
                Expanded(
                  //   flex: 7,
                  child: Column(
                    textDirection: TextDirection.ltr,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            chatBar.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                              child: Text(
                            chatBar.date,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 15,
                                    ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chatBar.lastMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            indent: 85,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
