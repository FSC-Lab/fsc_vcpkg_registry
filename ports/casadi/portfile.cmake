vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  casadi/casadi
  REF
  release-3.6.3
  SHA512
  6e0fcb51d0b6c4a24e19ddb0f04ec12d5742f45622ba36c40ddbb744a7f74b32919f95c7857c88a6dc86b952db93e6f11f6685fc70b85f40ee21e45815461762
  HEAD_REF
  master)

vcpkg_configure_cmake(
  SOURCE_PATH
  ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
  -DWITH_IPOPT=BOOL:ON
  -DINCLUDE_PREFIX:PATH=include
  -DLIB_PREFIX:PATH=lib
  -DBIN_PREFIX:PATH=bin)

vcpkg_install_cmake()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake"
     "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")

# Remove duplicated file
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Install the pkgconfig file
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
  file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/casadi.pc
       DESTINATION ${CURRENT_PACKAGES_DIR}/lib/pkgconfig)
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
  file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/casadi.pc
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)
endif()

vcpkg_fixup_pkgconfig()

# Add the copyright
file(
  INSTALL ${SOURCE_PATH}/LICENSE.txt
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
