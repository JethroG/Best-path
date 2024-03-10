

import 'dart:developer';

import 'package:theshortestway/data/dto/fetch_fileds_data.dart';

Future <List<Coordinates>> bestPathHelper(Path fieldsData) async {


  log('start of code ${fieldsData.toString()}');

  var start = Coordinates(x: fieldsData.start.x, y: fieldsData.start.y);
  final end = Coordinates(x: fieldsData.end.x, y: fieldsData.end.y);
  final field = formField(fieldsData);

  List<Coordinates> bestPathCoordinated=[start];

  while (!isCoordsEquals(start, end)) {
    start = getNextStepFromCurrent(field: field, current: start, end: end);
    bestPathCoordinated.add(start);

  }

  log('finish of code ${bestPathCoordinated.toString()}');

  return bestPathCoordinated;
}

bool isCoordsEquals(Coordinates first, Coordinates second) =>
    (first.x == second.x) && (first.y == second.y);

Coordinates getNextStepFromCurrent({
  required Field field,
  required Coordinates current,
  required Coordinates end,
}) {
  var availableSteps = field.getAllAvailableItems().toList();

  availableSteps.removeWhere((item) =>
      (item.coordinates.x - current.x).abs() > 1 ||
      (item.coordinates.y - current.y).abs() > 1);

  var theBestStep = getTheBestNextStep(end,availableSteps.map((item) => item.coordinates).toList());

  return theBestStep;
}

// Coordinates getTheBestNextStep({
//   required Coordinates end,
//   required List<Coordinates> possibleSteps,
// }) {
//   var stepsValues = possibleSteps
//       .map((it) => (formDoubleFromMatrixCoordinates(it) -
//               formDoubleFromMatrixCoordinates(end))
//           .abs())
//       .toList();
//
//   var minStepValue =
//       stepsValues.reduce((value, element) => value < element ? value : element);
//   var minStepValueIndex = stepsValues.indexOf(minStepValue);
//
//   return possibleSteps[minStepValueIndex];
// }

Coordinates getTheBestNextStep(Coordinates end, List<Coordinates> possibleSteps) {
  var stepsWithDistance = possibleSteps.map((step) {
    return MapEntry(step, (step.x - end.x).abs() + (step.y - end.y).abs());
  }).toList();

  var theBestStep = stepsWithDistance.reduce((curr, next) => curr.value < next.value ? curr : next).key;

  return theBestStep ?? end;
}


double formDoubleFromMatrixCoordinates(Coordinates coordinates) {
  return double.parse("${coordinates.x}.${coordinates.y}");
}

Field formField(Path fieldsData ) {
  var fieldItems = <FieldItem>[];

  fieldsData.field.asMap().forEach((i, item) {
    item.split('').asMap().forEach((j, char) {
      fieldItems.add(FieldItem(
        coordinates: Coordinates(x: i, y: j),
        isAvailable: isItemAvailable(char),
      ));
    });
  });

  return Field(items: fieldItems);
}

bool isItemAvailable(String item) => item == fieldConstants.availableItem;

class Field {
  final List<FieldItem> items;

  Field({required this.items});

  List<FieldItem> getAllAvailableItems() =>
      items.where((item) => item.isAvailable).toList();
}

class FieldItem {
  final Coordinates coordinates;
  final bool isAvailable;

  FieldItem({required this.coordinates, required this.isAvailable});
}

class Coordinates {
  final int x;
  final int y;

  Coordinates({required this.x, required this.y});

  @override
  String toString() => '($x, $y)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Coordinates &&
              runtimeType == other.runtimeType &&
              x == other.x &&
              y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}


class fieldConstants {
  static const availableItem = '.';
  static const unavailableItem = 'X';
}

List<Coordinates> formFieldCoordinates(Path fieldsData ) {
  var fieldItems = <Coordinates>[];

  fieldsData.field.asMap().forEach((i, item) {
    item.split('').asMap().forEach((j, char) {
      fieldItems.add(Coordinates(x: i, y: j));
    });
  });
  return fieldItems;
}
