import 'best_path_helper.dart';

String returnBestPath(List<Coordinates> coodinates) {
  return coodinates.map((e) => "(${e.x},${e.y})").join("->");
}