import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';

class ImageFullViewData {
  const ImageFullViewData({this.image, this.heroTag, this.placeHolder});

  final String? heroTag;
  final Widget? placeHolder;
  final ImageProvider<Object>? image;
}

class ImageFullView extends StatefulWidget {
  ///argument is [ImageFullViewData]
  static const routeName = 'image_full_view_screen';
  const ImageFullView({Key? key}) : super(key: key);

  @override
  State<ImageFullView> createState() => _ImageFullViewState();
}

class _ImageFullViewState extends State<ImageFullView> {
  late ImageFullViewData data;
  @override
  void didChangeDependencies() {
    data = ModalRoute.of(context)!.settings.arguments as ImageFullViewData;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              heroAttributes: data.heroTag != null
                  ? PhotoViewHeroAttributes(tag: data.heroTag!)
                  : null,
              imageProvider: data.image,
              loadingBuilder: (_, __) =>
                  data.placeHolder ?? CustomLoader.widget,
            ),
            const Positioned(top: 0, left: 0, right: 0, child: CustomAppBar()),
          ],
        ),
      ),
    );
  }
}
