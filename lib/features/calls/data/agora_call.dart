import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/calls/domain/video_call_repo.dart';

class AgoraController extends CallController {
  AgoraController() {
    initFuture = init();
  }

  bool isAudioOn = true, isFrontCamera = true;
  Set<int> remoteIds = {};

  Future? initFuture;
  RtcEngine? _engine;

  Future<String?> get _token async {
    return '';
  }

  @override
  Future init() async {
    // _engine = await RtcEngine.create(agoraId);
    _engine = await RtcEngine.createWithContext(RtcEngineContext(agoraId));
    print('created');
    _engine!.setEventHandler(RtcEngineEventHandler(
      error: (errorCode) {
        print(errorCode);
      },
      warning: (warningCode) {
        print(warningCode);
      },
      joinChannelSuccess: (channel, uid, elapsed) {},
      userJoined: (uid, elapsed) {
        remoteIds.add(uid);
      },
      userOffline: (uid, reason) {
        remoteIds.remove(uid);
      },
    ));
    await Future.wait([
      _engine!.setChannelProfile(ChannelProfile.Communication),
      _engine!.setClientRole(ClientRole.Broadcaster),
    ]);
  }

  @override
  Future join(String callRoomId, {bool startWithVideo = false}) async {
    if (Platform.isIOS || Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    await initFuture;
    await switchVideo(startWithVideo);
    await _engine?.joinChannel(
      await _token,
      callRoomId,
      null,
      GetIt.instance.get<ClientAuthBloc>().state.user!.id,
    );
  }

  @override
  Future leave() => _engine!.leaveChannel();

  @override
  Future switchCamera() {
    isFrontCamera = !isFrontCamera;
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
  void dispose() {
    _engine?.destroy();
  }
}
