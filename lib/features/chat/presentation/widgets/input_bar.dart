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

  Future _handleRecordingUpload(File? file, bool upload) async {
    if (file == null || !upload) return;
    context.read<ChatBloc>().add(AddMessage(
          Message(isSent: false, type: MessageType.audio, data: file.path),
        ));
  }

  Future _handleTextUplod(bool upload) async {
    final text = textController.text.trim();
    if (text.isEmpty || !upload) return;
    textController.clear();
    context.read<ChatBloc>().add(
          AddMessage(Message(isSent: false, data: text)),
        );
  }

  _handleUpload() async {
    if (showMic) return;
    File? file;
    bool result = true;
    if (isRecording) file = await recorder.stop();
    if (!AppData.hasShownChatDisableDialog) {
      result = await showDialog(
            context: context,
            builder: (_) => const DisableAccountDialog(),
          ) ??
          false;
    }
    if (isRecording) {
      _handleRecordingUpload(file, result);
    } else {
      _handleTextUplod(result);
    }
  }

  @override
  void initState() {
    recorder.init();
    textController.addListener(() {
      setState(() => micMode = textController.text.trim().isEmpty);
    });
    _isRecordingStreamSub = recorder.omRecordingState.listen((event) {
      setState(() => isRecording = event);
    });
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
                    builder: (_) => const AttachmentSheet(),
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
                      builder: (context, snapshot) => Text(
                        snapshot.data!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
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
                  onTap: _handleUpload,
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
