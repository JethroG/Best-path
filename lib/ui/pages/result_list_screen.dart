import 'package:flutter/material.dart';
import 'package:theshortestway/data/dto/process_filed_data.dart';

class ResultListScreen extends StatefulWidget {
  List<ProcessFiledData>? processDataStatusResponse;

   ResultListScreen({super.key,required this.processDataStatusResponse});

  @override
  State<ResultListScreen> createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Result list screen',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: widget.processDataStatusResponse!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){

              },
              child: Center(
                  child: Column(
                    children: [
                      Text( widget.processDataStatusResponse![index].result!.path.toString(),
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                      SizedBox(height: 4,),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  )
              )
            );
          },
        ),
      ),
    );
  }
}
