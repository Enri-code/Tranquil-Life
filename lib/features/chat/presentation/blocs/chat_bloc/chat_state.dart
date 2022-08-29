part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({this.chatIndex = 0});

  final int chatIndex;

  ChatState copyWith({int? chatIndex}) {
    return ChatState(chatIndex: chatIndex ?? this.chatIndex);
  }

  @override
  List<Object> get props => [chatIndex];
}
