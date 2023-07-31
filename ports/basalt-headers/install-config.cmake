include(CMakeFindDependencyMacro)
find_dependency(Eigen3)
find_dependency(Sophus)
find_dependency(cereal)

include("${CMAKE_CURRENT_LIST_DIR}/basalt-headersTargets.cmake")
