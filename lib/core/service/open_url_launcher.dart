import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../../widgets/toast_and_snackbar.dart';

class OpenUrlLauncher {
  static Future _launchUrl(String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } on Exception catch (ex) {
      ToastAndSnackBar.toastError(message: ex.toString());
    }
  }

  static Future launchLink({required String url}) async {
    try {
      await _launchUrl(url);
    } catch (error) {
      print(error);
      ToastAndSnackBar.toastError(message: error.toString());
    }
  }

  static Future openEmail({
    required String toEmail,
  }) async {
    try {
      await launchUrl(Uri.parse("mailto:$toEmail"));
    } catch (error) {
      ToastAndSnackBar.toastError(message: error.toString());
    }
  }

  static Future launchPhoneCall({
    required String phoneNumber,
  }) async {
    try {
      await launchUrl(Uri.parse("tel:$phoneNumber"));
    } catch (error) {
      ToastAndSnackBar.toastError(message: error.toString());
    }
  }

  static Future launchSMS({required String phoneNumber}) async {
    final url = 'sms:$phoneNumber';
    await _launchUrl(url);
  }

  static void launchWhatsApp({
    required String phone,
    String? message,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=${Uri.parse(message ?? '-')}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message ?? '-')}"; // new line
      }
    }

    if (await canLaunchUrl(Uri.parse(url()))) {
      await launchUrl(Uri.parse(url()));
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  String url(String phone, String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }
}
