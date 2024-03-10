import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:theshortestway/data/dto/fetch_fileds_data.dart';
import 'package:theshortestway/network/api_client.dart';
import 'package:theshortestway/tools/url_validation.dart';
import 'package:theshortestway/ui/base/base_app_button.dart';
import 'package:theshortestway/ui/base/base_app_textfield.dart';
import 'package:theshortestway/ui/base/base_loading_dialog.dart';
import 'package:theshortestway/ui/pages/progress_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool validApiUrl = false;
  TextEditingController _urlController = TextEditingController();
  ApiClient apiClient=ApiClient();
  FetchFieldsData? fetchFieldsData;

  @override
  Widget build(BuildContext context) {
    _urlController.text='https://flutter.webspark.dev/flutter/api';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      bottomNavigationBar: BaseAppButton(
        text: 'Start counting process',
        onPressed: () async{
          if (UrlValidationHelper().validateUrl(_urlController)) {
            setState(() {
              validApiUrl = true;
            });
          } else {
            showLoaderDialog(context);
            fetchDataFromApi();
          }
        },
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: validApiUrl,
              child: const Text(
                'Set valid API base URL in order to continue',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.compare_arrows, color: Colors.black,),
                const SizedBox(width: 8,),
                Expanded(child:
                BaseTextEditor(
                  controller: _urlController,
                  hintText: 'Enter url here',
                ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void fetchDataFromApi() async {
    try {
      fetchFieldsData  = await apiClient.fetchFieldsData('${_urlController.text.trim()}');

      Navigator.pop(context);
      if(!fetchFieldsData!.error){

       Navigator.push(context, MaterialPageRoute(
           builder: (context) => ProcessScreen(fetchFieldsData:fetchFieldsData!,)));
     }

    } catch (e) {
      Navigator.pop(context);

      print(e.toString());
    }
  }
}
