class Account {
  int id;
  String login;
  String? password;
  String title;
  String? shopAddress;
  String? workingHours;
  String? specialWorkingHours;
  String? personName;
  String? personSurname;
  String? personPersonalCode;
  String? personPhoneNumber;
  String? personEmail;
  String? personWorkingAt;
  int? personMonthlyHours;
  double? personHourlyWage;
  String? department;

  Account({
    required this.id,
    required this.login,
    this.password,
    required this.title,
    this.shopAddress,
    this.workingHours,
    this.specialWorkingHours,
    this.personName,
    this.personSurname,
    this.personPersonalCode,
    this.personPhoneNumber,
    this.personEmail,
    this.personWorkingAt,
    this.personMonthlyHours,
    this.personHourlyWage,
    this.department,
  });
}
