class GetData {
  GetData({
    required this.absenceTypes,
    required this.absenceTypesVacation,
    required this.absenceTypesAugust,
    required this.absenceTypesMustRedo,
    required this.cityTypes,
    required this.serviceGuideTypes,
    required this.countryTypes,
    required this.familyStatusTypes,
    required this.documentTypes,
    required this.hmoTypes,
    required this.citizenshipTypes,
    required this.parentMaritalStatusTypes,
    required this.administrationRequestedPeriodTypes,
    required this.serviceHousingTypes,
    required this.languageTypes,
    required this.boolListTypes,
    required this.hebDays,
    required this.hebMonths,
    required this.hebYears,
    required this.banks,
    required this.selectedYearTypes,
    required this.schoolCityTypes,
    required this.apartmentFaultTypes,
    required this.letterTypes,
    required this.result,
    required this.message,
  });
  late final List<AbsenceTypes> absenceTypes;
  late final List<AbsenceTypesVacation> absenceTypesVacation;
  late final List<AbsenceTypesAugust> absenceTypesAugust;
  late final List<AbsenceTypesMustRedo> absenceTypesMustRedo;
  late final List<CityTypes> cityTypes;
  late final List<ServiceGuideTypes> serviceGuideTypes;
  late final List<CountryTypes> countryTypes;
  late final List<FamilyStatusTypes> familyStatusTypes;
  late final List<DocumentTypes> documentTypes;
  late final List<HmoTypes> hmoTypes;
  late final List<CitizenshipTypes> citizenshipTypes;
  late final List<ParentMaritalStatusTypes> parentMaritalStatusTypes;
  late final List<AdministrationRequestedPeriodTypes> administrationRequestedPeriodTypes;
  late final List<ServiceHousingTypes> serviceHousingTypes;
  late final List<LanguageTypes> languageTypes;
  late final List<BoolListTypes> boolListTypes;
  late final List<HebDays> hebDays;
  late final List<HebMonths> hebMonths;
  late final List<HebYears> hebYears;
  late final List<Banks> banks;
  late final List<SelectedYearTypes> selectedYearTypes;
  late final List<SchoolCityTypes> schoolCityTypes;
  late final List<ApartmentFaultTypes> apartmentFaultTypes;
  late final List<LetterTypes> letterTypes;
  late final bool result;
  late final String message;

  GetData.fromJson(Map<String, dynamic> json){
    absenceTypes = List.from(json['absenceTypes']).map((e)=>AbsenceTypes.fromJson(e)).toList();
    absenceTypesVacation = List.from(json['absenceTypesVacation']).map((e)=>AbsenceTypesVacation.fromJson(e)).toList();
    absenceTypesAugust = List.from(json['absenceTypesAugust']).map((e)=>AbsenceTypesAugust.fromJson(e)).toList();
    absenceTypesMustRedo = List.from(json['absenceTypesMustRedo']).map((e)=>AbsenceTypesMustRedo.fromJson(e)).toList();
    cityTypes = List.from(json['cityTypes']).map((e)=>CityTypes.fromJson(e)).toList();
    serviceGuideTypes = List.from(json['serviceGuideTypes']).map((e)=>ServiceGuideTypes.fromJson(e)).toList();
    countryTypes = List.from(json['countryTypes']).map((e)=>CountryTypes.fromJson(e)).toList();
    familyStatusTypes = List.from(json['familyStatusTypes']).map((e)=>FamilyStatusTypes.fromJson(e)).toList();
    documentTypes = List.from(json['documentTypes']).map((e)=>DocumentTypes.fromJson(e)).toList();
    hmoTypes = List.from(json['hmoTypes']).map((e)=>HmoTypes.fromJson(e)).toList();
    citizenshipTypes = List.from(json['citizenshipTypes']).map((e)=>CitizenshipTypes.fromJson(e)).toList();
    parentMaritalStatusTypes = List.from(json['parentMaritalStatusTypes']).map((e)=>ParentMaritalStatusTypes.fromJson(e)).toList();
    administrationRequestedPeriodTypes = List.from(json['administrationRequestedPeriodTypes']).map((e)=>AdministrationRequestedPeriodTypes.fromJson(e)).toList();
    serviceHousingTypes = List.from(json['serviceHousingTypes']).map((e)=>ServiceHousingTypes.fromJson(e)).toList();
    languageTypes = List.from(json['languageTypes']).map((e)=>LanguageTypes.fromJson(e)).toList();
    boolListTypes = List.from(json['boolListTypes']).map((e)=>BoolListTypes.fromJson(e)).toList();
    hebDays = List.from(json['hebDays']).map((e)=>HebDays.fromJson(e)).toList();
    hebMonths = List.from(json['hebMonths']).map((e)=>HebMonths.fromJson(e)).toList();
    hebYears = List.from(json['hebYears']).map((e)=>HebYears.fromJson(e)).toList();
    banks = List.from(json['banks']).map((e)=>Banks.fromJson(e)).toList();
    selectedYearTypes = List.from(json['selectedYearTypes']).map((e)=>SelectedYearTypes.fromJson(e)).toList();
    schoolCityTypes = List.from(json['schoolCityTypes']).map((e)=>SchoolCityTypes.fromJson(e)).toList();
    apartmentFaultTypes = List.from(json['apartmentFaultTypes']).map((e)=>ApartmentFaultTypes.fromJson(e)).toList();
    letterTypes = List.from(json['letterTypes']).map((e)=>LetterTypes.fromJson(e)).toList();
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['absenceTypes'] = absenceTypes.map((e)=>e.toJson()).toList();
    _data['absenceTypesVacation'] = absenceTypesVacation.map((e)=>e.toJson()).toList();
    _data['absenceTypesAugust'] = absenceTypesAugust.map((e)=>e.toJson()).toList();
    _data['absenceTypesMustRedo'] = absenceTypesMustRedo.map((e)=>e.toJson()).toList();
    _data['cityTypes'] = cityTypes.map((e)=>e.toJson()).toList();
    _data['serviceGuideTypes'] = serviceGuideTypes.map((e)=>e.toJson()).toList();
    _data['countryTypes'] = countryTypes.map((e)=>e.toJson()).toList();
    _data['familyStatusTypes'] = familyStatusTypes.map((e)=>e.toJson()).toList();
    _data['documentTypes'] = documentTypes.map((e)=>e.toJson()).toList();
    _data['hmoTypes'] = hmoTypes.map((e)=>e.toJson()).toList();
    _data['citizenshipTypes'] = citizenshipTypes.map((e)=>e.toJson()).toList();
    _data['parentMaritalStatusTypes'] = parentMaritalStatusTypes.map((e)=>e.toJson()).toList();
    _data['administrationRequestedPeriodTypes'] = administrationRequestedPeriodTypes.map((e)=>e.toJson()).toList();
    _data['serviceHousingTypes'] = serviceHousingTypes.map((e)=>e.toJson()).toList();
    _data['languageTypes'] = languageTypes.map((e)=>e.toJson()).toList();
    _data['boolListTypes'] = boolListTypes.map((e)=>e.toJson()).toList();
    _data['hebDays'] = hebDays.map((e)=>e.toJson()).toList();
    _data['hebMonths'] = hebMonths.map((e)=>e.toJson()).toList();
    _data['hebYears'] = hebYears.map((e)=>e.toJson()).toList();
    _data['banks'] = banks.map((e)=>e.toJson()).toList();
    _data['selectedYearTypes'] = selectedYearTypes.map((e)=>e.toJson()).toList();
    _data['schoolCityTypes'] = schoolCityTypes.map((e)=>e.toJson()).toList();
    _data['apartmentFaultTypes'] = apartmentFaultTypes.map((e)=>e.toJson()).toList();
    _data['letterTypes'] = letterTypes.map((e)=>e.toJson()).toList();
    _data['result'] = result;
    _data['message'] = message;
    return _data;
  }
}

