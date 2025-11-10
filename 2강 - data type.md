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
