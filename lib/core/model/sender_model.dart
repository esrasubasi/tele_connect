// ignore_for_file: non_constant_identifier_names

class Senders {
  final String SenderName;
  final String SenderNumber;
  final bool SenderSelect;
  final String SenderCountryCode;

  Senders({
    required this.SenderName,
    required this.SenderNumber,
    this.SenderSelect = false,
    required this.SenderCountryCode,
  });
}
