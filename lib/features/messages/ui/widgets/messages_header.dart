import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagesHeader extends StatelessWidget {
  final ConversationModel conversation;
  const MessagesHeader({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
      child: Row(
        spacing: 13,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(100),
            child:
                conversation.profileUrl != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(conversation.profileUrl!,width: double.infinity,fit: BoxFit.cover,))
                    : SvgPicture.asset('assets/svgs/Vector.svg',width: 30,fit: BoxFit.cover,),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(conversation.name,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
                Text('(+20) ${conversation.phone}',style: TextStyle(
                  color: AppColor.hintColor,
                  fontSize: 17,
                ),)
              ],
            ),
          ),
          SvgPicture.asset('assets/svgs/mobile.svg')
          
        ],
      ),
    );
  }
}
