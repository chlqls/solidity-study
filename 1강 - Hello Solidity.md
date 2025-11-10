# 1강 - Hello Solidity
- 솔리디티란?
  - Solidity is an object-oriented, high-level language for implementing smart contracts. ([Solidity — Solidity 0.8.30 documentation](https://docs.soliditylang.org/en/v0.8.30/))
  - = Smart Contracts을 개발하기 위한 언어
- Smart Contracts이란?
  - 미리 정의된 조건을 만족하면 블록체인 안에 저장된 프로그램이 작동

<br>

```solidity
// SPDX-License-Identifier: GPL-30
// 꼭 라이센스 명시해줘야 함

// 버전 설정
pragma solidity >= 0.7.0 < 0.9.0;

contract Hello {
    string public hi = "Hello solidity";
}

// compile 후 deploy
```

<img width="1878" height="1350" alt="image" src="https://github.com/user-attachments/assets/e3f52f3c-6edf-4c78-a8ba-858f307fcaf6" />  
