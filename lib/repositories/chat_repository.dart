import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social/helpers/helpers.dart';
import 'package:social/models/response_list_chat.dart';
import 'package:social/models/response_list_messages.dart';
import 'package:social/services/url_api.dart';

class ChatRepositories {
  Future<List<ListChat>> getListChatByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${UA.urlApi}/chat/get-list-chat-by-user'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseListChat.fromJson(jsonDecode(resp.body)).listChat;
  }

  Future<List<ListMessage>> listMessagesByUser(String uid) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${UA.urlApi}/chat/get-all-message-by-user/' + uid),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseListMessages.fromJson(jsonDecode(resp.body)).listMessage;
  }
}

final chatRepositories = ChatRepositories();
