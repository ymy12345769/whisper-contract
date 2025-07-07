# Whisper V2

这是一个改进版的 Web3 密语传输合约，支持链上加密字段 + 密码验证 + 限时销毁。

## 功能特点
- 使用 bytes32 存储密文（需前端加密后传入）
- 密码哈希验证（防止链上暴露明文密码）
- 支持信息有效期设定，到期自动失效
- 更安全的结构：链上仅存储加密信息 + 哈希

## 使用方法
1. 将 `WhisperV2.sol` 上传到 Remix
2. 编译部署（建议使用测试链）
3. 使用 `createWhisper(string encrypted, string password, durationInSeconds)` 创建密语
   - `encrypted`：前端加密后的信息字符串
   - `password`：访问时使用的口令
   - `durationInSeconds`：多少秒后销毁
4. 使用 `getWhisper(id, password)` 查看密语（必须在时间范围内、且密码正确）

⚠️ 注意：
- 合约本身不会加密信息，密文需你在前端或手动加密后写入
- 密文最大长度为 32 字节（超出部分将被截断）

