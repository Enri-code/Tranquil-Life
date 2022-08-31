part of '../screens/chat_screen.dart';

class _InputBar extends StatefulWidget {
  const _InputBar({Key? key}) : super(key: key);

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final textController = TextEditingController();
  final recorder = AudioRecorder();

  bool micMode = true, isRecording = false;
  bool get showMic => micMode && !isRecording;

  StreamSubscription? _isRecordingStreamSub;

  Future _sendRecording() async {
    final file = await recorder.stop();
  }

  @override
  void initState() {
    recorder.init();
    _isRecordingStreamSub = recorder.omRecordingState
        .listen((event) => setState(() => isRecording = event));
    super.initState();
  }

  @override
  void dispose() {
    _isRecordingStreamSub?.cancel();
    textController.dispose();
    recorder.dispose();
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
              child: AnimatedCrossFade(
                duration: kTabScrollDuration,
                crossFadeState: isRecording
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: IconButton(
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
                secondChild: IconButton(
                  onPressed: recorder.stop,
                  icon: Icon(
                    TranquilIcons.trash,
                    color: Theme.of(context).primaryColor,
                    size: 27,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (isRecording) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 13),
                    child: StreamBuilder<String>(
                        initialData: '00:00',
                        stream: recorder.onDurationText,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
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
            SwipeableWidget(
              maxOffset: 32,
              enabled: showMic,
              resetOnRelease: true,
              swipedWidget: const Icon(Icons.mic, color: ColorPalette.red),
              onStateChanged: (isActive) {
                if (showMic && isActive) recorder.start();
              },
              child: AnimatedContainer(
                duration: kThemeChangeDuration,
                padding: const EdgeInsets.all(6),
                margin: EdgeInsets.only(right: isRecording ? 6 : 8, bottom: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: isRecording
                      ? Border.all(color: ColorPalette.blue, width: 2)
                      : null,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (isRecording) _sendRecording();
                  },
                  child: AnimatedCrossFade(
                    duration: kThemeChangeDuration,
                    crossFadeState: showMic
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Padding(
                      padding: isRecording
                          ? const EdgeInsets.fromLTRB(3, 1, 2, 1)
                          : const EdgeInsets.fromLTRB(4, 3, 2, 3),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    secondChild: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 28,
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
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: FractionallySizedBox(
          widthFactor: 0.75,
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
                    onPressed: () => context
                        .read<ChatBloc>()
                        .add(const UploadChatMediaEvent(MediaType.camera)),
                  ),
                  _AttachmentButton(
                    label: 'Gallery',
                    icon: Icons.image,
                    color: const Color(0xff2D713E),
                    onPressed: () => context
                        .read<ChatBloc>()
                        .add(const UploadChatMediaEvent(MediaType.gallery)),
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
                    onPressed: () => context
                        .read<ChatBloc>()
                        .add(const UploadChatMediaEvent(MediaType.document)),
                  ),
                  _AttachmentButton(
                    label: 'Audio',
                    icon: Icons.headphones,
                    color: const Color(0xff43A95D),
                    onPressed: () => context
                        .read<ChatBloc>()
                        .add(const UploadChatMediaEvent(MediaType.audio)),
                  ),
                ],
              ),
            ],
          ),
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
