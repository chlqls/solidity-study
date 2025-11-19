# 30강 - modifier 모디파이어

- 접근제어자 옆에 modifier 이름 써서 사용

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec30 {

    // 예제1
    // 매개변수 없는 modifier 
    modifier onlyAdults { // 매개변수 없는 경우에는 () 괄호 안 써도 됨
        revert("You are not allowed to pay for the cigarette");
        _; // 함수가 적용되는 위치 표시
    }

    function BuyCigarette() public onlyAdults returns(string memory) {
        return "Your payment is succeeded";
    }

    // 매개변수 있는 modifier
    modifier onlyAdults2(uint256 _age) {
        require(_age > 18, "You are not allowed to pay for the cigarette");
        _;
    }

    function BuyCigarette2(uint256 _age) public onlyAdults2(_age) returns(string memory) {
        return "Your payment is succeeded";
    }

    // 예제2
    uint256 public num = 5;
    modifier numChange {
        _;
        num = 10;
    }
    function numChangeFunction() public numChange { // num 값은 최종적으로 10으로 바뀜
        num = 15;
    }
}
```

- 예제2 실행 결과
  - `numChangeFunction` 이후 `num`이 10이 됨
  - <img width="460" height="449" alt="image" src="https://github.com/user-attachments/assets/9bef8f4d-7602-4b9e-9b3e-20a2f98e6799" />
