import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversation_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return BlocBuilder<ConversationCubit, ConversationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            leading: SvgPicture.asset('assets/svgs/leading.svg'),
            title: Text(
              'Chats',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       FirebaseAuth.instance.signOut();
            //       context.pushNamedAndRemoveUntil(Routes.login);
            //     },
            //     icon: Icon(Icons.abc),
            //   ),
            // ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentPage,
            onTap: (value) {
              cubit.changePage(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          body: cubit.screens[cubit.currentPage],
        );
      },
    );
  }
}
