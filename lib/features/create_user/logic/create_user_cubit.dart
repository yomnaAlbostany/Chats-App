import 'dart:developer';
import 'dart:io';
import 'package:chat_app/features/create_user/logic/create_user_state.dart';
import 'package:chat_app/features/create_user/models/create_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserIntialState());

  Dio dio = Dio();
  File? image;
  String imagePath='';
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  pickImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
      uploadImage();
      emit(CreateUserPickImageState());
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
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
  }

  createUser() async {
    if (formKey.currentState!.validate()) {
      emit(CreateUserLoadingState());
      try {
        final db = FirebaseFirestore.instance;
        final data = CreateUserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: nameController.text,
          email: FirebaseAuth.instance.currentUser!.email!,
          imageUrl: imagePath
        );
        await db
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(data.toMap());
        log(data.imageUrl!);
        emit(CreateUserSuccessState());
      } on FirebaseException catch (e) {
        emit(CreateUserErrorState(e.message ?? e.toString()));
      }
    }
  }
}
