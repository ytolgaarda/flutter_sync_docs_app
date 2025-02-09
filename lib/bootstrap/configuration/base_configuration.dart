import 'package:flutter/material.dart';

@immutable
abstract class BaseConfiguration {
  String get apiKey;
  String get baseURL;
}
