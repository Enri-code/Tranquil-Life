import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/core/utils/functions.dart';

class ConsultantDetailScreen extends StatefulWidget {
  static const routeName = 'cnsultant_detail';
  const ConsultantDetailScreen({Key? key}) : super(key: key);

  @override
  State<ConsultantDetailScreen> createState() => _ConsultantDetailScreenState();
}

class _ConsultantDetailScreenState extends State<ConsultantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(false);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.network(
            'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
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
          if (Navigator.canPop(context))
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
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Dr. Charles Richard',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Specialist in matters relating to anxiety, self-esteem, and depression.',
                    style: TextStyle(fontSize: 15.5, height: 1.3),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
