import 'dart:math';

import 'package:flutter/material.dart';
import 'package:theshortestway/data/dto/filed_preview_data.dart';
import 'package:theshortestway/data/dto/return_grid_string_item.dart';
import 'package:theshortestway/tools/filed_item_color_helper.dart';
import 'package:theshortestway/tools/returnBestPathString.dart';

class PreviewScreen extends StatefulWidget {

  FieldPreviewData fieldPreviewData;

   PreviewScreen({super.key,required this.fieldPreviewData});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {

  int fieldSize=0;

  @override
  void initState() {
    super.initState();
    setState(() {
      fieldSize=widget.fieldPreviewData.field.length;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Preview screen',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.center ,
        children: [
          Expanded(child:
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: sqrt(fieldSize).toInt(), // Number of columns
            // Space between rows
            ),
            itemCount: widget.fieldPreviewData.field.length,
            itemBuilder: (context, index) {
              return GridTile(
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    color: fieldItemColorHelper( widget.fieldPreviewData.field[index], widget.fieldPreviewData.bestPath),
                  ),
                  child: Center(
                    child: Text(formatsCoordinatesToString(widget.fieldPreviewData.field[index]), style: TextStyle(color: Colors.black)),
                  ),
                ),
              );
            },
          ) ,),

          Text(returnBestPath(widget.fieldPreviewData.bestPath,),
            style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),)
        ],
      )

    );
  }

}
