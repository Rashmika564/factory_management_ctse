import 'package:http/http.dart' as http;

class Api {
  static const baseurl = "";
  //https://randomuser.me/api/?results=2
  static addproduct(Map pdata) async {
    var res = await http.post(Uri.parse("uri"), body: pdata);

    try {
      if (res.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }
}
