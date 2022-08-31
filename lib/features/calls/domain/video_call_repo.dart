abstract class CallController {
  Future init();
  Future join(String callRoomId, {bool startWithVideo = false});
  Future leave();
  Future switchCamera();
  Future switchVideo(bool enable);
  Future switchMic(bool enable);
  void dispose();
}
