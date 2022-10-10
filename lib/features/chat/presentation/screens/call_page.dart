import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/chat/domain/repos/video_call_repo.dart';

import 'package:tranquil_life/features/chat/presentation/widgets/call/call_buttons.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/call/call_small_view.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';

class CallPageData {
  final String consultantId;
  final bool isVideoEnabled;

  const CallPageData(this.consultantId, [this.isVideoEnabled = true]);
}

class CallScreen extends StatefulWidget {
  ///argument is [CallPageData]
  static const routeName = 'call_screen';
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final controller = getIt<CallController>();
  bool joinCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setStatusBarBrightness(false);
    if (joinCalled) return;
    joinCalled = true;
    final data = ModalRoute.of(context)!.settings.arguments as CallPageData;
    controller.join(data.consultantId, startWithVideo: data.isVideoEnabled);
  }

  @override
  void dispose() {
    super.dispose();
    controller.leave();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MyDefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: controller.remoteIds
                  .map((e) => Expanded(
                        child: SurfaceView(
                          uid: e,
                          channelId: controller.callRoomId,
                        ),
                      ))
                  .toList(),
            ),
            Column(
              children: [
                Expanded(
                  child: SmallView(
                    channelId: controller.callRoomId,
                    onPlatformViewCreated: (val) {
                      print(val);
                    },
                  ),
                ),
                const SafeArea(top: false, child: BottomBar()),
              ],
            ),
            SafeArea(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, top: 8),
                      child: BackButtonWhite(),
                    ),
                  ),
                  Text(
                    context.read<ChatBloc>().state.consultant!.displayName,
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
