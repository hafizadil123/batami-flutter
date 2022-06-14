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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['faultCategoryTypeCode'] = this.faultCategoryTypeCode;
    data['faultTypeCode'] = this.faultTypeCode;
    data['isRecurring'] = this.isRecurring;
    data['occurrenceDate'] = this.occurrenceDate;

    if(apartmentName!=null){
      data['apartmentName'] = this.apartmentName;}
    if(statusName!=null) {
      data['statusName'] = this.statusName;
    }

    if(faultDescription!=null) {
      data['faultDescription'] = this.faultDescription;
    }

    if(location!=null) {
      data['location'] = this.location;
    }
    if(handleDescription!=null) {
      data['handleDescription'] = this.handleDescription;
    }
    if(handleDate!=null) {
      data['handleDate'] = this.handleDate;
    }
    if(apartmentFaultTypeName!=null) {
      data['apartmentFaultTypeName'] = this.apartmentFaultTypeName;
    }
    if(creator!=null) {
      data['creator'] = this.creator;
    }
    if(handler!=null) {
      data['handler'] = this.handler;
    }
    if(result!=null) {
      data['result'] = this.result;
    }
    if(message!=null) {
      data['message'] = this.message;
    }
    return data;
  }
}