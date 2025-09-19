import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: SvgPicture.asset('assets/svgs/leading.svg'),
        title: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        
      ),
      bottomNavigationBar: BlocBuilder<ConversationCubit, ConversationsState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: cubit.currentPage,
            onTap: (value) {
              cubit.changePage(value);
            },
            selectedItemColor: Theme.of(context).colorScheme.primary,
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primary,
            ),
            items: [
              BottomNavigationBarItem(
                icon:Icon(Icons.message_outlined) ,
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<ConversationCubit, ConversationsState>(  
        builder: (context, state) {
          return cubit.pages[cubit.currentPage];
        },
      ),
    );
  }
}
