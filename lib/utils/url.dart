import 'package:url_launcher/url_launcher_string.dart';

Future<bool> launchExternal(String url) async {
  if (await canLaunchUrlString(url)) {
    return launchUrlString(url, mode: LaunchMode.externalApplication);
  }
  return false;
}
