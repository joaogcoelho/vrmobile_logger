import 'package:permission_handler/permission_handler.dart';
import 'package:vrmobile_logger/domain/repositories/backup_repository.dart';

class SaveBackupDataUsecase {
  final IBackupRepository _backupRepository;
  SaveBackupDataUsecase(this._backupRepository);

  Future<void> call(
    Map<String, dynamic> data, {
    required String path,
  }) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    return _backupRepository.persistData(data, fileName: path);
  }
}
