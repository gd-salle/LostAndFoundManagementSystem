class Item {
  int? id;
  String? itemName;
  String? date;
  String? itemCondition;
  String? time;
  String? location;
  String? reporterName;
  String? contactNo;
  String? reportType;
  String? status;

  Item({
    this.id,
    this.itemName,
    this.date,
    this.itemCondition,
    this.time,
    this.location,
    this.reporterName,
    this.contactNo,
    this.reportType,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': itemName,
      'date': date,
      'item_condition': itemCondition,
      'time': time,
      'location': location,
      'reporter_name': reporterName,
      'contact_no': contactNo,
      'report_type': reportType,
      'status': status,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      itemName: json['item_name'] ?? '',
      date: json['date'] ?? '',
      itemCondition: json['item_condition'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      reporterName: json['reporter_name'] ?? '',
      contactNo: json['contact_no'] ?? '',
      reportType: json['report_type'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
