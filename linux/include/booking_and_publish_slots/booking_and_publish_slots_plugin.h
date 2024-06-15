#ifndef FLUTTER_PLUGIN_BOOKING_AND_PUBLISH_SLOTS_PLUGIN_H_
#define FLUTTER_PLUGIN_BOOKING_AND_PUBLISH_SLOTS_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _BookingAndPublishSlotsPlugin BookingAndPublishSlotsPlugin;
typedef struct {
  GObjectClass parent_class;
} BookingAndPublishSlotsPluginClass;

FLUTTER_PLUGIN_EXPORT GType booking_and_publish_slots_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void booking_and_publish_slots_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_BOOKING_AND_PUBLISH_SLOTS_PLUGIN_H_
