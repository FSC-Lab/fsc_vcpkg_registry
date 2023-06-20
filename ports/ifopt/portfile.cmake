vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  ethz-adrl/ifopt
  REF
  0b6ca7bda74169e85021000e46c7ba5a706e868c
  SHA512
  9715c273bc775df94d23b1c7e454fffbe180a5ac03b9168836c36fc1708ab1cead604ea0bfed478bc97854a91c80e80868100bf78027aa35228ee9519bc2c736
  HEAD_REF
  master)

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA OPTIONS
                      -DBUILD_IPOPT=BOOL:ON)

vcpkg_install_cmake()

# Remove duplicated file
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Add the copyright
file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
