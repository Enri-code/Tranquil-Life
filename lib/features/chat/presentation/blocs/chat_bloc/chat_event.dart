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

class AddMessage extends ChatEvent {
  const AddMessage(this.message);
  final Message message;
}
