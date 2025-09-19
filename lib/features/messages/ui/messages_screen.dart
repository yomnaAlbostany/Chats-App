import 'package:chat_app/core/custom/custom_formfeild.dart';
import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/conversations/models/user_model.dart';
import 'package:chat_app/features/messages/logic/messages_cubit.dart';
import 'package:chat_app/features/messages/logic/messages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MessagesScreen extends StatelessWidget {
  final ConversationModel coversation;
  const MessagesScreen({super.key, required this.coversation});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessagesCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: Text('Messages', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                spacing: 10,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha(130),
                    radius: 25,
                    child:
                        coversation.imageUrl != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                coversation.imageUrl!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset(
                                'assets/svgs/Vector.svg',
                                width: 40,
                                height: 45,
                              ),
                            ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coversation.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          coversation.email,
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset('assets/svgs/mobile.svg'),
                ],
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Color(0xffF0F0F3)),
                child: BlocBuilder<MessagesCubit, MessagesState>(
                  builder: (context, state) {
                    if (state is MessageLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return BlocBuilder<MessagesCubit, MessagesState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView.separated(
                                controller: cubit.scrollController,
                                itemBuilder: (context, index) {
                                  bool isSender =
                                      cubit.messages[index].senderId ==
                                      user.uid;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        isSender
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.7,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isSender
                                                  ? Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(
                                              isSender ? 0 : 15,
                                            ),
                                            bottomRight: Radius.circular(
                                              isSender ? 15 : 0,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(13),
                                          child: Row(
                                            spacing: 15,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  spacing: 5,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      isSender
                                                          ? CrossAxisAlignment
                                                              .start
                                                          : CrossAxisAlignment
                                                              .end,
                                                  children: [
                                                    Text(
                                                      cubit
                                                          .messages[index]
                                                          .message,
                                                      style: TextStyle(
                                                        color:
                                                            isSender
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),

                                                    Text(
                                                      cubit
                                                          .messages[index]
                                                          .time,
                                                      style: TextStyle(
                                                        color:
                                                            isSender
                                                                ? AppColor
                                                                    .hintColor
                                                                : Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (isSender)
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (_) => AlertDialog(
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    cubit.deleteMessage(
                                                                      cubit
                                                                          .messages[index]
                                                                          .id,
                                                                    );
                                                                    context
                                                                        .pop();
                                                                  },
                                                                  child: SizedBox(
                                                                    height: 50,
                                                                    child: Row(
                                                                      spacing:
                                                                          10,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                        Text(
                                                                          'Delete',
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    cubit
                                                                        .messageController
                                                                        .text = cubit
                                                                            .messages[index]
                                                                            .message;
                                                                    context
                                                                        .pop();
                                                                    cubit.onUpdate(
                                                                      cubit
                                                                          .messages[index]
                                                                          .id,
                                                                    );
                                                                  },
                                                                  child: SizedBox(
                                                                    height: 50,
                                                                    child: Row(
                                                                      spacing:
                                                                          10,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .edit,
                                                                          
                                                                        ),
                                                                        Text(
                                                                          'Edit',
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.more_vert,
                                                    size: 20,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (_, _) => SizedBox(height: 13),
                                itemCount: cubit.messages.length,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomFormfeild(
                          hintText: 'Type a message...',
                          controller: cubit.messageController,
                        ),
                      ),
                      state is SendMessageLoadingState
                          ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : InkWell(
                            onTap: () {
                              if (cubit.mesaageId!=null) {
                                cubit.updateMessage();
                              }
                              else{
                                cubit.sendMessage(coversation);
                              }
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/send.svg',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
