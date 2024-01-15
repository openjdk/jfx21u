# Release Notes for JavaFX 21.0.2

## Introduction

The following notes describe important changes and information about this release. In some cases, the descriptions provide links to additional detailed information about an issue or a change.

These notes document the JavaFX 21.0.2 update release. As such, they complement the [JavaFX 21](https://github.com/openjdk/jfx21u/blob/master/doc-files/release-notes-21.md) and [JavaFX 21.0.1](https://github.com/openjdk/jfx21u/blob/master/doc-files/release-notes-21.0.1.md) release notes.

## List of Fixed Bugs

Issue key|Summary|Subcomponent
---------|-------|------------
[JDK-8317370](https://bugs.openjdk.org/browse/JDK-8317370)|JavaFX runtime version is wrong at runtime|base
[JDK-8311185](https://bugs.openjdk.org/browse/JDK-8311185)|VirtualFlow jump when cellcount changes|controls
[JDK-8307536](https://bugs.openjdk.org/browse/JDK-8307536)|FileAlreadyExistsException from NativeLibLoader when running concurrent applications with empty cache|graphics
[JDK-8313648](https://bugs.openjdk.org/browse/JDK-8313648)|JavaFX application continues to show a black screen after graphic card driver crash|graphics
[JDK-8319079](https://bugs.openjdk.org/browse/JDK-8319079)|Missing range checks in decora|graphics
[JDK-8317508](https://bugs.openjdk.org/browse/JDK-8317508)|Provide media support for libavcodec version 60|media
[JDK-8318386](https://bugs.openjdk.org/browse/JDK-8318386)|Update Glib to 2.78.1|media
[JDK-8318387](https://bugs.openjdk.org/browse/JDK-8318387)|Update GStreamer to 1.22.6|media
[JDK-8320267](https://bugs.openjdk.org/browse/JDK-8320267)|WebView crashes on macOS 11 with WebKit 616.1|web
[JDK-8251240](https://bugs.openjdk.org/browse/JDK-8251240)|Menus inaccessible on Linux with i3 wm|window-toolkit
[JDK-8315074](https://bugs.openjdk.org/browse/JDK-8315074)|Possible null pointer access in native glass|window-toolkit
[JDK-8315958](https://bugs.openjdk.org/browse/JDK-8315958)|Missing range checks in GlassPasteboard|window-toolkit
[JDK-8319066](https://bugs.openjdk.org/browse/JDK-8319066)|Application window not always activated in macOS 14 Sonoma|window-toolkit
[JDK-8319669](https://bugs.openjdk.org/browse/JDK-8319669)|[macos14] Running any JavaFX app prints Secure coding warning|window-toolkit

## List of Security fixes

Issue key|Summary|Subcomponent
---------|-------|------------
JDK-8313048 (not public)|Better Glyph handling|graphics
JDK-8313105 (not public)|Improved media framing|media
JDK-8313056 (not public)|General enhancements of Glass|window-toolkit
