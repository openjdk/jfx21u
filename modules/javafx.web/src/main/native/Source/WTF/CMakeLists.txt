set_property(DIRECTORY . PROPERTY FOLDER "WTF")

add_subdirectory(wtf)

# Apple builds have the ICU headers checked into ${WTF_DIR}/icu
# Copy them into ${ICU_INCLUDE_DIRS} so the build behaves like find_package was used
if (USE_APPLE_ICU AND NOT PORT STREQUAL "Java")
    file(COPY ${WTF_DIR}/icu/unicode DESTINATION ${ICU_INCLUDE_DIRS})
endif ()
