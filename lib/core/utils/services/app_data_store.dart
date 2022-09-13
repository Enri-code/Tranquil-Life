import 'package:tranquil_life/core/utils/helpers/store.dart';

abstract class _Keys {
  static const isOnboardingCompleted = 'isOnboardingCompleted';
  static const hasReadMeetingAbsenceMessage = 'hasReadMeetingAbsenceMessage';
  static const hasAnsweredQuestions = 'hasAnsweredQuestions';
}

abstract class AppData {
  static final _store = HiveStore('app_data');

  static Future init() => _store.init();

  static bool get isOnboardingCompleted {
    return _store.get(_Keys.isOnboardingCompleted) ?? false;
  }

  static set isOnboardingCompleted(bool val) {
    _store.set(_Keys.isOnboardingCompleted, val);
  }

  static bool get hasAnsweredQuestions {
    return _store.get(_Keys.hasAnsweredQuestions) ?? false;
  }

  static set hasAnsweredQuestions(bool val) {
    _store.set(_Keys.hasAnsweredQuestions, val);
  }

  static bool get hasReadMeetingAbsenceMessage {
    return _store.get(_Keys.hasReadMeetingAbsenceMessage) ?? false;
  }

  static set hasReadMeetingAbsenceMessage(bool val) {
    _store.set(_Keys.hasReadMeetingAbsenceMessage, val);
  }
}
