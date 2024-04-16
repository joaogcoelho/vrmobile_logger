library vrmobile_logger;

import 'package:vrmobile_logger/application/usecases/get_backup_data_usecase.dart';
import 'package:vrmobile_logger/application/usecases/save_backup_data_usecase.dart';
import 'package:vrmobile_logger/domain/repositories/backup_repository.dart';
import 'package:vrmobile_logger/infrastructure/repositories/backup_repository.dart';

IBackupRepository repository = BackupRepositoryImpl();
GetBackupDataUsecase getBackupDataUsecase = GetBackupDataUsecase(repository);
SaveBackupDataUsecase saveBackupDataUsecase = SaveBackupDataUsecase(repository);

Future<void> saveBackupData(
  Map<String, dynamic> data, {
  required String fileName,
}) {
  return saveBackupDataUsecase.call(data, fileName: fileName);
}

Future<Map<String, dynamic>> getBackupData(String fileName) {
  return getBackupDataUsecase.call(fileName);
}
