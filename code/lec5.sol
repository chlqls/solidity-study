// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec5 {
    /*
    function 이름 () public { // (public, private, internal, external) 변경가능
        // 내용
        }
    */

    /*
    - public: 모든 곳에서 접근 가능
    - external: public처럼 모든 곳에서 접근 가능하나, external이 정의된 자기자신 컨트랙 내에서 접근 불가
    - private: 오직 private이 정의된 자기 컨트랙에서만 가능(private이 정의된 컨트랙을 상속 받은 자식도 불가능)
    - internal: private처럼 오직 internal이 정의된 자기 컨트랙에서만 가능하고, internal이 정의된 컨트랙을 상속 받은 자식 컨트랙에서도 접근 가능
    */

    // internal contract <- internal contract child contract (상속받은 컨트랙에서도 접근 가능)

    // 1. public
    uint256 public a = 5;

    // 2. private
    uint256 private a2 = 5;

}

contract Public_example {
    uint256 public a = 3; // external하면 안됨. 동일 컨트랙 안에서 a에 접근해야하므로

    function changeA(uint256 _value) public { // external 가능, private 불가능 (다른 컨트랙에서 접근해야하므로)
        a = _value;
    }
    function get_a() view public returns (uint256) {
        return a;
    }
}

contract Public_example_2 {
    Public_example instance = new Public_example();

    function changeA_2(uint256 _value) public {
        instance.changeA(_value);
    }

    function use_public_example_a() view public returns (uint256) {
        return instance.get_a();
    }
    
}