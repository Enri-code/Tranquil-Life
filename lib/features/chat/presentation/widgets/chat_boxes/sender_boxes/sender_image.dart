import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/screens/image_full_view.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/replied_chat_box.dart';

class SenderChatImage extends StatelessWidget {
  const SenderChatImage(this.message, {Key? key}) : super(key: key);
  final Message message;

  static final _errorWidget = Container(
    color: Colors.grey[300],
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.broken_image_outlined,
            color: Colors.grey[700],
            size: 80,
          ),
          Text(
            'Image unavailable',
            style: TextStyle(color: Colors.grey[800]!, fontSize: 18),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      padding: 3,
      time: message.timeSent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message is ReplyMessage)
            Padding(
              padding: const EdgeInsets.all(2),
              child: RepliedChatBox(
                message as ReplyMessage,
                backgroundColor: Color.lerp(
                  Colors.black,
                  Theme.of(context).primaryColor,
                  0.82,
                )!,
              ),
            ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ImageFullView.routeName,
                  arguments: ImageFullViewData(
                    heroTag: message.data,
                    image: (message.isSent
                            ? NetworkImage(message.data)
                            : FileImage(File(message.data)))
                        as ImageProvider<Object>,
                  ),
                );
              },
              child: Hero(
                tag: message.data,
                child: Builder(
                  builder: (_) {
                    Widget _frameBuilder(_, Widget child, int? frame, __) {
                      if (frame == null) return CustomLoader.widget();
                      return child;
                    }

                    if (message.isSent) {
                      return Image.network(
                        message.data,
                        fit: BoxFit.cover,
                        frameBuilder: _frameBuilder,
                        errorBuilder: (_, __, ___) => _errorWidget,
                      );
                    }
                    return Image.file(
                      File(message.data),
                      fit: BoxFit.cover,
                      frameBuilder: _frameBuilder,
                      errorBuilder: (_, __, ___) => _errorWidget,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
