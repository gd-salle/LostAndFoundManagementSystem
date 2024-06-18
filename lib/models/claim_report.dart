class ClaimReport {
  int? id;
  String? recipientName;
  String? date;
  String? contactNo;
  String? yearLevel;
  String? department;
  String? address;
  int? itemReportId;

  ClaimReport({
    this.id,
    this.recipientName,
    this.date,
    this.contactNo,
    this.yearLevel,
    this.department,
    this.address,
    this.itemReportId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient_name': recipientName,
      'date': date,
      'contact_no': contactNo,
      'year_level': yearLevel,
      'department': department,
      'address': address,
      'item_report_id': itemReportId,
    };
  }

  factory ClaimReport.fromJson(Map<String, dynamic> json) {
    return ClaimReport(
      id: json['id'],
      recipientName: json['recipient_name'] ?? '',
      date: json['date'] ?? '',
      contactNo: json['contact_no'] ?? '',
      yearLevel: json['year_level'] ?? '',
      department: json['department'] ?? '',
      address: json['address'] ?? '',
      itemReportId: json['item_report_id'],
    );
  }
}
