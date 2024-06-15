#ifndef FLUTTER_PLUGIN_BOOKING_AND_PUBLISH_SLOTS_PLUGIN_H_
#define FLUTTER_PLUGIN_BOOKING_AND_PUBLISH_SLOTS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace booking_and_publish_slots {

class BookingAndPublishSlotsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BookingAndPublishSlotsPlugin();

  virtual ~BookingAndPublishSlotsPlugin();

  // Disallow copy and assign.
  BookingAndPublishSlotsPlugin(const BookingAndPublishSlotsPlugin&) = delete;
  BookingAndPublishSlotsPlugin& operator=(const BookingAndPublishSlotsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace booking_and_publish_slots

#endif  // FLUTTER_PLUGIN_BOOKING_AND_PUBLISH_SLOTS_PLUGIN_H_
