import 'package:flutter/material.dart';
class CurrentUser{
  String uid;
  String email;
  String tokenId;
  bool emailVerified;
  String displayName;
  dynamic providerUserInfo;
  String photoUrl;
  String passwordHash;
  double passwordUpdatedAt;
  String validSince;
  bool disabled;
  String lastLoginAt;
  String createdAt;
  bool? customAuth;
  CurrentUser({required this.uid,required this.email,required this.tokenId,required this.emailVerified,required this.displayName,this.providerUserInfo,required this.photoUrl,required this.passwordHash,required this.passwordUpdatedAt,required this.validSince,required this.disabled,required this.lastLoginAt,required this.createdAt,this.customAuth});

}