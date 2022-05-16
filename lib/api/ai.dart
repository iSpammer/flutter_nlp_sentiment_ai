import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:math';

Future<String> get_predictions(String input) async {
  var dio = Dio();
  var params =  {
    "arr": "input",
  };
  print("meaw");
  Response response = await dio.post("http://3.69.21.224:5000/predict",
  options: Options(headers: {
  }),
  data: jsonEncode(params),
  );
  List<String> model_columns = ["neutral", "Magnifying/minimizing", "Personalization", "overgeneralization", "should statements"];
  String tmp = response.data['prediction'];
  print(tmp);
  tmp = tmp.replaceAll("[", "");
  tmp = tmp.replaceAll("]", "");
  tmp = tmp.replaceAll(",", "");
  List<String> tmp2 = tmp.split(" ");
  List<double> vals = [];
  for(int i = 0; i < tmp2.length; i ++){
    try {
      vals.add(double.parse(tmp2[i]));
    } catch(e) {
      continue;
    }

  }
  print("val"+vals.toString());
  double max = (vals.reduce((curr, next) => curr > next? curr: next));
  int maxi = vals.indexOf(max);
  return (model_columns[maxi]);
}