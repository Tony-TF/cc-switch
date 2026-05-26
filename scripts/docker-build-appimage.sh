#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="${IMAGE_NAME:-cc-switch-appimage-builder:22.04}"
HOST_UID="$(id -u)"
HOST_GID="$(id -g)"

docker build \
  -f "${ROOT_DIR}/docker/appimage/Dockerfile" \
  -t "${IMAGE_NAME}" \
  "${ROOT_DIR}"

docker run --rm \
  -e APPIMAGE_EXTRACT_AND_RUN=1 \
  -v "${ROOT_DIR}:/workspace" \
  -w /workspace \
  "${IMAGE_NAME}" \
  bash -lc "set -euo pipefail
    pnpm install --frozen-lockfile
    rm -rf dist \
      src-tauri/target/release/build/cc-switch-* \
      src-tauri/target/release/.fingerprint/cc-switch-* \
      src-tauri/target/release/deps/cc_switch* \
      src-tauri/target/release/deps/libcc_switch*
    pnpm tauri build --bundles appimage --config '{\"bundle\":{\"createUpdaterArtifacts\":false}}'

    app_dir=\$(find src-tauri/target/release/bundle/appimage -maxdepth 1 -type d -name '*.AppDir' | head -n 1)
    if [ -z \"\${app_dir}\" ]; then
      echo 'AppDir not found' >&2
      exit 1
    fi

    lib_dir=\"\${app_dir}/usr/lib\"
    mkdir -p \"\${lib_dir}\" output

    cp -a /usr/lib/x86_64-linux-gnu/libfreetype.so.6* \"\${lib_dir}/\"
    cp -a /usr/lib/x86_64-linux-gnu/libgbm.so.1* \"\${lib_dir}/\"
    cp -a /usr/lib/x86_64-linux-gnu/libdrm.so.2* \"\${lib_dir}/\"

    rm -f output/CC-Switch_3.15.0_amd64.AppImage

    APPIMAGE_EXTRACT_AND_RUN=1 ARCH=x86_64 \
      ./tools/appimagetool-x86_64.AppImage \
      \"\${app_dir}\" \
      output/CC-Switch_3.15.0_amd64.AppImage

    chown -R ${HOST_UID}:${HOST_GID} node_modules dist src-tauri/target output"
