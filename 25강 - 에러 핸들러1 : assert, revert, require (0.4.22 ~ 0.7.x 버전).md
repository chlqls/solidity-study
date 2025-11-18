# 25강 - 에러 핸들러1 : assert, revert, require (0.4.22 ~ 0.7.x 버전)

- 에러핸들러: `require`, `revert`, `assert`, `try/catch`
  - `assert`: gas를 다 소비한 후, 특정한 조건에 부합하지 않으면 (false일 때) 에러를 발생시킨다. (gas 환불 X)
  - `revert`: 조건없이 에러를 발생시키고, gas를 환불시켜준다.
  - `require`: 특정한 조건에 부합하지 않으면 (false일 때) 에러를 발생시키고, gas를 환불시켜준다.

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec25 {

    // gas 비교
    // 3000000 gas -> 비효율적임, 주로 테스트용
    function assertVow() public pure {
        assert(false);
    }

    // 21322 gas 
    // 주로 if와 같이 사용
    function revertNow() public pure {
        revert("error!!"); // 에러 메세지 입력 가능
    }

    // 21338 gas
    // require = if + revert
    function requireNow() public pure {
        require(false, "occured");
    }

    // revert 사용
    function onlyAdults(uint256 _age) public pure returns(string memory) {
        if(_age < 19) {
            revert("You are not allowed to pay for the cigarette");
        }
        return "Your payment is succeeded";
    }

    // require 사용
    function onlyAdults2(uint256 _age) public pure returns(string memory) {
        require(_age > 19, "You are not allowed to pay for the cigarette"); // 주의: 조건문이 false일 때 에러 발생
        return "Your payment is succeeded";
    }

}
```

- assert 에러 발생 모습

  <img width="2051" height="337" alt="image" src="https://github.com/user-attachments/assets/e266fe84-5fc5-4b16-8e3d-4ea2c9e7468b" />

- `onlyAdults2` 실행 모습

  <img width="1213" height="292" alt="image" src="https://github.com/user-attachments/assets/9fa033fb-f4a8-4f4c-83bc-543eccb3915a" />
