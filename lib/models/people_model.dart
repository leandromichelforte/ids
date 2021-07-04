import 'package:intl/intl.dart';

DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

class PeopleModel {
  int? id;
  String? name;
  DateTime? birthDate;
  String? gender;

  PeopleModel({
    this.id,
    this.name,
    this.birthDate,
    this.gender,
  });

  PeopleModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['NAME'];
    birthDate = dateFormatter.parse(json['BIRTH_DATE'].replaceAll("/", "-"));
    gender = json['GENDER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birth_Date'] = DateFormat('dd/MM/yyyy').format(this.birthDate!);
    data['gender'] = this.gender;
    return data;
  }

  void printy() {
    print(
        "id: ${this.id} - nome: ${this.name} - data_nascimento: ${this.birthDate} - gênero: ${this.gender}");
  }
}
