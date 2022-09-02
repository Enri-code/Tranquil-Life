import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as local;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as remote;
import 'package:get_it/get_it.dart';
import 'package:tranquil_life/app/presentation/widgets/back_button_white.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';

import 'package:tranquil_life/features/calls/data/agora_call.dart';
import 'package:tranquil_life/features/calls/presentation/widgets/buttons.dart';
import 'package:tranquil_life/features/calls/presentation/widgets/small_view.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';

class CallPageData {
  final String callRoomId;
  final bool isVideoEnabled;

  const CallPageData(this.callRoomId, [this.isVideoEnabled = true]);
}

class CallScreen extends StatefulWidget {
  ///argument is [CallPageData]
  static const routeName = 'call_screen';
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final controller = GetIt.instance.get<AgoraController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setStatusBarBrightness(false);
    final data = ModalRoute.of(context)!.settings.arguments as CallPageData;
    controller.join(data.callRoomId, startWithVideo: data.isVideoEnabled);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
            /*  Column(
              children: controller.remoteIds
                  .map((e) => Expanded(
                        child: remote.SurfaceView(
                          uid: e,
                          channelId: controller.callRoomId,
                        ),
                      ))
                  .toList(),
            ), */
            Column(
              children: [
                Expanded(
                  child: SmallView(
                    channelId: '',
                    onPlatformViewCreated: (val) {
                      print(val);
                    },
                  ),
                ),
                SafeArea(top: false, child: BottomBar()),
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
