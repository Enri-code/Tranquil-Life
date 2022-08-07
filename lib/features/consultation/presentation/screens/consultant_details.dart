import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';

///argument is [Consultant]
class ConsultantDetailScreen extends StatefulWidget {
  static const routeName = 'cnsultant_detail';
  const ConsultantDetailScreen({Key? key}) : super(key: key);

  @override
  State<ConsultantDetailScreen> createState() => _ConsultantDetailScreenState();
}

class _ConsultantDetailScreenState extends State<ConsultantDetailScreen> {
  late Consultant consultant;
  bool doneAnimating = false;

  @override
  void didChangeDependencies() {
    consultant = ModalRoute.of(context)!.settings.arguments as Consultant;
    super.didChangeDependencies();
  }

  Widget _imageToPageBuilder(_, Animation<double> anim, direction, __, ___) {
    anim.addListener(() {
      if (anim.isCompleted) setState(() => doneAnimating = true);
    });
    return _PageBody(consultant: consultant);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(false);
    return Scaffold(
      body: Hero(
        tag: doneAnimating ? '' : '${consultant.id}-img',
        createRectTween: (r1, r2) {
          return RectTween(
            begin: Rect.fromLTRB(r2!.left, r1!.top, r2.right * 0.5, r1.bottom),
            end: r2,
          );
        },
        flightShuttleBuilder: _imageToPageBuilder,
        child: _PageBody(consultant: consultant),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody({Key? key, required this.consultant}) : super(key: key);

  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Image.network(
            consultant.avatarUrl,
            fit: BoxFit.cover,
            height: height * 0.45,
            width: double.infinity,
          ),
          Container(
            height: MediaQuery.of(context).viewPadding.top + 24,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black38, Colors.transparent],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: AppBarButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.55 + 23,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(blurRadius: 16, color: Colors.black26),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consultant.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    consultant.description,
                    style: const TextStyle(fontSize: 15.5, height: 1.3),
                  ),
                  const SizedBox(height: 20),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: ColorPalette.primary[800]!,
                      fontSize: 16,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _InfoCard(
                            icon: Icons.timer,
                            title: '1 hour session',
                            subTitle: '\$10,000',
                          ),
                          _InfoCard(
                            icon: TranquilIcons.translate,
                            title: 'Fluent in',
                            subTitle: 'English, French, Igbo, Yoruba',
                          ),
                          _InfoCard(
                            icon: Icons.location_on_rounded,
                            title: 'Location',
                            subTitle: 'United Kingdom',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 72),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(TranquilIcons.calendar_tick, color: Colors.white),
                      SizedBox(width: 18),
                      Text(
                        'Schedule a meeting',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final IconData icon;
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorPalette.primary[800]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.primary[800]!,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 6),
              Text(subTitle),
            ],
          ),
        ],
      ),
    );
  }
}