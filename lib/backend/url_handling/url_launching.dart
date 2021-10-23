import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as url_l;

class UrlLaunching {
  Future<void> setPublicInfoCache() async {}

  Future<void> launchEmail() async {
    final email = (await FirebaseFirestore.instance
            .collection('control-info')
            .doc('public-info')
            .get())
        .data()!['email'];
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    await launchInBrowser(emailLaunchUri.toString());
  }

  Future<void> launchInBrowser(String url) async {
    if (await url_l.canLaunch(url)) {
      await url_l.launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> makePhoneCall(String url) async {
    if (await url_l.canLaunch(url)) {
      await url_l.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
