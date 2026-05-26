# CC Switch 3.15.0 AppImage - Ubuntu 20.04 可用版

这是专门针对 **Ubuntu 20.04 x86_64** 修复和重新打包的 CC Switch 3.15.0 AppImage。

本版本重点解决 Ubuntu 20.04 上常见的 WebKitGTK / freetype / gbm / drm 运行库兼容问题，可以在 Ubuntu 20.04 上直接运行，不再需要用户手动处理 `libwebkit2gtk-4.1.so.0`、`FT_Get_Color_Glyph_Paint` 等符号错误。

## 文件

- `output/CC-Switch_3.15.0_amd64.AppImage`
- `output/CC-Switch_3.15.0_amd64.zip`

## 校验

```text
SHA256: 6b2316fe90dff7ce1bf6462e2692484f9644a028364332ba7e0c191f9d240b44
```

## 适用环境

- Ubuntu 20.04 x86_64
- Linux x86_64
- 已内置并校验 Ubuntu 20.04 所需的 WebKitGTK 相关兼容运行库。

## 运行方式

在 Ubuntu 20.04 上进入 `output` 目录后执行：

```bash
chmod +x CC-Switch_3.15.0_amd64.AppImage
./CC-Switch_3.15.0_amd64.AppImage
```

如果系统没有安装 FUSE 或 AppImage 无法直接挂载，可使用：

```bash
APPIMAGE_EXTRACT_AND_RUN=1 ./CC-Switch_3.15.0_amd64.AppImage
```

## 本版本修复

1. 修复 Ubuntu 20.04 下启动时报 `libwebkit2gtk-4.1.so.0` undefined symbol 的问题。
2. 修复 Ubuntu 20.04 下 WebKitGTK 调用系统 freetype 时出现 `FT_Get_Color_Glyph_Paint` 符号缺失的问题。
3. 修复设置页面点击“使用记录”时可能崩溃或卡死的问题。
4. 修复设置页面点击“关于”时可能直接导致软件崩溃的问题。
5. 使用记录改为按需加载，避免一次性触发大量 SQLite 查询和图表渲染。
6. 关于页面不再自动执行本地 CLI 检测；需要手动点击刷新。
7. 本地 CLI 版本检测已加入超时保护，避免外部命令卡住拖垮应用。

## 注意事项

1. 文件名中不要重复拼接 AppImage 名称。

正确示例：

```bash
./CC-Switch_3.15.0_amd64.AppImage
```

错误示例：

```bash
./CC Switch_3.15.0_amd64.AppImageSwitch_3.15.0_amd64.AppImage
```

2. 如果旧版本正在运行，替换 AppImage 前建议先退出旧进程。

3. 如果 Ubuntu 20.04 提示 FUSE 相关错误，可尝试：

```bash
APPIMAGE_EXTRACT_AND_RUN=1 ./CC-Switch_3.15.0_amd64.AppImage
```

## 构建验证

- `pnpm typecheck`: passed
- `cargo check`: passed
- `cargo fmt --check`: passed
- AppImage 内置 WebKit / freetype / gbm / drm 运行库符号检查: passed
- Ubuntu 20.04 兼容目标: passed
