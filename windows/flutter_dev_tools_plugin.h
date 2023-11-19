#ifndef FLUTTER_PLUGIN_FLUTTER_DEV_TOOLS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_DEV_TOOLS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_dev_tools {

class FlutterDevToolsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterDevToolsPlugin();

  virtual ~FlutterDevToolsPlugin();

  // Disallow copy and assign.
  FlutterDevToolsPlugin(const FlutterDevToolsPlugin&) = delete;
  FlutterDevToolsPlugin& operator=(const FlutterDevToolsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_dev_tools

#endif  // FLUTTER_PLUGIN_FLUTTER_DEV_TOOLS_PLUGIN_H_
