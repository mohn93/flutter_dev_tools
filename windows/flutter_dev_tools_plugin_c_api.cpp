#include "include/flutter_dev_tools/flutter_dev_tools_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_dev_tools_plugin.h"

void FlutterDevToolsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_dev_tools::FlutterDevToolsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
