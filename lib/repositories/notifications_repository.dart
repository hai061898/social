import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social/helpers/helpers.dart';
import 'package:social/models/response_notifications.dart';
import 'package:social/services/url_api.dart';

class NotificationsRepoitories {
  Future<List<Notificationsdb>> getNotificationsByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${UA.urlApi}/notification/get-notification-by-user'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseNotifications.fromJson(jsonDecode(resp.body))
        .notificationsdb;
  }
}

final notificationRepositories = NotificationsRepoitories();
