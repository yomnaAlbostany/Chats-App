import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return BlocBuilder<ConversationCubit, ConversationsState>(
        builder: (context, state) {
          if (state is ConversationsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
              itemBuilder:
                  (context, index) => InkWell(
                    onTap:
                        () => context.pushNamed(
                          Routes.messages,
                          cubit.conversations[index],
                        ),
                    child: Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(130),
                          radius: 30,
                          child:
                              cubit.conversations[index].imageUrl != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      cubit.conversations[index].imageUrl!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : SvgPicture.asset(
                                    'assets/svgs/Vector.svg',
                                    width: 40,
                                    height: 45,
                                  ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.conversations[index].name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                cubit.conversations[index].email,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              separatorBuilder: (_, _) => SizedBox(height: 15),
              itemCount: cubit.conversations.length,
            ),
          );
        },
      );
  }
}