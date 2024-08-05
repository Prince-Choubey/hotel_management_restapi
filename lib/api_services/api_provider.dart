import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiProvider extends ChangeNotifier {
  final String baseUrl;
  final http.Client httpClient;

  ApiProvider({required this.baseUrl, required this.httpClient});

  Future<http.Response> postResponse(
      String endpoint, {
        Map<String, String>? headers,
        Map<String, dynamic>? body,
        bool includeBearerToken = false,
      }) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print("$baseUrl$endpoint");

    final String jsonBody = body != null ? json.encode(body) : '';

    final response =
    await httpClient.post(uri, headers: headers, body: jsonBody);
    print("Prince");

    return response;
  }


  Future<http.Response> getResponse(
      String endpoint, {
        Map<String, String>? headers,
        bool includeBearerToken = false,
      }) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print("$baseUrl$endpoint");

    final response =
    await httpClient.get(uri, headers: headers);
    print("Prince");

    return response;
  }

  Future<http.Response> deleteResponse(
      String endpoint, {
        Map<String, String>? headers,
        bool includeBearerToken = false,
      }) async {
    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print("$baseUrl$endpoint");

    final response =
    await httpClient.delete(uri, headers: headers);
    print("Prince");

    return response;
  }

}
