import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

import '../helper/extensions/string_extension.dart';

/// A collection of statuses that a show can have.
@JsonEnum()
enum ShowStatus {
  FREE,
  ALMOST_FULL,
  FULL,
}

/// A utility with extensions for enum name and serialized value.
extension ExtShowStatus on ShowStatus{
  String get toJson => name.toLowerCase();
  String get inString => name.removeUnderScore.toUpperCase();
}


