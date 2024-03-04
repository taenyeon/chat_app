import 'package:any_link_preview/any_link_preview.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:chat_app/app/util/validator/validate_util.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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

    String? url = ValidateUtil.getUrl(message.payload);

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
                  buildPayload(message.payload, url),
                ],
              ),
            ),
          ),
          if (url != null && url.isNotEmpty) buildLinkPreview(url),
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

  Widget buildPayload(String payload, String? url) {
    return EasyRichText(
      payload,
      defaultStyle: messagePayloadTextStyle,
      selectable: true,
      patternList: [
        if (url != null)
          EasyRichTextPattern(
            targetString: url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(url));
              },
            prefixInlineSpan: const WidgetSpan(
                child: Icon(
              Icons.insert_link_outlined,
              color: Colors.blue,
              size: 14,
            )),
            hasSpecialCharacters: true,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
            ),
          )
      ],
    );
  }

  Widget buildLinkPreview(String url) {
    Alignment errorAlignment = Alignment.centerLeft;
    if (isUser) errorAlignment = Alignment.centerRight;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: SizedBox(
        width: 250,
        child: AnyLinkPreview(
          link: url,
          displayDirection: UIDirection.uiDirectionVertical,
          bodyMaxLines: 5,
          bodyTextOverflow: TextOverflow.ellipsis,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          bodyStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          errorBody: "메타 데이터를 가져오는데 실패하였습니다.",
          errorWidget: Align(
            alignment: errorAlignment,
            child: const Text(
              "URL을 불러오는데 실패하였습니다.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          cache: const Duration(days: 1),
          backgroundColor: Colors.black.withOpacity(0.75),
          borderRadius: 12,
          removeElevation: false,
          boxShadow: const [
            BoxShadow(
              blurRadius: 0,
              color: Colors.grey,
            ),
          ],
          previewHeight: 150,
        ),
      ),
    );
  }
}
