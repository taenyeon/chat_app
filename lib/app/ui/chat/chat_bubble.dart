import 'dart:ffi';

import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final Member member;
  final bool isUser;
  final double bubbleHeight;
  final double bubbleWidth;
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
    required this.bubbleHeight,
    required this.bubbleWidth,
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
    if (isUser) align = Alignment.centerRight;
    return Align(
      alignment: align,
      child: Container(
        height: bubbleHeight,
        width: bubbleWidth,
        decoration: bubbleDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (!isUser)
                Text(
                  member.name,
                  style: messageMemberNameTextStyle,
                ),
              Text(
                message.payload,
                style: messagePayloadTextStyle,
              ),
              Text(
                TimeUtil.dateFormat(message.createdAt),
                style: messageCreatedAtTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
