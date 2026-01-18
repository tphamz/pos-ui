import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing edit mode state
class EditModeNotifier extends StateNotifier<bool> {
  static const String _editModeKey = 'edit_mode';

  EditModeNotifier() : super(false) {
    _loadEditMode();
  }

  Future<void> _loadEditMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final editMode = prefs.getBool(_editModeKey) ?? false;
      state = editMode;
    } catch (e) {
      // If loading fails, default to false
      state = false;
    }
  }

  Future<void> setEditMode(bool enabled) async {
    state = enabled;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_editModeKey, enabled);
    } catch (e) {
      // If saving fails, continue with the new state
    }
  }

  Future<void> toggleEditMode() async {
    await setEditMode(!state);
  }
}

final editModeProvider = StateNotifierProvider<EditModeNotifier, bool>((ref) {
  return EditModeNotifier();
});
