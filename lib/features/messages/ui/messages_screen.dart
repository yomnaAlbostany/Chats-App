import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/messages/ui/widgets/messages_display_item.dart';
import 'package:chat_app/features/messages/ui/widgets/messages_header.dart';
import 'package:chat_app/features/messages/ui/widgets/send_message_bar.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final ConversationModel conversation;
  const MessagesScreen({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages',style: TextStyle(
          fontWeight: FontWeight.w500
        ),),
        centerTitle: true,
        
      ),
      body: SafeArea(
        child: Column(
          children: [
            MessagesHeader(conversation: conversation,),
            Expanded(child: MessagesDisplayItem()),
            SendMessageBar(conversation: conversation,)
          ],
        ),
      ),
    );
  }
}
