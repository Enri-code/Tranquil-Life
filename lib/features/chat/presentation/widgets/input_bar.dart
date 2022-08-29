part of '../screens/chat_screen.dart';

class _InputBar extends StatefulWidget {
  const _InputBar({Key? key}) : super(key: key);

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  static final sessionConfig = AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.record,
    avAudioSessionCategoryOptions:
        AVAudioSessionCategoryOptions.allowBluetooth |
            AVAudioSessionCategoryOptions.defaultToSpeaker,
    avAudioSessionMode: AVAudioSessionMode.spokenAudio,
    avAudioSessionRouteSharingPolicy:
        AVAudioSessionRouteSharingPolicy.defaultPolicy,
    avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    androidAudioAttributes: const AndroidAudioAttributes(
      contentType: AndroidAudioContentType.speech,
      flags: AndroidAudioFlags.none,
      usage: AndroidAudioUsage.voiceCommunication,
    ),
    androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    androidWillPauseWhenDucked: true,
  );

  final textController = TextEditingController();
  final recordingController = FlutterSoundRecorder();

  bool micMode = true, recording = false;

  String filePath = '${uidGenerator.v4()}.aac', durationText = '00:00';

  StreamSubscription? durationStreamSub;

  Future _initRecorder() async {
    if (!kIsWeb) await Permission.microphone.request();
    recordingController.openRecorder().then((value) {
      return recordingController
          .setSubscriptionDuration(const Duration(milliseconds: 500));
    });
    AudioSession.instance.then((value) => value.configure(sessionConfig));
  }

  Future _startRecording() async {
    setState(() => recording = true);
    await recordingController.startRecorder(
      codec: Codec.aacMP4,
      toFile: filePath,
    );
    durationText = '00:00';
    durationStreamSub = recordingController.onProgress?.listen((event) {
      setState(() => durationText = formatDurationToTimerString(
            event.duration.inMilliseconds,
          ));
    });
  }

  Future<File?> _stopRecording() async {
    final path = await recordingController.stopRecorder();
    textController.clear();
    durationStreamSub?.cancel();
    setState(() => recording = false);
    if (path == null) return null;
    return File(path);
  }

  Future _sendRecording() async {
    filePath = '${uidGenerator.v4()}.aac';
    final file = await _stopRecording();
  }

  @override
  void initState() {
    _initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    durationStreamSub?.cancel();
    recordingController.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Container(
        padding: const EdgeInsets.only(bottom: 1),
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const _AttachmentSheet(),
                ),
                icon: Icon(
                  Icons.attach_file,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (recording) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 13),
                    child: Text(
                      durationText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: textController,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: 'Type something...',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintStyle: TextStyle(fontWeight: FontWeight.w600),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 4,
                    ),
                  ),
                  onChanged: (val) => setState(() => micMode = val.isEmpty),
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8, bottom: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
                border: recording
                    ? Border.all(color: ColorPalette.primary[800]!, width: 3)
                    : null,
              ),
              child: GestureDetector(
                onTap: () {
                  if (micMode) return;
                },
                onLongPress: micMode ? _startRecording : null,
                onLongPressUp: micMode ? _sendRecording : null,
                onLongPressCancel: micMode ? _stopRecording : null,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: AnimatedCrossFade(
                    duration: kThemeChangeDuration,
                    crossFadeState: micMode
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const Padding(
                      padding: EdgeInsets.fromLTRB(4, 3, 2, 3),
                      child: Icon(Icons.send, color: Colors.white, size: 22),
                    ),
                    secondChild: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: recording ? 22 : 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentSheet extends StatelessWidget {
  const _AttachmentSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AttachmentButton(
                  label: 'Camera',
                  icon: Icons.camera_alt,
                  color: const Color(0xff0680BB),
                  onPressed: () {},
                ),
                _AttachmentButton(
                  label: 'Gallery',
                  icon: Icons.image,
                  color: const Color(0xff2D713E),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AttachmentButton(
                  label: 'Document',
                  icon: Icons.file_open,
                  color: const Color(0xffFFC600),
                  onPressed: () {},
                ),
                _AttachmentButton(
                  label: 'Audio',
                  icon: Icons.headphones,
                  color: const Color(0xff43A95D),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentButton extends StatelessWidget {
  const _AttachmentButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final String label;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onPressed();
          Navigator.of(context).pop();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
