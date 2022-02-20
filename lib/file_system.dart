import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileSystem {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
