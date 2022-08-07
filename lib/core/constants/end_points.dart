const baseUrl = 'https://tranquil-api.herokuapp.com/api/client/';

abstract class AuthEndPoints {
  static const login = 'login';
  static const register = 'register';
  static const passwordReset = 'reset-password';
}

abstract class ConsultantEndPoints {
  static const getAll = 'listConsultants';
  static const rate = 'rateConsultant';
}

abstract class JournalEndPoints {
  static const getAll = 'listNotes';
  static const add = 'addNote';
  static const edit = 'editNote';
  static const delete = 'deleteNote';
  static const share = 'shareNote';
}

abstract class QuestionnaireEndPoints {
  static const submit = 'submit';
}
