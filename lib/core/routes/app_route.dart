import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/conversations/logic/conversation_cubit.dart';
import 'package:chat_app/features/conversations/models/conversation_model.dart';
import 'package:chat_app/features/conversations/ui/conversations_screen.dart';
import 'package:chat_app/features/create_user/logic/create_user_cubit.dart';
import 'package:chat_app/features/create_user/ui/create_user.dart';
import 'package:chat_app/features/login/logic/login_cubit.dart';
import 'package:chat_app/features/login/ui/login_screen.dart';
import 'package:chat_app/features/messages/logic/messages_cubit.dart';
import 'package:chat_app/features/messages/ui/messages_screen.dart';
import 'package:chat_app/features/register/logic/register_cubit.dart';
import 'package:chat_app/features/register/ui/register_screen.dart';
import 'package:chat_app/features/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case Routes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => LoginCubit(),
                child: LoginScreen(),
              ),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => RegisterCubit(),
                child: RegisterScreen(),
              ),
        );
      case Routes.createUser:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CreateUserCubit(),
                child: CreateUser(),
              ),
        );
      case Routes.conversations:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) =>
                        ConversationCubit()
                          ..getConversations()
                          ..getUser(),
                child: ConversationsScreen(),
              ),
        );
      case Routes.messages:
        final args = setting.arguments as ConversationModel;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => MessagesCubit()..getMessage(args),
                child: MessagesScreen(coversation: args),
              ),
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
