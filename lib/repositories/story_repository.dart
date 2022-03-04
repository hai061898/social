import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social/helpers/helpers.dart';
import 'package:social/models/default_response.dart';
import 'package:social/models/response_list_stories.dart';
import 'package:social/models/response_stories.dart';
import 'package:social/services/url_api.dart';

class StoryRepositories {
  Future<DefaultResponse> addNewStory(String image) async {
    final token = await secureStorage.readToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${UA.urlApi}/story/create-new-story'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!;
    request.files.add(await http.MultipartFile.fromPath('imageStory', image));

    final response = await request.send();
    var data = await http.Response.fromStream(response);

    return DefaultResponse.fromJson(jsonDecode(data.body));
  }

  Future<List<StoryHome>> getAllStoriesHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${UA.urlApi}/story/get-all-stories-home'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseStoriesHome.fromJson(jsonDecode(resp.body)).stories;
  }

  Future<List<ListStory>> getStoryByUSer(String uidStory) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${UA.urlApi}/story/get-story-by-user/' + uidStory),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseListStories.fromJson(jsonDecode(resp.body)).listStories;
  }
}

final storyRepositories = StoryRepositories();
