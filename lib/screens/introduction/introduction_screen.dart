import 'package:authentication_riverpod/screens/screens.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static const String routeName = '/intro';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => IntroScreen(),
    );
  }

  List<PageViewModel> pages() {
    return [
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Constants.work_in_progress()),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Constants.work_in_progress()),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Constants.work_in_progress()),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Constants.work_in_progress()),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Constants.work_in_progress()),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages(),
      showSkipButton: true,
      skip: Text(Languages.skip(), style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text(Languages.next(), style: TextStyle(fontWeight: FontWeight.w600)),
      done: Text(Languages.done(), style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        Navigator.pushNamedAndRemoveUntil(context, SplashScreen.routeName, (_) => false);
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      },
    );
  }
}
