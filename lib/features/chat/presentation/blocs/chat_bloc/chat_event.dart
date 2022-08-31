part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ScrollToChatEvent extends ChatEvent {
  const ScrollToChatEvent(this.index);
  final int index;
}

enum MediaType { gallery, camera, audio, document, any }

class UploadChatMediaEvent extends ChatEvent {
  const UploadChatMediaEvent(this.type);
  final MediaType type;
}
