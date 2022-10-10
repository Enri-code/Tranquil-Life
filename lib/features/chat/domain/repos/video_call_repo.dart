abstract class CallController {
  String get callRoomId;

  final Set<int> remoteIds = {};

  Future join(String consultantId, {bool startWithVideo = false});
  Future switchCamera();
  Future switchVideo(bool enable);
  Future switchMic(bool enable);
  Future leave();
  void clear();
}
