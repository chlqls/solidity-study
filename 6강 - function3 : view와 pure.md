# 6강 - function3 : view와 pure

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec6 {
    /*
    function 이름 () public { // (public, private, internal, external) 변경 가능
        // 내용
    }
    */

    // function get_a() external view returns (uint256) // view와 pure는 접근제어자 앞뒤에 사용 가능

    /*
    - view: function 밖의 변수들을 읽을 수 있으나 변경 불가능
    - pure: function 밖의 변수들을 읽지 못하고, 변경도 불가능
    - view와 pure 둘 다 명시 안 할 때: function 밖의 변수들을 읽어서 변경 가능
    */

    // 1. view
    uint256 public a = 1;

    function read_a() public view returns(uint256) {
        return a + 2;
    }

    // 2. pure
    function read_a2() public pure returns(uint256) {
        uint256 b = 1;
        return 4 + 2 + b;
    }

    // 3. pure, view 둘 다 사용 X
    function read_a3() public returns(uint256) {
        a = 13;
        return a;
    }
}
```
