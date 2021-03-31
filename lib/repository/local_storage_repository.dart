  import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageRepository {

// Create storage
  final storage = new FlutterSecureStorage();    //스토리지에 저장된값은 스트링값으로 저장된다.

  //get함수
  Future<String> getStoredValue(String key) async {
    try{
      return await storage.read(key: key);
    }catch(error){
      return null;
    }
  }

  Future<void> sotreValue(String key,String vlaue) async {
    try{
      return await storage.write(key: key, value: vlaue.toString());
    }catch(error){
      return null;
    }
  }



}