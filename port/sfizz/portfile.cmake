include(vcpkg_common_functions)

set(VCPKG_DEP_INFO_SOURCE "git+https://github.com/sfztools/sfizz")
set(VCPKG_DEP_INFO_TAG "v1.2.0")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sfztools/sfizz
    REF a708acbe8e82805d60f084d2c3fce64abed1280d
    SHA512 fd9ec523bfc09cf60a09732a92a55111f097d98b064b427fc610c832939f826e261391c1f2177df924305242315375be740cad16805000a0cc8fd03698551e59
    PATCHES
      diff.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DCMAKE_CXX_STANDARD=17
        -DSFIZZ_USE_SYSTEM_ABSEIL=TRUE
        -DSFIZZ_GIT_SUBMODULE_CHECK=FALSE
        -DSFIZZ_USE_SYSTEM_ABSEIL=TRUE
        -DSFIZZ_USE_SYSTEM_GHC_FS=TRUE
        -DSFIZZ_USE_SYSTEM_SIMDE=TRUE
        -DSFIZZ_SHARED=TRUE
        -DSFIZZ_GIT_SUBMODULE_CHECK=FALSE
)

vcpkg_cmake_build()
vcpkg_cmake_install()

# Manually install SfizzConfig.cmake
file(INSTALL "${SOURCE_PATH}/cmake/SfizzConfig.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/cmake")
file(INSTALL "${SOURCE_PATH}/cmake/SfizzConfig.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/cmake")
# file(INSTALL "${SOURCE_PATH}/cmake/GNUWarnings.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/cmake")
# file(INSTALL "${SOURCE_PATH}/cmake/GNUWarnings.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/cmake")

vcpkg_copy_pdbs()

# vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
vcpkg_cmake_config_fixup(CONFIG_PATH cmake)

vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")


file(GLOB DLL_FILES "${SOURCE_DIR}/lib/*.dll")
file(INSTALL ${DLL_FILES} DESTINATION "${CURRENT_PACKAGES_DIR}/bin")

# vcpkg_cmake_install()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)