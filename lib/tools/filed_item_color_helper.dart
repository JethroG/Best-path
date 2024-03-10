import 'package:flutter/material.dart';
import 'package:theshortestway/constants/color_const.dart';
import 'package:theshortestway/tools/best_path_helper.dart';

Color fieldItemColorHelper(Coordinates currentItem, List<Coordinates> allItems) {

  if (allItems.contains(currentItem)) {
    if (currentItem == allItems.first) {
      return startPathItem;
    } else if (currentItem == allItems.last) {
      return endPathItem;
    } else {
      return bestPathItem;
    }
  } else {
    return baseItem;
  }
}