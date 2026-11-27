import 'package:fpdart/fpdart.dart';

Option<Uri> mealDbToPhoto(String thumb) =>
    Option<Uri>.fromNullable(Uri.tryParse(thumb)).filter((Uri uri) => uri.isScheme('https'));
