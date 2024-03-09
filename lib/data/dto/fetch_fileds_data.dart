class FetchFieldsData {
  final bool error;
  final String message;
  final List<Path> data;

  FetchFieldsData(
      {required this.error, required this.message, required this.data});

  factory FetchFieldsData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Path> dataList = list.map((i) => Path.fromJson(i)).toList();
    return FetchFieldsData(
      error: json['error'],
      message: json['message'],
      data: dataList,
    );
  }

  @override
  String toString() {
    return 'FetchFieldsData{error: $error, message: $message, data: $data}';
  }
}

class Path {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  Path(
      {required this.id,
      required this.field,
      required this.start,
      required this.end});

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Point.fromJson(json['start']),
      end: Point.fromJson(json['end']),
    );
  }

  @override
  String toString() {
    return 'Path{id: $id, field: $field, start: $start, end: $end}';
  }
}

class Point {
  final int x;
  final int y;

  Point({required this.x, required this.y});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      x: json['x'],
      y: json['y'],
    );
  }

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}
