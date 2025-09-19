import 'dart:developer';
import 'package:chat_app/core/custom/custom_formfeild.dart';
import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversations_state.dart';
import 'package:chat_app/features/conversations/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: BlocBuilder<ConversationCubit, ConversationsState>(
          builder: (context, state) {
            return Column(
              spacing: 30,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  child:
                      user.imageUrl != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.network(
                              user.imageUrl!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                          : SvgPicture.asset('assets/svgs/Vector.svg'),
                ),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Column(
                  spacing: 20,
                  children: [
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Name : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.hintColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            user.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: user.name),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Text copied to clipboard "),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                          child: Image.asset('assets/images/Copy.png'),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.hintColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            user.email,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: user.email),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Text copied to clipboard "),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                          child: Image.asset('assets/images/Copy.png'),
                        ),
                      ],
                    ),
                  ],
                ),

                Column(
                  spacing: 15,
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.nameController.text = user.name;
                        cubit.emailController.text = user.email;

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,

                          builder:
                              (context) => SizedBox(
                                height: 660,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    left: 20,
                                    right: 20,
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 20,
                                    children: [
                                      Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Form(
                                            child: Column(
                                              spacing: 15,
                                              children: [
                                                Column(
                                                  spacing: 5,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Name',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.hintColor,
                                                      ),
                                                    ),
                                                    CustomFormfeild(
                                                      hintText: 'Name',
                                                      controller:
                                                          cubit.nameController,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  spacing: 5,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Email',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.hintColor,
                                                      ),
                                                    ),
                                                    CustomFormfeild(
                                                      hintText: 'Email',
                                                      controller:
                                                          cubit.emailController,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  spacing: 5,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Password',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.hintColor,
                                                      ),
                                                    ),
                                                    CustomFormfeild(
                                                      hintText: 'Password',
                                                      controller:
                                                          cubit
                                                              .passwordController,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                context.pop();
                                              },
                                              child: Container(
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withAlpha(60),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: BlocConsumer<
                                              ConversationCubit,
                                              ConversationsState
                                            >(
                                              listener: (context, state) {
                                                if (state
                                                    is EditProfileSuccessState) {
                                                  log('success');
                                                  context.pop();
                                                } else if (state
                                                    is EditProfileErrorState) {
                                                  log('error');
                                                  context.pop();
                                                }
                                              },
                                              builder: (context, state) {
                                                return InkWell(
                                                  onTap:
                                                      state
                                                              is EditProfileLoadingState
                                                          ? null // تعطيل الزر وقت التحميل
                                                          : () {
                                                            cubit.editUser();
                                                            context.pop();
                                                          },
                                                  child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            25,
                                                          ),
                                                    ),
                                                    child: Center(
                                                      child:
                                                          state
                                                                  is EditProfileLoadingState
                                                              ? CircularProgressIndicator(
                                                                color:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .colorScheme
                                                                        .onPrimary,
                                                              )
                                                              : Text(
                                                                'Save',
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Theme.of(
                                                                        context,
                                                                      ).colorScheme.onPrimary,
                                                                ),
                                                              ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                        );
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/Pen.png'),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xffFEECEB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/Logout.png'),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffF6695E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
