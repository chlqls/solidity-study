# 29강 - function5 : 함수리턴값 변수 명시

- return하는 값이 많아질수록 리턴값 변수 명시하는 것이 관리 차원에서 효율적

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec29 {

    function add(uint256 _num1, uint256 _num2) public pure returns (uint256) {
        uint256 total = _num1 + _num2;
        return total;
    }

    function add2(uint256 _num1, uint256 _num2) public pure returns (uint256 total) {
        total = _num1 + _num2;
        return total;
    }
}
```
