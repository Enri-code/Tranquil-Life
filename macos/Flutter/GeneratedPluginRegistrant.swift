//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import agora_rtc_engine
import audio_session
import device_info_plus_macos
import flutter_secure_storage_macos
import geolocator_apple
import iris_event
import path_provider_macos
import shared_preferences_macos
import sqflite
import wakelock_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AgoraRtcNgPlugin.register(with: registry.registrar(forPlugin: "AgoraRtcNgPlugin"))
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  FlutterSecureStorageMacosPlugin.register(with: registry.registrar(forPlugin: "FlutterSecureStorageMacosPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  IrisEventPlugin.register(with: registry.registrar(forPlugin: "IrisEventPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  WakelockMacosPlugin.register(with: registry.registrar(forPlugin: "WakelockMacosPlugin"))
}
