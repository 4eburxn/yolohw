#ifndef __USE_H__
#define __USE_H__

#define DEBUG_SECTION if constexpr (_DEBUG_ENABLED)
#define IMSHOW_SECTION if constexpr (!_HEADLESS_ENABLED)

#endif  // !__USE_H__
