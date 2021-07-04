import 'package:ids/models/people_model.dart';

class PeopleViewModel {
  PeopleModel? _peopleModel;

  PeopleViewModel({PeopleModel? peopleModel}) : _peopleModel = peopleModel;

  String? get name {
    return this._peopleModel?.name;
  }

  int? get age {
    return calculateAge(this._peopleModel?.birthDate);
  }

  String? get gender {
    return _peopleModel?.gender;
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

  // void set name() {
  //   return _peopleModel?.gender;
  // }
}
