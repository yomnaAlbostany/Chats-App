import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/conversations/models/user_model.dart';
import 'package:chat_app/features/messages/logic/messages_state.dart';
import 'package:chat_app/features/messages/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesIntialState());

  final messageController = TextEditingController();

  sendMessage(ConversationModel conversation) {
    if (messageController.text.isNotEmpty) {
      emit(SendMessageLoadingState());
      try {
        final db = FirebaseFirestore.instance;
        final id = DateTime.now().millisecondsSinceEpoch.toString();
        final data = MessageModel(
          id: id,
          messageContent: messageController.text,
          senderId: userModel.uid,
          senderName: userModel.name,
          senderEmail: userModel.email,
          recieverId: conversation.uid,
          recieverName: conversation.name,
          recieverEmail: conversation.email,
          time: DateTime.now().toString(),
        );
        db.collection('Messages').doc(id).set(data.toMap());
        emit(SendMessageSuccessState());
        messageController.clear();
      } on FirebaseException catch (e) {
        emit(SendMessageErrorState(e.message ?? e.toString()));
      }
    }
  }

  List<MessageModel> messages = [];
  getMessages(ConversationModel conversation) async {
    emit(MessageLoadingState());
    try {
      final db = FirebaseFirestore.instance;
      db.collection('Messages').snapshots().listen((event) {
        messages.clear();
        List<MessageModel> allMessages = [];
        for (var doc in event.docs) {
          final data = MessageModel.fromMap(doc.data());
          allMessages.add(data);
        }
        final filteredMessages = allMessages.where(
          (e) =>
              (e.senderId == FirebaseAuth.instance.currentUser!.uid &&
                  e.recieverId == conversation.uid) ||
              (e.recieverId == FirebaseAuth.instance.currentUser!.uid &&
                  e.senderId == conversation.uid),
        );
        messages = filteredMessages.toList();
        if (!isClosed) emit(MessageSuccessState());

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      });
    } on FirebaseException catch (e) {
      emit(MessageErrorState(e.message ?? e.toString()));
    }
  }

  final scrollController = ScrollController();

  deleteMessage(String id) async {
    await FirebaseFirestore.instance.collection('Messages').doc(id).delete();
  }

  String? messageId;
  editMessage() async {
    await FirebaseFirestore.instance
        .collection('Messages')
        .doc(messageId)
        .update({'messageContent': messageController.text});
    messageController.clear();
    messageId = null;
  }

  onEdit(String id) {
    messageId = id;
  }
}
