import 'package:chat_app/core/customs/custom_button.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/logic/conversation_state.dart';
import 'package:chat_app/features/conversations/ui/widgets/edit_profile.dart';
import 'package:chat_app/features/conversations/ui/widgets/info_item.dart';
import 'package:chat_app/features/conversations/ui/widgets/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConversationCubit>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<ConversationCubit, ConversationState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              spacing: 13,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    BlocConsumer<ConversationCubit, ConversationState>(
                      listener: (context, state) {
                        if (state is PickImageState) {
                          context.pop();
                        }
                      },
                      builder: (context, state) {
                        return CircleAvatar(
                          radius: 70,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(100),
                          child:
                              cubit.user!.profileUrl != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image.network(
                                      cubit.user!.profileUrl!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : SvgPicture.asset(
                                    'assets/svgs/Vector.svg',
                                    width: 90,
                                  ),
                        );
                      },
                    ),
                    Positioned(
                      top: -10,
                      right: -20,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('Select an option'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomButton(
                                      width: double.infinity,
                                      btnColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary.withAlpha(230),
                                      textColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                      text: 'Camera',
                                      onPressed: () {
                                        cubit.pickImage(true);
                                      },
                                    ),
                                    CustomButton(
                                      width: double.infinity,
                                      btnColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary.withAlpha(230),
                                      textColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                      text: 'Gallery',
                                      onPressed: () {
                                        cubit.pickImage(false);
                                      },
                                    ),
                                    CustomButton(
                                      width: double.infinity,
                                      btnColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary.withAlpha(230),
                                      textColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                      text: 'Delete',
                                      onPressed: () {
                                        cubit.deleteProfileImage();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset('assets/svgs/ButtonIcon.svg'),
                      ),
                    ),
                  ],
                ),
                Text(
                  cubit.user!.name,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF282828),
                  ),
                ),
                Column(
                  children: [
                    InfoItem(label: 'Name : ', content: cubit.user!.name),
                    InfoItem(
                      label: 'Phone : ',
                      content: '(+20) ${cubit.user!.phone}',
                    ),
                    InfoItem(label: 'Email : ', content: cubit.user!.email),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: EditProfile(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: LogoutWidget(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
