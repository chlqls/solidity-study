# 8강 - instance1 : 정의

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract A {

    uint256 public a = 5;

    function change(uint256 _value) public {
        a = _value;
    }

}

contract B {

    A instance1 = new A(); // A의 분신을 만든거나 마찬가지. -> 컨트랙 B에서 a 값 변경해도 실제로 컨트랙 A에서 a 값은 바뀌지 않음.

    function get_A() public view returns(uint256) {
        return instance1.a(); // 인스턴스의 변수에 접근할 때에서 () 괄호 써주기
    }
    function change_A(uint256 _value) public {
        instance1.change(_value);
    }

}
```
