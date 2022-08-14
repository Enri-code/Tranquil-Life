import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/screens/image_full_view.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/replied_chat_box.dart';

class SenderChatImage extends StatelessWidget {
  const SenderChatImage(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.6,
      child: SenderChatBoxBase(
        padding: 3,
        time: message.timeSent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (message is ReplyMessage)
              RepliedChatBox(
                message as ReplyMessage,
                backgroundColor: Color.lerp(
                  Colors.black,
                  Theme.of(context).primaryColor,
                  0.82,
                )!,
              ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ImageFullView.routeName,
                    arguments: ImageFullViewData(
                      heroTag: message.text,
                      image: (message.isSent
                              ? NetworkImage(message.text)
                              : FileImage(File(message.text)))
                          as ImageProvider<Object>,
                    ),
                  );
                },
                child: Hero(
                  tag: message.text,
                  child: Builder(
                    builder: (_) {
                      final errorBuilder = Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.broken_image_outlined,
                                size: 80,
                                color: Colors.grey[700],
                              ),
                              Text(
                                'Image unavailable',
                                style: TextStyle(
                                  color: Colors.grey[800]!,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      if (message.isSent) {
                        return Image.network(
                          message.text,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => errorBuilder,
                        );
                      }
                      return Image.file(
                        File(message.text),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => errorBuilder,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
