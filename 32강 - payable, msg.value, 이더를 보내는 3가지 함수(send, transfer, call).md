# 32강 - payable, msg.value, 이더를 보내는 3가지 함수(send, transfer, call)

### payable
- `payable`은 이더 / 토큰과 상호작용 시 필요한 키워드
- 즉, `send`, `transfer`, `call`을 이용하여 이더를 보낼 때 `payable` 키워드가 필요
- 주로 함수, 주소, 생성자에 붙여서 사용


### msg.value
- `msg.value`는 송금 보낸 코인의 값


### 이더를 보내는 3가지 함수
1. `send`: 2300 gas를 소비, 성공 여부를 true 또는 false로 리턴
2. `transfer`: 2300 gas를 소비, 실패 시 에러 발생
3. `call`: 가변적인 gas 소비(gas 값 지정 가능), 성공 여부를 true 또는 false로 리턴, 재진입(re-entrancy) 공격 위험 있음, 2019년 12월 이후 call 사용 추천(Checks-Effects-Interactions pattern과 함께 사용 권장)


```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec30 {

    event howMuch(uint256 _value);

    function sendNow(address payable _to) public payable { // _to는 스마트 컨트랙트 주소도 가능 -> 스마트 컨트랙트도 이더 받을 수 있음
        bool sent = _to.send(msg.value); // return true or false
        require(sent, "Failed to send Ether");
        emit howMuch(msg.value);
    }

    function transferNow(address payable _to) public payable {
        _to.transfer(msg.value); // return error
        emit howMuch(msg.value);
    }

    function callNow(address payable _to) public payable {
        // ~ 0.7
        // (bool sent, ) = _to.call.gas(1000).value(msg.value)("");
        // require(sent, "Failed to send Ether");

        // 0.7 ~
        (bool sent, ) = _to.call{value: msg.value, gas:1000}("");
        require(sent, "Failed to send Ether");
        emit howMuch(msg.value);
    }

}
```

- `sendNow`, `transferNow`,  실행(각각 첫번째 계정 -> 두번째 계정으로 10 ether씩 보냄) 결과
<img width="1844" height="612" alt="image" src="https://github.com/user-attachments/assets/6e24ab56-9570-44a8-9a5a-5ce835708257" />
<img width="442" height="223" alt="image" src="https://github.com/user-attachments/assets/ba40d336-877e-4aa6-afd4-9c89be0f8243" />
