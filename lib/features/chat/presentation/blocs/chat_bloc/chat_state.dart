part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.highlightIndex = 0,
    this.consultant,
    this.messages = const [],
  });

  final int highlightIndex;
  final Consultant? consultant;
  final List<Message> messages;

  ChatState copyWith({
    int? highlightIndex,
    Consultant? consultant,
    List<Message>? messages,
  }) {
    return ChatState(
      highlightIndex: highlightIndex ?? this.highlightIndex,
      consultant: consultant ?? this.consultant,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [highlightIndex, consultant, messages];
}
