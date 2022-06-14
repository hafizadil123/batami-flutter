class ApartmentFaultDetails {
  int? id;
  String? apartmentName;
  int? faultCategoryTypeCode;
  int? faultTypeCode;
  bool? isRecurring;
  String? occurrenceDate;
  String? statusName;
  String? faultDescription;
  String? location;
  String? handleDescription;
  String? handleDate;
  String? apartmentFaultTypeName;
  String? creator;
  String? handler;
  bool? result;
  String? message;

  ApartmentFaultDetails(
      {this.id,
        this.apartmentName,
        this.faultCategoryTypeCode,
        this.faultTypeCode,
        this.isRecurring,
        this.occurrenceDate,
        this.statusName,
        this.faultDescription,
        this.location,
        this.handleDescription,
        this.handleDate,
        this.apartmentFaultTypeName,
        this.creator,
        this.handler,
        this.result,
        this.message});

  ApartmentFaultDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apartmentName = json['apartmentName'];
    faultCategoryTypeCode = json['faultCategoryTypeCode'];
    faultTypeCode = json['faultTypeCode'];
    isRecurring = json['isRecurring'];
    occurrenceDate = json['occurrenceDate'];
    statusName = json['statusName'];
    faultDescription = json['faultDescription'];
    location = json['location'];
    handleDescription = json['handleDescription'];
    handleDate = json['handleDate'];
    apartmentFaultTypeName = json['apartmentFaultTypeName'];
    creator = json['creator'];
    handler = json['handler'];
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['apartmentName'] = this.apartmentName;
    data['faultCategoryTypeCode'] = this.faultCategoryTypeCode;
    data['faultTypeCode'] = this.faultTypeCode;
    data['isRecurring'] = this.isRecurring;
    data['occurrenceDate'] = this.occurrenceDate;
    data['statusName'] = this.statusName;
    data['faultDescription'] = this.faultDescription;
    data['location'] = this.location;
    data['handleDescription'] = this.handleDescription;
    data['handleDate'] = this.handleDate;
    data['apartmentFaultTypeName'] = this.apartmentFaultTypeName;
    data['creator'] = this.creator;
    data['handler'] = this.handler;
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}