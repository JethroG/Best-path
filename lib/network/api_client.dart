import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as https;
import 'package:theshortestway/data/dto/fetch_fileds_data.dart';
import 'package:theshortestway/data/dto/process_data_status_response.dart';
import 'package:theshortestway/data/dto/process_filed_data.dart';

class ApiClient {


  Future<FetchFieldsData> fetchFieldsData(String url) async {
    final response = await https.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return FetchFieldsData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProcessDataStatusResponse> sendsFieldsData(String url,List<ProcessFiledData> processFiledData ) async {
    final jsonString = jsonEncode(processFiledData.map((e) => e.toJson()).toList());

    log('finish object $jsonString');
    final response = await https.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonString);

    log(response.body);
    if (response.statusCode == 200) {
     return ProcessDataStatusResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}