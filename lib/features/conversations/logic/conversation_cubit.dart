import 'dart:developer';
import 'dart:io';

import 'package:chat_app/features/conversations/logic/conversation_state.dart';
import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/conversations/models/user_model.dart';
import 'package:chat_app/features/conversations/ui/widgets/chats_pages.dart';
import 'package:chat_app/features/conversations/ui/widgets/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit() : super(ConversationIntialState());

  int currentPage = 0;
  changePage(int index) {
    currentPage = index;
    emit(ChangePagesState());
  }

  List<Widget> screens = [ChatsPages(), ProfilePage()];

  List<ConversationModel> conversations = [];
  UserModel? user;

  getConversation() async {
    emit(ConversationLoadingState());
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
      conversations.clear();
      for (var doc in response.docs) {
        final data = ConversationModel.fromMap(doc.data());
        conversations.add(data);
      }
      emit(ConversationSuccessState());
    } on FirebaseException catch (e) {
      emit(ConversationErrorState(e.message ?? e.toString()));
    }
  }

  getUser() async {
    emit(UserLoadingState());
    final db = FirebaseFirestore.instance;
    final response =
        await db
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    user = UserModel.fromMap(response.data()!);
    userModel = UserModel.fromMap(response.data()!);
    emit(UserSuccessState());
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  File? image;
  Dio dio = Dio();
  String imagePath = '';
  pickImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
      await uploadImage();
      getUser();
      emit(PickImageState());
    }
  }

  Future uploadImage() async {
    if (image == null) return;

    String cloudName = "drv2uki4x";
    String uploadPreset = "flutter_images";

    String url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image!.path,
        filename: "profile.jpg",
      ),
      "upload_preset": uploadPreset,
    });

    try {
      Response response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        imagePath = response.data["secure_url"];
        log(imagePath);
        final db = FirebaseFirestore.instance;
        await db.collection('Users').doc(user!.uid).update({
          'profileUrl': imagePath,
        });
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
  }

  editProfile() async {
    emit(UpdateProfileLoadingState());
    User? u = FirebaseAuth.instance.currentUser;
    if (u != null && passwordController.text.isNotEmpty) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email,
        password: passwordController.text,
      );

      await u.reauthenticateWithCredential(credential);

      await u.verifyBeforeUpdateEmail(emailController.text);
    }
    final db = FirebaseFirestore.instance;
    await db.collection('Users').doc(user!.uid).update({
      'name': nameController.text.isEmpty ? user!.name : nameController.text,
      'phone':
          phoneController.text.isEmpty ? user!.phone : phoneController.text,
      'email':
          emailController.text.isEmpty ? user!.email : emailController.text,
    });
    getUser();
    emit(UpdateProfileSuccesState());
  }

  deleteProfileImage() async {
    final db = FirebaseFirestore.instance;
    await db.collection('Users').doc(user!.uid).update({'profileUrl': null});
    getUser();
    emit(PickImageState());
  }
}
