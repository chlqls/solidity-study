# 7강 - function4 : 4개의 저장영역과 String

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec7 {

    /*
    솔리디티의 4가지 저장영역
    1. storage: 대부분의 변수(함수 밖), 함수들이 저장되며, 영속적으로 저장이 되어 가스 비용이 비쌈
    2. memory: 함수의 파라미터, 리턴값, 레퍼런스 타입이 주로 저장됨(+ 함수 내에서 정의된 변수), 
               그러나 storage처럼 영속적이지 않고, 함수 내에서만 유효하기에 storage보다 가스 비용 저렴
    3. Calldata: 주로 external function의 파라미터에서 사용됨
    4. stack: EVM(Ethereum Virtual Machine)에서 stack data를 관리할 때 사용하는 영역, 1024Mb 제한적
    */

    // function -string.
    function get_string(string memory _str) public pure returns(string memory) { // string이 파라미터나 리턴값에 올 때 memory 지정해줘야 함
        return _str;
    }

    function get_uint(uint256 _ui) public pure returns(uint256) {
        return _ui;
    }
}

```
