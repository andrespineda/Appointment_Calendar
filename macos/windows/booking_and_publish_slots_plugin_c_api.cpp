#include "include/booking_and_publish_slots/booking_and_publish_slots_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "booking_and_publish_slots_plugin.h"

void BookingAndPublishSlotsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  booking_and_publish_slots::BookingAndPublishSlotsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
