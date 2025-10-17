import 'dart:developer';

import 'package:chat_app/core/customs/custom_button.dart';
import 'package:chat_app/core/customs/custom_formfeild.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override 
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<ConversationCubit>(),
              child: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.83,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            spacing: 5,
                            children: [
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  spacing: 6,
                                  children: [
                                    Column(
                                      spacing: 1,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: const Color(0xFF454545),
                                          ),
                                        ),
                                        CustomFormfeild(
                                          hintText: cubit.user!.name,
                                          controller: cubit.nameController,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 1,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: const Color(0xFF454545),
                                          ),
                                        ),
                                        CustomFormfeild(
                                          keyboardType: TextInputType.phone,
                                          prefix: Text(
                                            '  (+20)',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          hintText: cubit.user!.phone,
                                          controller: cubit.phoneController,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 1,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: const Color(0xFF454545),
                                          ),
                                        ),
                                        CustomFormfeild(
                                          keyboardType: TextInputType.emailAddress,
                                          hintText: cubit.user!.email,
                                          controller: cubit.emailController,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 1,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: const Color(0xFF454545),
                                          ),
                                        ),
                                        CustomFormfeild(
                                          hintText: 'Password',
                                          controller: cubit.passwordController,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomButton(
                                width: double.infinity,
                                vpadding: 14,
                                hpadding: 50,
                                fontsize: 18,
                                btnColor: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(40),
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                                text: 'Cancel',
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                            ),
                            Expanded(
                              child: BlocConsumer<
                                ConversationCubit,
                                ConversationState
                              >(
                                listener: (context, state) {
                                  if (state is UpdateProfileSuccesState) {
                                    log('success');
                                    context.pop();
                                    cubit.nameController.clear();
                                    cubit.emailController.clear();
                                    cubit.phoneController.clear();
                                    cubit.passwordController.clear();
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UpdateProfileLoadingState) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return CustomButton(
                                    width: double.infinity,
                                    vpadding: 14,
                                    hpadding: 57,
                                    fontsize: 18,
                                    btnColor:
                                        Theme.of(context).colorScheme.primary,
                                    textColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    text: 'Save',
                                    onPressed: () {
                                      cubit.editProfile();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(13),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Color(0xff40C4FF)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Image.asset('assets/images/Pen.png'),
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generateFlag() {
    String countryCode = 'eg';
    return countryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }
}
