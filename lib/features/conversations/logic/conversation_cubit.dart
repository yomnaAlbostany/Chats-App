import 'dart:developer';

import 'package:chat_app/features/conversations/logic/conversations_state.dart';
import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/conversations/models/user_model.dart';
import 'package:chat_app/features/conversations/ui/widgets/chat_page.dart';
import 'package:chat_app/features/conversations/ui/widgets/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationCubit extends Cubit<ConversationsState> {
  ConversationCubit() : super(ConversationsIntialState());

  int currentPage = 0;
  changePage(int value) {
    currentPage = value;
    emit(ConversationsChangePageState());
  }

  List<Widget> pages = [ChatPage(), ProfilePage()];

  List<ConversationModel> conversations = [];
  getConversations() async {
    emit(ConversationsLoadingState());
    try {
      final db = FirebaseFirestore.instance;
      final response =
          await db
              .collection('Users')
              .where(
                'uid',
                isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .get();
      for (var doc in response.docs) {
        final data = ConversationModel.fromMap(doc.data());
        conversations.add(data);
      }
      emit(ConversationsSuccessState());
    } on FirebaseException catch (_) {
      emit(ConversationsErrorState());
    }
  }

  getUser() async {
    final db = FirebaseFirestore.instance;
    final response =
        await db
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    final data = response.data();
    user = UserModel.fromMap(data!);
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  editUser() async {
    emit(EditProfileLoadingState());
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: passwordController.text,
        );

        await user.reauthenticateWithCredential(credential);

        await user.verifyBeforeUpdateEmail(emailController.text);

        final db = FirebaseFirestore.instance;
        await db.collection('Users').doc(user.uid).update({
          'name': nameController.text,
          'email': emailController.text,
        });
        getUser();
        emit(EditProfileSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      log("Auth Error: ${e.message}");
      emit(EditProfileErrorState(e.message ?? e.toString()));
    } on FirebaseException catch (e) {
      log("Firestore Error: ${e.message}");
      emit(EditProfileErrorState(e.message ?? e.toString()));
    }
  }
}
