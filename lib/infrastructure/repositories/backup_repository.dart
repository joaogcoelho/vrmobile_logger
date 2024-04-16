import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrmobile_logger/domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements IBackupRepository {
  @override
  Future<void> persistData(
    Map<String, dynamic> data, {
    required String fileName,
  }) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String dataInJson = jsonEncode(data);
    List<int> dataEnconded = utf8.encode(dataInJson);
    List<int> dataCompressed = gzip.encode(dataEnconded);

    File file = File('${documentsDirectory.path}/$fileName.txt');
    await file.writeAsBytes(Uint8List.fromList(dataCompressed));

    if (await file.exists()) {
      debugPrint(
        '${DateTime.now()} - Arquivo de backup $fileName foi salvo com sucesso em: ${file.path}',
      );
    } else {
      debugPrint('${DateTime.now()} - Não foi possível salvar arquivo de backup.');
    }
  }

  @override
  Future<Map<String, dynamic>> getData(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    File file = File('${documentsDirectory.path}/$fileName.txt');
    final content = await file.readAsBytes();
    final contentDecoded = gzip.decode(content);

    final dataInString = utf8.decode(contentDecoded);
    return jsonDecode(dataInString);
  }
}
