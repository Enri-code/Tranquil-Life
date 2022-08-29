import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required this.scrollController}) : super(const ChatState()) {
    on<ScrollToChatEvent>(_scrollTo);
  }

  final ItemScrollController scrollController;

  String therapistName = 'Dr Charles Rique';

  void _scrollTo(ScrollToChatEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(chatIndex: -1));
    scrollController.scrollTo(
      alignment: 0.5,
      index: event.index,
      curve: Curves.easeOut,
      duration: kTabScrollDuration,
    );
    emit(state.copyWith(chatIndex: event.index));
  }
}
