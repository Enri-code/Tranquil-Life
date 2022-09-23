part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chatIndex = 0,
    this.consultant,
    this.messages = const [],
  });

  final int chatIndex;
  final Consultant? consultant;
  final List<Message> messages;

  ChatState copyWith({int? chatIndex, Consultant? consultant}) {
    return ChatState(
      chatIndex: chatIndex ?? this.chatIndex,
      consultant: consultant ?? this.consultant,
    );
  }

  @override
  List<Object?> get props => [chatIndex, consultant, messages];
}
