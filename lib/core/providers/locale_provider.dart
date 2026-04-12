import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleKey = 'locale';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    _loadSaved();
    return const Locale('pl');
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kLocaleKey);
    if (saved == 'en') {
      state = const Locale('en');
    } else {
      state = const Locale('pl');
    }
  }

  Future<void> toggle() async {
    state = state.languageCode == 'pl' ? const Locale('en') : const Locale('pl');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, state.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
