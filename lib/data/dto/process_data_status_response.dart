class ProcessDataStatusResponse {
  bool? error;
  String? message;
  List<Data>? data;

  ProcessDataStatusResponse({this.error, this.message, this.data});

  ProcessDataStatusResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  bool? correct;

  Data({this.id, this.correct});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['correct'] = this.correct;
    return data;
  }
}
