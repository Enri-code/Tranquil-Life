import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';

class AvatarEditorScreen extends StatelessWidget {
  static const routeName = 'avatar_edit_screen';
  const AvatarEditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Customize your avatar',
        actions: [
          AppBarAction(
            child: const Padding(
              padding: EdgeInsets.all(1),
              child: Icon(Icons.done, color: Colors.white, size: 20),
            ),
            onPressed: () async {
              //TODO
              final navigator = Navigator.of(context);
              context.read<ProfileBloc>().add(UpdateUser(
                    usesBitmoji: true,
                    avatarUrl: await fluttermojiFunctions.encodeMySVGtoString(),
                  ));
              navigator.pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: LayoutBuilder(
                builder: (_, consts) => FluttermojiCircleAvatar(
                  radius: consts.biggest.shortestSide * 0.5,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 7,
              child: FluttermojiCustomizer(
                scaffoldWidth: min(600, width),
                theme: FluttermojiThemeData(
                  boxDecoration: const BoxDecoration(boxShadow: [BoxShadow()]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
