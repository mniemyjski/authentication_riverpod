import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerDarkMode = StateNotifierProvider<DarkMode, bool>((ref) => DarkMode());

class DarkMode extends StateNotifier<bool> {
  DarkMode() : super(false);

  void change(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('DarkMode', state);
    this.state = state;
  }
}
