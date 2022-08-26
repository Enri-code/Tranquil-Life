import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';

class OnboardScreen extends StatefulWidget {
  static const routeName = 'onboard_screen';
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  static const _text = [
    'Let\'s connect and get you to a brighter state. What brings you to Tranquil Life?',
    'We create an all day access to Psychologists, Counsellors and Therapists.'
  ];
  final _pageController = PageController();

  int page = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      var nextPage = _pageController.page!.round();
      if (nextPage != page) setState(() => page = nextPage);
    });
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/onboarding/1.png'), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _goToPage(int page) => _pageController.animateToPage(
        page,
        duration: kTabScrollDuration,
        curve: Curves.easeOutBack,
      );

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Align(
                alignment: const Alignment(0, -0.3),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _goToPage,
                    clipBehavior: Clip.none,
                    children: List.generate(
                      _text.length,
                      (i) => Center(
                        child: Image.asset(
                          'assets/images/onboarding/$i.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      height: 80,
                      child: Text(
                        _text[page],
                        style: const TextStyle(height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _text.length,
                      (i) => AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        width: page == i ? 40 : 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: page == i ? color : color.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        child: page < _text.length - 1
                            ? const Text('Next')
                            : const Text('Continue'),
                        onPressed: () {
                          if (page < _text.length - 1) {
                            _goToPage(page + 1);
                          } else {
                            AppData.isOnboardingCompleted = true;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              SignInScreen.routeName,
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ),
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
