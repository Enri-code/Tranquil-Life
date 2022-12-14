import 'package:tranquil_life/features/store/data/store.dart';
import 'package:tranquil_life/features/store/domain/store.dart';

abstract class _Keys {
  static const isOnboardingCompleted = 'isOnboardingCompleted';
  static const hasShownChatDisableDialog = 'hasShownChatDisableDialog';
  static const hasReadMeetingAbsenceMessage = 'hasReadMeetingAbsenceMessage';
}

abstract class AppData {
  static final IStore _store = HiveStore('app_data');

  static Future init() => _store.init();

  static bool get isOnboardingCompleted {
    return _store.get(_Keys.isOnboardingCompleted) ?? false;
  }

  static set isOnboardingCompleted(bool val) {
    _store.set(_Keys.isOnboardingCompleted, val);
  }

  static bool get hasShownChatDisableDialog {
    return _store.get(_Keys.hasShownChatDisableDialog) ?? false;
  }

  static set hasShownChatDisableDialog(bool val) {
    _store.set(_Keys.hasShownChatDisableDialog, val);
  }

  static bool get hasReadMeetingAbsenceMessage {
    return _store.get(_Keys.hasReadMeetingAbsenceMessage) ?? false;
  }

  static set hasReadMeetingAbsenceMessage(bool val) {
    _store.set(_Keys.hasReadMeetingAbsenceMessage, val);
  }

  static Future clearUserData() =>
      _store.deleteAll(keys: [_Keys.hasReadMeetingAbsenceMessage]);
}
