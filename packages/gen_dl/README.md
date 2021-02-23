# gen_dl

#dc 使用说明    
生成 dart 与 c之间的代码
1. 增加依赖 
```yaml
dev_dependencies:
  build_runner: ^1.10.3
  gen_dl:
    path: ../gen_dl
```
2. 增加build.yaml文件
```yaml
# Read about `build.yaml` at https://pub.dev/packages/build_config
targets:
  $default:
    builders:
      # Configure the builder `pkg_name|builder_name`
      # In this case, the member_count builder defined in `../example`
      gen_dl|dc:
        generate_for:
          - lib/wallets_c.dart
```
3. 运行 flutter pub run build_runner build会生成代码
