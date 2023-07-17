import 'hive/hive_util.dart';
import 'http/config.dart';
import 'http/http.dart';

Future<void> initKit() async {
  await HiveUtil.init();
  await Http.init(root: kBaseUrl);
  // await NotifierUtil.init();
}
