import 'package:permission_handler/permission_handler.dart';
import 'package:vrmobile_logger/domain/repositories/backup_repository.dart';

class GetBackupDataUsecase {
  final IBackupRepository _backupRepository;
  GetBackupDataUsecase(this._backupRepository);

  Future<Map<String, dynamic>> call(String fileName) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    return _backupRepository.getData(fileName);
  }
}
