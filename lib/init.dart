import 'http/config.dart';
import 'http/http.dart';

Future<void> initKit() async {
  await Http.init(root: kBaseUrl);
}
