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

<br>

# 2강 - data type

- data type에는 4가지 종류: boolean, bytes, address, uint

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec2 {
    // data type에는 4가지 종류
    // boolean, bytes, address, uint

    // reference type
    // string, Arrays, struct

    // mapping type

    // boolean : true / false
    bool public b = false;

    // ! || == && (논리연산자)
    bool public b1 = !false; // true
    bool public b2 = false || true; // true
    bool public b3 = false == true; // false
    bool public b4 = false && true; // false

    // bytes 1 ~32
    bytes4 public bt = 0x12345678;
    bytes public bt2 = "STRING"; //bytes만으로 string 다룰 수 있음(자동할당)

    // address : 계좌번호와 같은 존재, 스마트 컨트랙에도 address 생김
    address public addr = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8;

    // int vs uint

    // int8
    // -2^7 ~ 2^7 - 1
    int8 public it = 4;

    // unit8 (unsigned, 보통 uint 사용)
    // 0 ~ 2^8 -1
    uint256 public uit = 132213;

    // + - * / 사용 가능
    
    // uint8 public uit2 = 256; // 범위가 넘어서 오류 발생
}
```

<br>

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

<br>

# 4강 - function 정의

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec4 {

    /*
    function 이름 () public { // (public, private, internal, external) 변경가능
        // 내용
        }
    */
    
    // 함수 실행될 때마다 gas 사용
    
    uint256 public a = 3;
    // 1. Parameter와 Return 값이 없는 function 정의
    function  changeA1() public {
        a = 5;
    }

    // 2. Parameter는 있고 Return 값이 없는 function 정의
    function  changeA2(uint256 _value) public {
        a = _value;
    }

    // 3. Parameter와 Return 값이 있는 function 정의
    function  changeA3(uint256 _value) public returns(uint256){
        a = _value;
        return a;
    }
}
```

<br>


# 5강 - function2 : public, private, internal, external

```solidity
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
```
