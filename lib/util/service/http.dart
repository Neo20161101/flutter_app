import 'service.dart';
final service = new Service();

class Http {
  getTest (context,body) async{
    header['isEncoded'] = '1000';
    return await service.fetch(context,'https://api.spacexdata.com/v3/capsules',body,'post');
  }
}