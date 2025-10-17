import 'package:chat_app/core/customs/custom_button.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/create_account/logic/create_account_cubit.dart';
import 'package:chat_app/features/create_account/logic/create_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreateAccountHeader extends StatelessWidget {
  const CreateAccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateAccountCubit>();
    return Stack(
      children: [
        SvgPicture.asset('assets/svgs/Rectangle3.svg'),
        Positioned(
          top: 50,
          right: 26,
          left: 23,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    btnColor: Theme.of(context).colorScheme.onPrimary.withAlpha(230),
                    textColor: Theme.of(context).colorScheme.secondary,
                    text: 'Login',
                    onPressed: () {
                      context.pushReplacementNamed(Routes.login);
                    },
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              BlocConsumer<CreateAccountCubit, CreateAccountState>(
                builder: (context, state) {
                  return Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: const Color(0xFF88CFF0),
                          child:
                              cubit.image != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image.file(cubit.image!,width: double.infinity,fit: BoxFit.cover,))
                                  : SvgPicture.asset(
                                    'assets/svgs/Vector.svg',
                                    width: 90,
                                  ),
                        ),
                        Positioned(
                          top: -10,
                          right: -17,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary.withAlpha(230),
                                    title: Text(
                                      'Select an option',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomButton(
                                              width: 90,
                                              btnColor: Theme.of(context).colorScheme.onPrimary.withAlpha(230),
                                              textColor: Theme.of(context).colorScheme.secondary,
                                              text: 'Camera',
                                              onPressed: () {
                                                cubit.pickImage(true);
                                              },
                                            ),
                                            CustomButton(
                                              width: 90,
                                              btnColor: Theme.of(context).colorScheme.onPrimary.withAlpha(230),
                                              textColor: Theme.of(context).colorScheme.secondary,
                                              text: 'Gallery',
                                              onPressed: () {
                                                cubit.pickImage(false);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/ButtonIcon.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                listener: (BuildContext context, CreateAccountState state) {
                  if (state is PickImageState) {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
