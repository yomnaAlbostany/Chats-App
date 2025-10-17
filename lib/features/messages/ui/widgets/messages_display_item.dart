import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/messages/logic/messages_cubit.dart';
import 'package:chat_app/features/messages/logic/messages_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesDisplayItem extends StatelessWidget {
  const MessagesDisplayItem({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessagesCubit>();
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        if (state is MessageLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          color: AppColor.textColor,
          child: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  controller: cubit.scrollController,
                  itemBuilder: (context, index) {
                    bool isSender =
                        cubit.messages[index].senderId ==
                        FirebaseAuth.instance.currentUser!.uid;
                    return Row(
                      mainAxisAlignment:
                          isSender
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.78,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomLeft:
                                  isSender
                                      ? Radius.circular(0)
                                      : Radius.circular(15),
                              bottomRight:
                                  isSender
                                      ? Radius.circular(15)
                                      : Radius.circular(0),
                            ),
                            color:
                                isSender
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 10,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        isSender
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        cubit.messages[index].messageContent,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              isSender
                                                  ? Colors.black
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary,
                                        ),
                                      ),
                                      Text(
                                        cubit.messages[index].time
                                            .split(' ')[1]
                                            .substring(0, 5),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              isSender
                                                  ? AppColor.hintColor
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSender)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3,
                                      left: 10,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (_) => AlertDialog(
                                                title: Text('Select an option'),
                                                content: Column(
                                                  spacing: 15,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        cubit.deleteMessage(
                                                          cubit
                                                              .messages[index]
                                                              .id,
                                                        );
                                                        context.pop();
                                                      },
                                                      child: Row(
                                                        spacing: 10,
                                                        children: [
                                                          Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        cubit.onEdit(
                                                          cubit
                                                              .messages[index]
                                                              .id,
                                                        );
                                                        cubit
                                                            .messageController
                                                            .text = cubit
                                                                .messages[index]
                                                                .messageContent;
                                                        context.pop();
                                                      },
                                                      child: Row(
                                                        spacing: 10,
                                                        children: [
                                                          Icon(Icons.edit),
                                                          Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        );
                                      },
                                      child: Icon(Icons.more_vert, size: 20),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, _) => SizedBox(height: 13),
                  itemCount: cubit.messages.length,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
