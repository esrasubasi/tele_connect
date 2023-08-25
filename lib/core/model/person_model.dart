class Person {
  final String personName;
  final String personNumber;
  final String personEmail;
  final bool personSelectTel;
  final bool personSelectMail;

  Person({
    required this.personName,
    required this.personNumber,
    required this.personEmail,
    this.personSelectTel = false,
    this.personSelectMail = false,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'personName': personName,
  //     'personNumber': personNumber,
  //     'personEmail': personEmail,
  //     'personSelect': personSelect,
  //   };
  // }

//   factory Person.fromJson(Map<String, dynamic> json) {
//     return Person(
//       personName: json['personName'],
//       personNumber: json['personNumber'],
//       personEmail: json['personEmail'],
//       personSelect: json['personSelect'] ?? false,
//     );
//   }
}
