import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

const agoraId = 'a2782460e26a405cb9ffda0ae62e8038';

const cardAspectRatio = 1.586;

late final double chatBoxMaxWidth;
const uidGenerator = Uuid();

final deviceInfoPlugin = DeviceInfoPlugin();
num? androidVersion;
