

class Client {
  String _name;
  String _phone;
  String _email;
  String _notes;

  Client({
    String name = '',
    String phone = '',
    String email = '',
    String notes = '',
  }) : _name = name,
       _phone = phone,
       _email = email,
       _notes = notes;

  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get notes => _notes;

  set name(String name) {
    _name = name;
  }

  set phone(String phone) {
    _phone = phone;
  }

  set email(String email) {
    _email = email;
  }

  set notes(String notes) {
    _notes = notes;
  }
}