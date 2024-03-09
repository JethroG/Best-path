import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:theshortestway/data/dto/fetch_fileds_data.dart';
import 'package:theshortestway/data/dto/process_data_status_response.dart';
import 'package:theshortestway/data/dto/process_filed_data.dart';
import 'package:theshortestway/network/api_client.dart';
import 'package:theshortestway/tools/best_path_helper.dart';
import 'package:theshortestway/ui/base/base_app_button.dart';
import 'package:theshortestway/ui/base/base_loading_dialog.dart';
import 'package:theshortestway/ui/pages/result_list_screen.dart';

class ProcessScreen extends StatefulWidget {
  FetchFieldsData fetchFieldsData;

  ProcessScreen({super.key, required this.fetchFieldsData});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  List<ProcessFiledData> processFiledData = [];

  bool isSetupInProgress = true;

  ApiClient apiClient = ApiClient();

  ProcessDataStatusResponse? processDataStatusResponse;

  void getBestPath() async {
    for (var element in widget.fetchFieldsData.data) {
      var pathHelper = await bestPathHelper(element);
      processFiledData.add(
        ProcessFiledData(
          id: element.id,
          result: Result(
            steps: pathHelper.map((e) => Steps(x: e.x, y: e.y)).toList(),
            path: returnBestPath(pathHelper),
          ),
        ),
      );
    }
    setState(() {
      isSetupInProgress = false;
    });

    log('ProcessFiledData ${processFiledData.toString()}');
  }

  @override
  void initState() {
    super.initState();
    log(widget.fetchFieldsData.toString());
    getBestPath();
  }

  String returnBestPath(List<Coordinates> coodinates) {
    return coodinates.map((e) => "(${e.x},${e.y})").join("->");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Process screen',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: BaseAppButton(
        color:
            !isSetupInProgress ?Theme.of(context).primaryColor: Colors.grey ,
        text: 'Send results to server',
        onPressed: !isSetupInProgress ? () {
          showLoaderDialog(context);
          fetchDataFromApi();
        }: () {},
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !isSetupInProgress,
              child: const Column(
                children: [
                  Text(
                    'All calculations has finished, you can send your results to server',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '100%',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Visibility(
              visible: isSetupInProgress,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  void fetchDataFromApi() async {

    try {

      processDataStatusResponse = await apiClient.sendsFieldsData(
          'https://flutter.webspark.dev/flutter/api', processFiledData);
      Navigator.pop(context);
      log(processDataStatusResponse!.error.toString());
      if(!processDataStatusResponse!.error!){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ResultListScreen(processDataStatusResponse: processFiledData,)));
      }
    } catch (e) {
      Navigator.pop(context);
      print(e.toString());
    }
  }
}
