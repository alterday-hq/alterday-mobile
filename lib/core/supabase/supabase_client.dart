import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initSupabase() async {
  final url = dotenv.env['SUPABASE_URL'] ?? '';
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  if (url.isEmpty || anonKey.isEmpty) return; // skip if keys not configured
  await Supabase.initialize(url: url, anonKey: anonKey);
}

bool get isSupabaseReady {
  try {
    Supabase.instance.client;
    return true;
  } catch (_) {
    return false;
  }
}

SupabaseClient get supabase => Supabase.instance.client;
