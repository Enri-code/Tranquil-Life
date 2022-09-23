import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(const ChatState(
          consultant: Consultant(id: 0, displayName: 'Dr Charles Rique'),
        )) {
    on<ScrollToChatEvent>(_scrollTo);
    on<AddMessage>(_addMessage);
  }
  final scrollController = ItemScrollController();

  void _scrollTo(ScrollToChatEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(chatIndex: -1));
    await scrollController.scrollTo(
      alignment: 0.5,
      index: event.index,
      curve: Curves.easeOut,
      duration: kTabScrollDuration,
    );
    emit(state.copyWith(chatIndex: event.index));
  }

  void _addMessage(AddMessage event, Emitter<ChatState> emit) async {
    emit(state..messages.insert(0, event.message));
  }
}
