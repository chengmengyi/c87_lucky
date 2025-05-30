import 'package:lucky_base/lucky_utils/lucky_export.dart';


class StorageName{
  static const p1UserCoins="p1UserCoins";
  static const p1UserPlayNum="p1UserPlayNum";
}


StorageData<int> p1UserCoins=StorageData<int>(key: StorageName.p1UserCoins, defaultValue: 0);
StorageData<int> p1UserPlayNum=StorageData<int>(key: StorageName.p1UserPlayNum, defaultValue: 0);
