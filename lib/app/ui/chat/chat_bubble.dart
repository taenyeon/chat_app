import 'package:any_link_preview/any_link_preview.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:chat_app/app/util/validator/validate_util.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';
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
    MainAxisAlignment mainAxisAlignment =
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start;

    String? url = ValidateUtil.getUrl(message.payload!);

    if (isUser) {
      align = Alignment.centerRight;
      bubbleAlignment = CrossAxisAlignment.end;
    }
    return Align(
      alignment: align,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: member.profileUrl != null
                      ? Image.network(
                          member.profileUrl!,
                          fit: BoxFit.cover,
                        )
                      : Text(member.name.toUpperCase()[0]),
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: bubbleAlignment,
            children: [
              if (!isUser)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 10, 3),
                  child: Text(
                    member.name,
                    style: messageMemberNameTextStyle,
                  ),
                ),
              Container(
                decoration: bubbleDecoration,
                child: buildPayload(message, url, context),
              ),
              if (url != null && url.isNotEmpty && message.type == 'TEXT')
                buildLinkPreview(url),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 5, 8),
                child: Text(
                  TimeUtil.dateFormatHHMM(message.createdAt),
                  style: messageCreatedAtTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPayload(ChatMessage message, String? url, BuildContext context) {
    switch (message.type) {
      case "TEXT":
        {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: EasyRichText(
                message.payload!,
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
              ),
            ),
          );
        }
      case "IMAGE":
        {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PhotoView(
                        imageProvider: NetworkImage(message.payload!),
                        initialScale: 1.0,
                        maxScale: 3.0,
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.white10,
                        ),
                      );
                    });
              },
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(message.payload!)),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          );
        }
      default:
        {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
          );
        }
    }
  }

  Widget buildLinkPreview(String url) {
    Alignment errorAlignment = Alignment.centerLeft;
    if (isUser) errorAlignment = Alignment.centerRight;
    return Padding(
      padding: isUser
          ? const EdgeInsets.fromLTRB(0, 5, 0, 0)
          : const EdgeInsets.fromLTRB(0, 5, 0, 0),
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

  Widget test() {
    return GestureDetector();
  }
}
