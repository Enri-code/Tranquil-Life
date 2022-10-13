import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/chat/domain/repos/video_call_repo.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';

class AgoraController extends CallController {
  AgoraController() {
    _initFuture = _init();
  }

  Future? _initFuture;
  RtcEngine? _engine;

  @override
  String callRoomId = '';

  Future<String> get _token async {
    final result = await ApiClient.get('');
    return result.data;
  }

  Future _init() async {
    if (_engine != null) return;
    _engine = createAgoraRtcEngine();
    _engine!.registerEventHandler(RtcEngineEventHandler(
      onError: (error, _) {
        print(error);
      },
      onJoinChannelSuccess: (channel, uid) {},
      onUserJoined: (connection, uid, elapsed) {
        remoteIds.add(uid);
      },
      onUserOffline: (connection, uid, reason) {
        remoteIds.remove(uid);
      },
    ));
    await Future.wait([
      _engine!
          .setChannelProfile(ChannelProfileType.channelProfileCommunication),
      _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster),
      _engine!.setVideoEncoderConfiguration(const VideoEncoderConfiguration(
        dimensions: VideoDimensions(height: 1920, width: 1080),
      )),
    ]);
  }

  @override
  Future join(String consultantId, {bool startWithVideo = false}) async {
    final userId = getIt<ProfileBloc>().state.user!.id;
    callRoomId = '$consultantId-$userId';

    if (Platform.isIOS || Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _initFuture;
    if (startWithVideo) await switchVideo(true);
    await _engine?.joinChannel(
      token: await _token,
      channelId: callRoomId,
      uid: userId,
      options: ChannelMediaOptions(),
    );
  }

  @override
  Future switchCamera() {
    return _engine!.switchCamera();
  }

  @override
  Future switchMic(bool enable) {
    return _engine!.enableLocalAudio(enable);
  }

  @override
  Future switchVideo(bool enable) async {
    if (enable) {
      await _engine!.enableVideo();
      await _engine!.startPreview();
    } else {
      await _engine!.disableVideo();
      await _engine!.stopPreview();
    }
  }

  @override
  Future leave() async {
    await _engine!.leaveChannel();
    await switchVideo(false);
  }

  @override
  void clear() {
    remoteIds.clear();
  }
}
