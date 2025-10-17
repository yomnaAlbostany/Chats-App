import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatsPages extends StatelessWidget {
  const ChatsPages({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return BlocBuilder<ConversationCubit, ConversationState>(
      builder: (context, state) {
        if (state is ConversationLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    Routes.messages,
                    arguments: cubit.conversations[index],
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(170),
                      child:
                          cubit.conversations[index].profileUrl != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  cubit.conversations[index].profileUrl!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : SvgPicture.asset(
                                'assets/svgs/Vector.svg',
                                width: 32,
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
                            style: TextStyle(fontSize: 18,
                            color: AppColor.hintColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, _) => SizedBox(height: 15),
            itemCount: cubit.conversations.length,
          ),
        );
      },
    );
  }
}
