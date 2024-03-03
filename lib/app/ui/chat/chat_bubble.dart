import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Member member;
  final bool isUser;
  final BoxDecoration bubbleDecoration;
  final TextStyle messagePayloadTextStyle;
  final EdgeInsets messagePayloadPadding;
  final TextStyle messageMemberNameTextStyle;
  final EdgeInsets messageMemberNamePadding;
  final TextStyle messageCreatedAtTextStyle;
  final EdgeInsets messageCreatedAtPadding;

  const ChatBubble({
    super.key,
    required this.message,
    required this.member,
    required this.messagePayloadTextStyle,
    required this.bubbleDecoration,
    required this.isUser,
    required this.messageMemberNameTextStyle,
    required this.messageCreatedAtTextStyle,
    required this.messagePayloadPadding,
    required this.messageMemberNamePadding,
    required this.messageCreatedAtPadding,
  });

  @override
  Widget build(BuildContext context) {
    Alignment align = Alignment.centerLeft;
    CrossAxisAlignment bubbleAlignment = CrossAxisAlignment.start;
    if (isUser) {
      align = Alignment.centerRight;
      bubbleAlignment = CrossAxisAlignment.end;
    }
    return Align(
      alignment: align,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: bubbleAlignment,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Text(
                member.name,
                style: messageMemberNameTextStyle,
              ),
            ),
          Container(
            decoration: bubbleDecoration,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.payload,
                    style: messagePayloadTextStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              TimeUtil.dateFormat(message.createdAt),
              style: messageCreatedAtTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
