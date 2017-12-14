include(GNUInstallDirs)
include(VersioningUtils)

SET_PROJECT_VERSION(0 19 0)
set(WPE_API_VERSION 0.1)

CALCULATE_LIBRARY_VERSIONS_FROM_LIBTOOL_TRIPLE(WEBKIT 1 0 0)

WEBKIT_OPTION_BEGIN()

WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_3D_TRANSFORMS PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_ACCELERATED_2D_CANVAS PUBLIC OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_CSS_REGIONS PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_CSS_SELECTORS_LEVEL4 PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_DEVICE_ORIENTATION PUBLIC OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_ENCRYPTED_MEDIA PUBLIC OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_GAMEPAD PUBLIC OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_GEOLOCATION PUBLIC OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_INDEXED_DATABASE PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_INDEXED_DATABASE_IN_WORKERS PRIVATE OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_MEDIA_CONTROLS_SCRIPT PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_MEDIA_SOURCE PUBLIC OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_MHTML PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_NETSCAPE_PLUGIN_API PRIVATE OFF)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_PUBLIC_SUFFIX_LIST PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_REMOTE_INSPECTOR PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_SUBTLE_CRYPTO PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_TOUCH_EVENTS PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_USER_MESSAGE_HANDLERS PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_VIDEO PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_VIDEO_TRACK PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_WEB_ANIMATIONS PRIVATE ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_WEB_AUDIO PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_WEB_CRYPTO PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_WEBGL PUBLIC ON)
WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_XSLT PUBLIC ON)

if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_MEMORY_SAMPLER PRIVATE ON)
    WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_RESOURCE_USAGE PRIVATE ON)
else ()
    WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_MEMORY_SAMPLER PRIVATE OFF)
    WEBKIT_OPTION_DEFAULT_PORT_VALUE(ENABLE_RESOURCE_USAGE PRIVATE OFF)
endif ()

WEBKIT_OPTION_DEFINE(USE_GSTREAMER_GL "Whether to enable support for GStreamer GL" PRIVATE OFF)

WEBKIT_OPTION_END()

SET_AND_EXPOSE_TO_BUILD(ENABLE_DEVELOPER_MODE ${DEVELOPER_MODE})

set(ENABLE_API_TESTS ${DEVELOPER_MODE})

set(JavaScriptCore_LIBRARY_TYPE STATIC)
set(WebCore_LIBRARY_TYPE STATIC)
set(WebKit2_OUTPUT_NAME WPEWebKit)
set(WebKit2_WebProcess_OUTPUT_NAME WPEWebProcess)
set(WebKit2_NetworkProcess_OUTPUT_NAME WPENetworkProcess)
set(WebKit2_StorageProcess_OUTPUT_NAME WPEStorageProcess)

find_package(ICU REQUIRED)
find_package(Threads REQUIRED)
find_package(ZLIB REQUIRED)
find_package(GLIB 2.40.0 REQUIRED COMPONENTS gio gio-unix gobject gthread gmodule)

find_package(Cairo 1.10.2 REQUIRED)
find_package(Fontconfig 2.8.0 REQUIRED)
find_package(Freetype2 2.4.2 REQUIRED)
find_package(HarfBuzz 0.9.18 REQUIRED)
find_package(JPEG REQUIRED)
find_package(LibEpoxy 1.4.0 REQUIRED)
find_package(LibGcrypt 1.6.0 REQUIRED)
find_package(LibSoup 2.42.0 REQUIRED)
find_package(LibXml2 2.8.0 REQUIRED)
find_package(PNG REQUIRED)
find_package(Sqlite REQUIRED)
find_package(WebP REQUIRED)

find_package(WPEBackend REQUIRED)

if (ENABLE_XSLT)
    find_package(LibXslt 1.1.7 REQUIRED)
endif ()

set(USE_CAIRO ON)
set(USE_XDGMIME ON)
SET_AND_EXPOSE_TO_BUILD(USE_GCRYPT TRUE)

