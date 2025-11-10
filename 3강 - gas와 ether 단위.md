# 3강 - gas와 ether 단위

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec3 {
    // 1 ether = 10^9 Gwei = 10^18 wei
    // 0.000000000000000001 ether = 10^(-18) ether = 1 wei
    
    // 스마트 컨트랙 사용할 때 지불하는 비용
    // 비용 산출 방법: 스마트 컨트랙을 얼마나 길게 작성하느냐에 따라 (Ethereum Yellow Paper 참고)

    // 0.01 ether = 10^16 wei
    uint256 public value = 1 ether;
    uint256 public value2 = 1 wei;
    uint256 public value3 = 1 gwei;

    // 해커가 공격을 시도할 때 비용적인 문제 부담하게 되므로 gas로 ddos같은 공격을 방지할 수 있다

}
```

- deploy 할 때도 gas 사용

<img width="1327" height="688" alt="image" src="https://github.com/user-attachments/assets/16550e5f-a6e3-4828-811c-2145e7bc307f" />  

