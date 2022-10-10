import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranquil_life/app/presentation/theme/properties.dart';
import 'package:tranquil_life/core/utils/services/media_service.dart';

class AttachmentSheet extends StatelessWidget {
  const AttachmentSheet({Key? key}) : super(key: key);

  void _handleUpload(File? file) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: bottomSheetDecoration,
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
                    onPressed: () async => _handleUpload(
                      await MediaService.selectImage(ImageSource.camera),
                    ),
                  ),
                  _AttachmentButton(
                    label: 'Gallery',
                    icon: Icons.image,
                    color: const Color(0xff2D713E),
                    onPressed: () async =>
                        _handleUpload(await MediaService.selectImage()),
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
                    onPressed: () async =>
                        _handleUpload(await MediaService.selectDocument()),
                  ),
                  _AttachmentButton(
                    label: 'Audio',
                    icon: Icons.headphones,
                    color: const Color(0xff43A95D),
                    onPressed: () async =>
                        _handleUpload(await MediaService.selectAudio()),
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