class AbsenceTypes {
  AbsenceTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  AbsenceTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class AbsenceTypesVacation {
  AbsenceTypesVacation({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  AbsenceTypesVacation.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class AbsenceTypesAugust {
  AbsenceTypesAugust({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  AbsenceTypesAugust.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class AbsenceTypesMustRedo {
  AbsenceTypesMustRedo({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  AbsenceTypesMustRedo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class CityTypes {
  CityTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  CityTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ServiceGuideTypes {
  ServiceGuideTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  ServiceGuideTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class CountryTypes {
  CountryTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  CountryTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class FamilyStatusTypes {
  FamilyStatusTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  FamilyStatusTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class DocumentTypes {
  DocumentTypes({
    this.id,
    this.name,
  });
  int? id;
  String? name;

  DocumentTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class HmoTypes {
  HmoTypes({
    id,
    name,
  });
  int? id;
  String? name;

  HmoTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class CitizenshipTypes {
  CitizenshipTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  CitizenshipTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ParentMaritalStatusTypes {
  ParentMaritalStatusTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  ParentMaritalStatusTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class AdministrationRequestedPeriodTypes {
  AdministrationRequestedPeriodTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  AdministrationRequestedPeriodTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ServiceHousingTypes {
  ServiceHousingTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  ServiceHousingTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class LanguageTypes {
  LanguageTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  LanguageTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class BoolListTypes {
  BoolListTypes({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  BoolListTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class HebDays {
  HebDays({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  HebDays.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class HebMonths {
  HebMonths({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  HebMonths.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class HebYears {
  HebYears({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  HebYears.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class Banks {
  Banks({
    id,
    name,
  });
  String? id;
  String? name;

  Banks.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class SelectedYearTypes {
  SelectedYearTypes({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  SelectedYearTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class SchoolCityTypes {
  SchoolCityTypes({
    required this.schools,
    required this.id,
    required this.name,
  });
  late final List<Schools> schools;
  late final int id;
  late final String name;

  SchoolCityTypes.fromJson(Map<String, dynamic> json){
    schools = List.from(json['schools']).map((e)=>Schools.fromJson(e)).toList();
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['schools'] = schools.map((e)=>e.toJson()).toList();
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class Schools {
  Schools({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Schools.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ApartmentFaultTypes {
  ApartmentFaultTypes({
    required this.categoryCode,
    required this.isMustLocation,
    required this.id,
    required this.name,
  });
  late final int categoryCode;
  late final bool isMustLocation;
  late final int id;
  late final String name;

  ApartmentFaultTypes.fromJson(Map<String, dynamic> json){
    categoryCode = json['categoryCode'];
    isMustLocation = json['isMustLocation'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categoryCode'] = categoryCode;
    _data['isMustLocation'] = isMustLocation;
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class LetterTypes {
  LetterTypes({
    required this.isCandidate,
    required this.isVolunteer,
    required this.isUnknown,
    required this.id,
    required this.name,
  });
  late final bool isCandidate;
  late final bool isVolunteer;
  late final bool isUnknown;
  late final int id;
  late final String name;

  LetterTypes.fromJson(Map<String, dynamic> json){
    isCandidate = json['isCandidate'];
    isVolunteer = json['isVolunteer'];
    isUnknown = json['isUnknown'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isCandidate'] = isCandidate;
    _data['isVolunteer'] = isVolunteer;
    _data['isUnknown'] = isUnknown;
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}