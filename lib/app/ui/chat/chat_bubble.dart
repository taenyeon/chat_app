import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:chat_app/app/util/validator/validate_util.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
          if (!isUser) ChatProfile(member: member),
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
                ChatLinkPreview(isUser: isUser, url: url),
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
        return ChatText(
            messagePayloadTextStyle: messagePayloadTextStyle,
            message: message,
            url: url);
      case "FILE":
        {
          bool isImage = ValidateUtil.isImage(message.payload!);
          if (isImage) {
            return ChatImage(message: message);
          } else {
            return ChatFile(message: message);
          }
        }
      default:
        return buildDefaultMessage();
    }
  }

  ConstrainedBox buildDefaultMessage() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 250),
    );
  }
}

class ChatProfile extends StatelessWidget {
  const ChatProfile({
    super.key,
    required this.member,
  });

  final Member member;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class ChatText extends StatelessWidget {
  const ChatText({
    super.key,
    required this.messagePayloadTextStyle,
    required this.message,
    required this.url,
  });

  final TextStyle messagePayloadTextStyle;
  final ChatMessage message;
  final String? url;

  @override
  Widget build(BuildContext context) {
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
                    launchUrl(Uri.parse(url!));
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
}

class ChatFile extends StatelessWidget {
  const ChatFile({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: buildFileIcon(message),
    );
  }

  Align buildFileIcon(ChatMessage message) {
    var fileName = message.payload!.split("/").last;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async => onTapFile(message),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.file_present_outlined,
                    size: 50,
                    color: Colors.white10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: EasyRichText(
                        fileName,
                        defaultStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapFile(ChatMessage message) async {
    String? dirPath = await FilePicker.platform.getDirectoryPath();

    if (dirPath != null) {
      var split = message.payload!.split("/");
      var fileName = split[split.length - 1];
      var filePath = "$dirPath/$fileName";

      var response = await http.get(Uri.parse(message.payload!));
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      openFile(filePath);
    }
  }

  void openFile(String filePath) {
    if (Platform.isWindows) {
      Process.run('start', [filePath]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [filePath]);
    } else if (Platform.isMacOS) {
      Process.run('open', [filePath]);
    }
  }
}

class ChatImage extends StatelessWidget {
  const ChatImage({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.black,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ChatPhotoViewer(message: message),
                );
              });
        },
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain, image: NetworkImage(message.payload!)),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Image.network(
            message.payload!,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChatPhotoViewer extends StatelessWidget {
  const ChatPhotoViewer({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    var photoViewController = PhotoViewController();
    var minScale = PhotoViewComputedScale.contained * 0.5;
    var maxScale = PhotoViewComputedScale.covered * 2;
    var currentScale = PhotoViewComputedScale.contained * 0.5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                )),
          ],
        ),
        Expanded(
          child: SizedBox(
            height: 500,
            child: PhotoView(
              imageProvider: NetworkImage(message.payload!),
              minScale: minScale,
              maxScale: maxScale,
              initialScale: currentScale,
              backgroundDecoration: const BoxDecoration(
                color: Colors.white10,
              ),
              controller: photoViewController,
            ),
          ),
        ),
        Container(
          height: 50,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    if (photoViewController.scale! < maxScale.multiplier) {
                      photoViewController.scale =
                          (photoViewController.scale! + 0.1);
                    }
                  },
                  icon: const Icon(
                    Icons.zoom_in,
                    color: Colors.limeAccent,
                  )),
              IconButton(
                  onPressed: () {
                    if (photoViewController.scale! >= 0.1) {
                      photoViewController.scale =
                          (photoViewController.scale! - 0.1);
                    }
                  },
                  icon: const Icon(
                    Icons.zoom_out,
                    color: Colors.limeAccent,
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class ChatLinkPreview extends StatelessWidget {
  const ChatLinkPreview({
    super.key,
    required this.isUser,
    required this.url,
  });

  final bool isUser;
  final String url;

  @override
  Widget build(BuildContext context) {
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
