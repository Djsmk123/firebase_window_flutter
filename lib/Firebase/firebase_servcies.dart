import 'dart:convert';

import 'package:firebase_windows/Firebase/firebase_config.dart';

import 'package:http/http.dart' as http;

import 'firebase_current_user.dart';

class FirebaseService {
  final firebaseInstance = FirebaseConfig();
  CurrentUser? user;
  String url = "";

  logOut() {
    user = null;
  }

  var headers = {'Content-Type': 'application/json'};

  signUp({required String eml, required String ps}) async {
    url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${firebaseInstance.apiKey}";
    final res = await http.post(
      Uri.parse(url),
      headers: headers,
      body: const Utf8Encoder().convert(
          ('{"email":"$eml","password":"$ps","returnSecureToken":true}')),
    );
    Map<dynamic, dynamic> decode = jsonDecode(res.body.toString());
    if (!decode.containsKey("error")) {
      await getCurrentUser(tokenId: decode['idToken']).then((currentUser) {
        user = null;
        user = currentUser;
      });
    } else {
      throw Exception(decode['error']['message']);
    }
    return user;
  }

  Future<dynamic> logIn({required String eml, required String ps}) async {
    url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${firebaseInstance.apiKey}";
    final res = await http.post(
      Uri.parse(url),
      headers: headers,
      body: const Utf8Encoder().convert(
          ('{"email":"$eml","password":"$ps","returnSecureToken":true}')),
    );
    Map<dynamic, dynamic> decode = jsonDecode(res.body.toString());
    if (!decode.containsKey("error")) {
      await getCurrentUser(tokenId: decode['idToken']).then((currentUser) {
        user = null;
        user = currentUser;
      });
    } else {
      throw Exception(decode['error']['message']);
    }
    return user;
  }

  Future<CurrentUser> getCurrentUser({tokenId}) async {
    url =
        "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=${firebaseInstance.apiKey}";
    final res = await http.post(
      Uri.parse(url),
      headers: headers,
      body: const Utf8Encoder().convert(('{"idToken":"$tokenId"}')),
    );
    Map<dynamic, dynamic> decode = jsonDecode(res.body.toString());
    return CurrentUser(
        uid: decode['users'][0]['localId'],
        email: decode['users'][0]['email'],
        tokenId: tokenId,
        emailVerified: decode['users'][0]['emailVerified'],
        displayName: decode.containsKey('displayName')
            ? decode['users'][0]['displayName']
            : '',
        providerUserInfo: decode.containsKey('providerUserInfo')
            ? decode['users'][0]['providerUserInfo']
            : dynamic,
        photoUrl: decode.containsKey('photoUrl')
            ? decode['users'][0]['photoUrl']
            : '',
        passwordHash: decode.containsKey('passwordHash')
            ? decode['users'][0]['passwordHash']
            : '',
        passwordUpdatedAt: decode.containsKey('passwordUpdatedAt')
            ? decode['users'][0]['passwordUpdatedAt']
            : 0,
        validSince: decode.containsKey('validSince')
            ? decode['users'][0]['validSince']
            : '',
        disabled: decode.containsKey('disabled')
            ? decode['users'][0]['disabled']
            : true,
        lastLoginAt: decode.containsKey('lastLoginAt')
            ? decode['users'][0]['lastLoginAt']
            : '',
        createdAt: decode.containsKey('createdAt')
            ? decode['users'][0]['createdAt']
            : '',
        customAuth: decode.containsKey('customAuth')
            ? decode['users'][0]['customAuth']
            : false);
  }
}
