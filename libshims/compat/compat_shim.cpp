#include <string>
#include <cstdint>

// LogMessage constructor shim
// android::base::LogMessage::LogMessage(char const*, unsigned int,
//     android::base::LogId, android::base::LogSeverity, int)
extern "C" void _ZN7android4base10LogMessageC1EPKcjNS0_5LogIdENS0_11LogSeverityEi(
    void* thiz, const char* file, unsigned int line,
    int id, int severity, int error) {}

// LogMessage destructor shim (likely also needed)
extern "C" void _ZN7android4base10LogMessageD1Ev(void* thiz) {}

// OmxStore constructor shim
// android::hardware::media::omx::V1_0::implementation::OmxStore::OmxStore(
//     char const*, char const* const*, char const*, char const*, char const*)
extern "C" void _ZN7android8hardware5media3omx4V1_014implementation8OmxStoreC1EPKcPKS7_S7_S7_S7_(
    void* thiz, const char* a, const char* const* b,
    const char* c, const char* d, const char* e) {}

// GNSS toString shim
namespace android {
namespace hardware {
namespace gnss {
namespace V1_0 {

template<typename T>
std::string toString(unsigned int o) { return std::string(); }

namespace IGnssNiCallback {
enum GnssNiNotifyFlags : uint32_t {};
}

template std::string toString<IGnssNiCallback::GnssNiNotifyFlags>(unsigned int);

} // namespace V1_0
} // namespace gnss
} // namespace hardware
} // namespace android
