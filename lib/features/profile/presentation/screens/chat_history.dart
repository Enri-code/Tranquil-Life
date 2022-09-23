import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/chat_history_card.dart';

class ChatHistoryScreen extends StatelessWidget {
  static const routeName = 'chat_history_screen';
  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Chat history'),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, index) {
          return const ChatHistoryCard();
        },
      ),
    );
  }
}
