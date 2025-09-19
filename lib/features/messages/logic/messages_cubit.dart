import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/conversations/models/user_model.dart';
import 'package:chat_app/features/messages/logic/messages_state.dart';
import 'package:chat_app/features/messages/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesIntialState());

  final messageController = TextEditingController();
  sendMessage(ConversationModel conversation) async {
    emit(SendMessageLoadingState());
    if (messageController.text.isNotEmpty) {
      try {
        final db = FirebaseFirestore.instance;
        final data = MessageModel(
          DateTime.now().millisecondsSinceEpoch.toString(),
          messageController.text,
          user.uid,
          user.name,
          user.email,
          conversation.uid,
          conversation.name,
          conversation.email,
          "${TimeOfDay.now().hourOfPeriod.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')} ${TimeOfDay.now().period == DayPeriod.am ? "AM" : "PM"}",
        );
        await db.collection('Messages').doc(data.id).set(data.toMap());
        messageController.clear();
        emit(SendMessageSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(SendMessageErrorState(e.message ?? e.toString()));
      }
    } else {
      emit(SendMessageErrorState('Please enter your message first'));
    }
  }

  List<MessageModel> messages = [];
  getMessage(ConversationModel conversation) async {
    emit(MessageLoadingState());
    try {
      final db = FirebaseFirestore.instance;
      db.collection('Messages').snapshots().listen((event) async {
        messages.clear();
        List<MessageModel> allMessages = [];
        for (var doc in event.docs) {
          final data = doc.data();
          allMessages.add(MessageModel.fromMap(data));
        }
        List<MessageModel> filteredMessage =
            allMessages
                .where(
                  (e) =>
                      (e.senderId == FirebaseAuth.instance.currentUser!.uid &&
                          e.recieverId == conversation.uid) ||
                      (e.senderId == conversation.uid &&
                          e.recieverId ==
                              FirebaseAuth.instance.currentUser!.uid),
                )
                .toList();
        messages = filteredMessage.toList();
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
    } catch (e) {}
  }

  final ScrollController scrollController = ScrollController();

  deleteMessage(String id) async {
    final db = FirebaseFirestore.instance;
    await db.collection('Messages').doc(id).delete();
  }

  updateMessage() async {
    final db = FirebaseFirestore.instance;
    await db.collection('Messages').doc(mesaageId).update({
      'message': messageController.text,
    });
    messageController.clear();
    mesaageId = null;
    emit(MessageUpdateState(false));
  
  }

  String? mesaageId;
  onUpdate(String id) {
    mesaageId = id;
    emit(MessageUpdateState(true));
  }
}
