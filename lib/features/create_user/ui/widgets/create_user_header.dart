import 'package:chat_app/core/custom/custom_btn.dart';
import 'package:chat_app/core/custom/custom_button.dart';
import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/create_user/logic/create_user_cubit.dart';
import 'package:chat_app/features/create_user/logic/create_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreateUserHeader extends StatelessWidget {
  const CreateUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateUserCubit>();
    return Stack(
      children: [
        SvgPicture.asset('assets/svgs/Rectangle3.svg'),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Column(
              spacing: 25,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        context.pushReplacementNamed(Routes.register);
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<CreateUserCubit, CreateUserState>(
                  listener: (context, state) {
                    if (state is CreateUserPickImageState) {
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: AppColor.textColor.withAlpha(190),
                          child:
                              cubit.image == null
                                  ? SvgPicture.asset(
                                    'assets/svgs/Vector.svg',
                                    width: double.infinity,
                                    height: 101,
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(65),
                                    child: Image.file(cubit.image!,width: double.infinity,fit: BoxFit.cover,)),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => AlertDialog(
                                      title: Text('Select an option'),
                                      content: Row(
                                        children: [
                                          Expanded(
                                            child: CustomBtn(
                                              text: 'Camera',
                                              onPressed: () {
                                                cubit.pickImage(true);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomBtn(
                                              text: 'Gallery',
                                              onPressed: () {
                                                cubit.pickImage(false);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/ButtonIcon.svg',
                              width: 100,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
