import 'package:flutter/material.dart';
import 'package:tranquil_life/features/auth/presentation/screens/user_type_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  static const _text = [
    'Let’s connect and get you to a brighter state. What brings you to Tranquil Life?',
    'Resilia creates an all day access to Psychologists, Counsellors and Therapists.'
  ];

  int page = 0;

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/onboarding/1.png'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Center(
              child: Image.asset(
                'assets/images/onboarding/$page.png',
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  _text[page],
                  style: const TextStyle(fontSize: 24, height: 1.6),
                  textAlign: TextAlign.center,
                ),
              ),
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
              SafeArea(
                child: ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {
                    if (page < _text.length - 1) {
                      setState(() => page++);
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        UserTypeSreen.routeName,
                        (route) => false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
