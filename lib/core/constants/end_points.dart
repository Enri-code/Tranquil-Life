const baseUrl = 'https://tranquil-api.herokuapp.com/api/client/';

class AuthEndPoints {
  static const login = 'login';
  static const register = 'register';
  static const passwordReset = 'reset-password';
}

class ConsultantEndPoints {
  static const getAll = 'listConsultants';
  static const rate = 'rateConsultant';
}

class JournalEndPoints {
  static const getAll = 'listNotes';
  static const add = 'addNote';
  static const edit = 'editNote';
}
