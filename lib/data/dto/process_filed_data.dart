class ProcessFiledData {
  String? id;
  Result? result;

  ProcessFiledData({this.id, this.result});

  ProcessFiledData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{id: $id, result: $result}';
  }
}

class Result {
  List<Steps>? steps;
  String? path;

  Result({this.steps, this.path});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    return data;
  }

  @override
  String toString() {
    return '{steps: $steps, path: $path}';
  }
}

class Steps {
  int? x;
  int? y;

  Steps({this.x, this.y});

  Steps.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }

  @override
  String toString() {
    return '{x: $x, y: $y}';
  }
}
