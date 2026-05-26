CC Switch 3.15.0 AppImage

文件:
  CC-Switch_3.15.0_amd64.AppImage

校验:
  SHA256: 6b2316fe90dff7ce1bf6462e2692484f9644a028364332ba7e0c191f9d240b44

适用环境:
  Linux x86_64
  已针对 Ubuntu 20.04 的 WebKitGTK / freetype / gbm / drm 兼容问题做处理。

运行方式:
  chmod +x CC-Switch_3.15.0_amd64.AppImage
  ./CC-Switch_3.15.0_amd64.AppImage

本版本修复:
  1. 修复 Ubuntu 20.04 下启动时报 libwebkit2gtk-4.1.so.0 undefined symbol 的问题。
  2. 修复设置页面点击“使用记录”时可能崩溃或卡死的问题。
  3. 修复设置页面点击“关于”时可能直接导致软件崩溃的问题。
  4. 使用记录改为按需加载，避免一次性触发大量 SQLite 查询和图表渲染。
  5. 关于页面不再自动执行本地 CLI 检测；需要手动点击刷新。
  6. 本地 CLI 版本检测已加入超时保护，避免外部命令卡住拖垮应用。

注意事项:
  1. 文件名中不要重复拼接 AppImage 名称。
     正确示例:
       ./CC-Switch_3.15.0_amd64.AppImage
     错误示例:
       ./CC Switch_3.15.0_amd64.AppImageSwitch_3.15.0_amd64.AppImage

  2. 如果旧版本正在运行，替换 AppImage 前建议先退出旧进程。

  3. 如果系统提示 FUSE 相关错误，可尝试:
       APPIMAGE_EXTRACT_AND_RUN=1 ./CC-Switch_3.15.0_amd64.AppImage

构建验证:
  pnpm typecheck: passed
  cargo check: passed
  cargo fmt --check: passed
  AppImage WebKit 运行库符号检查: passed

