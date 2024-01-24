import 'package:bizzytasks_app/helpers/networking.dart';

class ListApp {
  Future getList({context}) async {
    NetworHelper networHelper = NetworHelper(url: '/lists', context: context);

    var decodeData = await networHelper.getData();

    return decodeData;
  }
}
