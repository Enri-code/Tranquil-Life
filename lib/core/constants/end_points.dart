const baseUrl = 'https://tranquil-api.herokuapp.com/api/';

abstract class AuthEndPoints {
  static const login = 'client/login';
  static const register = 'client/register';
  // static const isAuthenticated = 'client/isAuthenticated';
  static const listPartners = 'admin/listPartners';
  // static const passwordReset = 'client/reset-password';
}

abstract class ProfileEndPoints {
  static const get = 'client/getProfile';
  static const edit = 'client/edit';
}

/* abstract class ConsultantEndPoints {
  static const getAll = 'client/listConsultants';
  static const rate = 'client/rateConsultant';
} */

abstract class JournalEndPoints {
  static const getAll = 'client/listNotes';
  static const add = 'client/addNote';
  // static const update = 'client/editNote';
  // static const delete = 'client/deleteNote';
  static const share = 'client/shareNote';
}

abstract class QuestionnaireEndPoints {
  static const submit = 'client/submit';
}
