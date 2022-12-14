import 'package:st/app/modules/jobs/underway_job/model/records.dart';

class CompletedJobModel {
  CompletedJobModel({
    this.records,
    this.total,
    this.size,
    this.current,
    this.orders,
    this.optimizeCountSql,
    this.searchCount,
    this.countId,
    this.maxLimit,
    // this.jobTotal = 0,
    this.pages,
  });

  CompletedJobModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = [];

      (json['records'] as List).forEach((v) {
        records?.add(Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    if (json['orders'] != null) {
      orders = [];
    }
    optimizeCountSql = json['optimizeCountSql'];
    searchCount = json['searchCount'];
    countId = json['countId'];
    maxLimit = json['maxLimit'];
    // jobTotal = json['jobTotal'];
    pages = json['pages'];
  }
  List<Records>? records;
  int? total = 0;
  int? size;
  int? current;
  List? orders;
  bool? optimizeCountSql;
  bool? searchCount;
  dynamic countId;
  dynamic maxLimit;
  // int jobTotal = 0;
  int? pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (records != null) {
      map['records'] = records?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['size'] = size;
    map['current'] = current;
    if (orders != null) {
      // map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    map['optimizeCountSql'] = optimizeCountSql;
    map['searchCount'] = searchCount;
    map['countId'] = countId;
    map['maxLimit'] = maxLimit;
    // map['jobTotal'] = jobTotal;
    map['pages'] = pages;
    return map;
  }
}
