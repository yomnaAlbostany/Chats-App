import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/messages/logic/messages_cubit.dart';
import 'package:chat_app/features/messages/logic/messages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SendMessageBar extends StatelessWidget {
  final ConversationModel conversation;
  const SendMessageBar({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessagesCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: cubit.messageController,
              decoration: InputDecoration(
                hintText: 'Type a message ...',
                hintStyle: TextStyle(color: const Color(0xFF6D7177)),
                filled: true,
                fillColor: AppColor.textColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          InkWell(
            onTap: () {
              if (cubit.messageId != null) {
                cubit.editMessage();
              }else{
                cubit.sendMessage(conversation);

              }
              
            },
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is SendMessageLoadingState) {
                  return CircularProgressIndicator();
                }
                return SvgPicture.asset(
                  'assets/svgs/send.svg',
                  width: 75,
                  height: 73,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
