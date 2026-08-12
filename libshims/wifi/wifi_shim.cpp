#include <string>
#include <utils/StrongPointer.h>

namespace android {
namespace hardware {
namespace wifi {
namespace V1_0 {

// Forward declaration only — we never need the real class definition,
// just its identity for the mangled symbol to match exactly.
class IWifiChipEventCallback;

std::string toString(const ::android::sp<IWifiChipEventCallback>& /*unused*/) {
        return "IWifiChipEventCallback@1.0::unknown";
}

}  // namespace V1_0
}  // namespace wifi
}  // namespace hardware
}  // namespace android
