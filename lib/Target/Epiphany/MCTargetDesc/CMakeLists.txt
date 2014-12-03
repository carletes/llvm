add_llvm_library(LLVMEpiphanyDesc
  # EpiphanyAsmBackend.cpp
  # EpiphanyELFObjectWriter.cpp
  # EpiphanyELFStreamer.cpp
  # EpiphanyMCAsmInfo.cpp
  # EpiphanyMCCodeEmitter.cpp
  # EpiphanyMCExpr.cpp
  # EpiphanyMCTargetDesc.cpp
  # EpiphanyMachObjectWriter.cpp
  # EpiphanyTargetStreamer.cpp
)
add_dependencies(LLVMEpiphanyDesc EpiphanyCommonTableGen)

# Hack: we need to include 'main' target directory to grab private headers
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/.. ${CMAKE_CURRENT_BINARY_DIR}/..)
