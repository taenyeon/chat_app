import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:local_notifier/local_notifier.dart';

class PushUtil {
  static void sendLocalPush(ChatMessage message) {
    if (message.type == "FILE") {
      message.payload = "Member Send File";
    }
    var localNotification = LocalNotification(
      title: message.roomId,
      subtitle: '${message.memberId}',
      body: message.payload,
    );

    localNotification.show();
  }
}