if (ENABLE_VIDEO OR ENABLE_WEB_AUDIO)
    set(GSTREAMER_COMPONENTS app audio pbutils)
    SET_AND_EXPOSE_TO_BUILD(USE_GSTREAMER TRUE)
    if (ENABLE_VIDEO)
        list(APPEND GSTREAMER_COMPONENTS video tag)
    endif ()

    if (ENABLE_WEB_AUDIO)
        list(APPEND GSTREAMER_COMPONENTS fft)
        SET_AND_EXPOSE_TO_BUILD(USE_WEBAUDIO_GSTREAMER TRUE)
    endif ()

    find_package(GStreamer 1.2.3 REQUIRED COMPONENTS ${GSTREAMER_COMPONENTS})

    # FIXME: What about MPEGTS support? USE_GSTREAMER_MPEGTS?
endif ()

if (ENABLE_MEDIA_STREAM OR ENABLE_WEB_RTC)
    find_package(OpenWebRTC)
    if (NOT OPENWEBRTC_FOUND)
        message(FATAL_ERROR "OpenWebRTC is needed for ENABLE_MEDIA_STREAM and ENABLE_WEB_RTC.")
    endif ()
    SET_AND_EXPOSE_TO_BUILD(USE_OPENWEBRTC TRUE)
endif ()

if (ENABLE_ACCELERATED_2D_CANVAS)
    find_package(CairoGL 1.10.2 REQUIRED COMPONENTS cairo-egl)
endif ()

if (ENABLE_SUBTLE_CRYPTO)
    find_package(Libtasn1 REQUIRED)
    if (NOT LIBTASN1_FOUND)
        message(FATAL_ERROR "libtasn1 is required to enable Web Crypto API support.")
    endif ()
    if (LIBGCRYPT_VERSION VERSION_LESS 1.7.0)
        message(FATAL_ERROR "libgcrypt 1.7.0 is required to enable Web Crypto API support.")
    endif ()
endif ()

add_definitions(-DBUILDING_WPE__=1)
add_definitions(-DGETTEXT_PACKAGE="WPE")
add_definitions(-DDATA_DIR="${CMAKE_INSTALL_DATADIR}")
add_definitions(-DUSER_AGENT_GLIB_MAJOR_VERSION="601")
add_definitions(-DUSER_AGENT_GLIB_MINOR_VERSION="1")

set(USE_UDIS86 1)

SET_AND_EXPOSE_TO_BUILD(USE_LIBEPOXY TRUE)
SET_AND_EXPOSE_TO_BUILD(USE_OPENGL_ES_2 TRUE)
SET_AND_EXPOSE_TO_BUILD(USE_EGL TRUE)

SET_AND_EXPOSE_TO_BUILD(ENABLE_GRAPHICS_CONTEXT_3D TRUE)

SET_AND_EXPOSE_TO_BUILD(USE_TEXTURE_MAPPER TRUE)
SET_AND_EXPOSE_TO_BUILD(USE_TEXTURE_MAPPER_GL TRUE)
SET_AND_EXPOSE_TO_BUILD(USE_TILED_BACKING_STORE TRUE)
SET_AND_EXPOSE_TO_BUILD(USE_COORDINATED_GRAPHICS TRUE)
SET_AND_EXPOSE_TO_BUILD(USE_COORDINATED_GRAPHICS_THREADED TRUE)

set(FORWARDING_HEADERS_DIR ${DERIVED_SOURCES_DIR}/ForwardingHeaders)
set(FORWARDING_HEADERS_WPE_DIR ${FORWARDING_HEADERS_DIR}/wpe)
set(FORWARDING_HEADERS_WPE_EXTENSION_DIR ${FORWARDING_HEADERS_DIR}/wpe-webextension)
set(DERIVED_SOURCES_WPE_API_DIR ${DERIVED_SOURCES_WEBKIT2_DIR}/wpe)

# Build with -fvisibility=hidden to reduce the size of the shared library.
# Not to be used when building the WebKitTestRunner library.
if (NOT DEVELOPER_MODE)
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -fvisibility=hidden")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -fvisibility=hidden -fvisibility-inlines-hidden")
endif ()