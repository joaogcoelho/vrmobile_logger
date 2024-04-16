abstract class IBackupRepository {
  Future<void> persistData(
    Map<String, dynamic> data, {
    required String fileName,
  });
  Future<Map<String, dynamic>> getData(String fileName);
}
