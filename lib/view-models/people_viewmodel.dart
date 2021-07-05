import 'package:ids/models/people_model.dart';
import 'package:intl/intl.dart';

class PeopleViewModel {
  PeopleModel? _peopleModel;

  PeopleViewModel({PeopleModel? peopleModel}) : _peopleModel = peopleModel;

  int? get id {
    return this._peopleModel?.id;
  }

  String? get name {
    return this._peopleModel?.name;
  }

  int? get age {
    return calculateAge(this._peopleModel?.birthDate);
  }

  DateTime? get birthDate {
    return this._peopleModel?.birthDate;
  }

  String? get gender {
    return _peopleModel?.gender;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['NAME'] = this.name;
    data['BIRTH_DATE'] = DateFormat('dd/MM/yyyy').format(this.birthDate!);
    data['GENDER'] = this.gender;
    return data;
  }

  int calculateAge(DateTime? birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate!.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
