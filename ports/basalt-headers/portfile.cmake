vcpkg_from_gitlab(
  GITLAB_URL
  https://gitlab.com
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  VladyslavUsenko/basalt-headers
  REF
  91293fa478c008e9b103137a3f7d578aafab5858
  SHA512
  c7c2bd1141835a2c98b72957fcb434ef4f463d428842b2d1bb4221384dab453e1a7ef09ca3cfb582d3f046da31b22c55201990961b183d20684e90834f16137c
  HEAD_REF
  master
  PATCHES
  fix-cmake-install.patch)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/install-config.cmake"
     DESTINATION "${SOURCE_PATH}")

vcpkg_configure_cmake(
  SOURCE_PATH
  ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
  -DBASALT_BUILTIN_EIGEN=OFF
  -DBASALT_BUILTIN_CEREAL=OFF
  -DBASALT_BUILTIN_SOPHUS=OFF
  -DBUILD_TESTING=OFF)

vcpkg_install_cmake()

# Remove duplicated file
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Add the copyright
file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
