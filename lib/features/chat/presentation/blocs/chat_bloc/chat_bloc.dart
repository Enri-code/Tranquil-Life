import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tranquil_life/core/utils/services/media_service.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(const ChatState(
          consultant: Consultant(id: 0, displayName: 'Dr Charles Rique'),
        )) {
    on<ScrollToChatEvent>(_scrollTo);
    on<UploadChatMediaEvent>(_uploadFile);
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

  void _uploadFile(UploadChatMediaEvent event, Emitter<ChatState> emit) async {
    final Future<File?> fileFuture;
    switch (event.type) {
      case MediaType.audio:
        fileFuture = MediaService.selectAudio();
        break;
      case MediaType.camera:
        fileFuture = MediaService.selectImage(ImageSource.camera);
        break;
      case MediaType.gallery:
        fileFuture = MediaService.selectImage();
        break;
      default:
        fileFuture = MediaService.selectDocument();
        break;
    }

    final file = await fileFuture;
  }
}
