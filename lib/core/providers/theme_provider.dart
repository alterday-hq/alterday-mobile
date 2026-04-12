import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeKey = 'theme_mode';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadSaved();
    return ThemeMode.dark;
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeKey);
    if (saved == 'light') {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  Future<void> toggle() async {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeKey, state == ThemeMode.dark ? 'dark' : 'light');
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);
