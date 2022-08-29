import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class MediaService {
  static final _filePicker = FilePicker.platform;
  static final _imagePicker = ImagePicker();
  static final _imageCropper = ImageCropper();

  static Future<File?> selectImage([
    ImageSource source = ImageSource.gallery,
  ]) async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: source,
      imageQuality: 75,
      maxHeight: 720,
      maxWidth: 720,
    );
    if (pickedFile == null) return null;
    return _cropImage(File(pickedFile.path));
  }

  static Future<File?> selectAudio() {
    return _selectFile(type: FileType.audio);
  }

  static Future<File?> selectDocument() {
    return _selectFile(type: FileType.any);
  }

  static Future<File?> _selectFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await _filePicker.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) return null;
    return File(result.files.first.path!);
  }

  static Future<File?> _cropImage(File file) async {
    var croppedFile = await _imageCropper.cropImage(
        sourcePath: file.path, compressQuality: 75);
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
