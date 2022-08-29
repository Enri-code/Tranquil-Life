import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

const uidGenerator = Uuid();
late final double chatBoxMaxWidth;

final deviceInfoPlugin = DeviceInfoPlugin();
num? androidVersion;
