import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/widgets/meeting_date_sheet.dart';

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
    setStatusBarBrightness(false);
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
    return Scaffold(
      body: Hero(
        tag: doneAnimating ? '' : '${consultant.id}-img',
        createRectTween: (r1, r2) => RectTween(
          begin: Rect.fromLTRB(r2!.left, r1!.top, r2.right * 0.5, r1.bottom),
          end: r2,
        ),
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
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 432,
            child: Image.network(
              consultant.avatarUrl,
              fit: BoxFit.cover,
              frameBuilder: (_, img, val, ___) => CustomLoader.widget(),
              errorBuilder: (_, __, ___) => Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(TranquilIcons.profile, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
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
          Positioned(
            top: 8,
            left: 8,
            child: SafeArea(
              child: AppBarButton(
                onPressed: Navigator.of(context).pop,
                icon: const Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(blurRadius: 16, color: Colors.black26)],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultant.displayName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      consultant.description,
                      style: const TextStyle(fontSize: 15.5, height: 1.3),
                    ),
                    const SizedBox(height: 16),
                    MyDefaultTextStyle(
                      style: TextStyle(
                        color: ColorPalette.green[800]!,
                        fontSize: 16,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
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
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (_) => MeetingDateSheet(consultant),
                          ).whenComplete(() => setStatusBarBrightness(false));
                          /*   Navigator.of(context)
                              .pushNamed(
                                ScheduleMeetingScreen.routeName,
                                arguments: consultant,
                              )
                              .whenComplete(
                                  () => setStatusBarBrightness(false)); */
                        },
                        child: const Text(
                          'Schedule a meeting',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
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
    return Neumorphic(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      style: NeumorphicStyle(
        depth: -2,
        intensity: 0.8,
        color: Colors.white,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.green[800]!,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: ColorPalette.green[800],
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: ColorPalette.green[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
