import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';

class TextLayout extends StatelessWidget {
  const TextLayout({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        message.data,
        style: TextStyle(color: message.fromYou ? Colors.white : Colors.black),
      ),
    );
  }
}
