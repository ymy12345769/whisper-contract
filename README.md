# Whisper V1 (明文版)

这是最早版本的 Web3 密语传递智能合约（明文存储，仅演示用途）。

## 功能
- 创建一个链上密语（内容 + 销毁时间）
- 查看密语（信息编号 + 时效验证）

## 使用方法
1. 打开 Remix (https://remix.ethereum.org)
2. 上传 `contracts/Whisper.sol`
3. 编译、部署合约
4. 使用 `createWhisper` 创建密语
5. 使用 `getWhisper` 输入编号获取明文内容

⚠️ 注意：此版本为教学用，信息是明文上链的，所有人可见！
