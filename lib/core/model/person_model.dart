class Person {
  final String personName;
  final String personNumber;
  final String personEmail;
  final bool personSelect;

  Person({
    required this.personName,
    required this.personNumber,
    required this.personEmail,
    this.personSelect = false,
  });
}