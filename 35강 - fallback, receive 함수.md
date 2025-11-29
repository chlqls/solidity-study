# 35강 - fallback, receive 함수

## 0.6 이전의 fallback
- `fallback` 함수는 이름 그대로 대비책 함수를 의미함
  
### 특징
1. 무기명 함수, 즉 이름이 없는 함수이다
2. `external` 사용 필수
3. `payable` 사용 필수

### 사용하는 이유
1. 스마트 컨트랙트가 이더를 바등 수 있게 함
2. 이더 받고 난 직후 어떠한 행동을 취하게 할 수 있음
3. `call` 함수로 없는 함수가 불려질 때, 어떠한 행동을 취하게 할 수 있음

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.5.0 < 0.9.0;

/*
// 0.6 이전
function () external payable {
...
}
*/

contract Bank {

    event JustFallbackWithFunds(address _from, uint256 _value, string message);

    // ~ 0.6
    // bank는 fallback을 통해 이더를 받음
    function() external payable {
        emit JustFallbackWithFunds(msg.sender, msg.value, "JustFallbackWithFunds is called"); // msg.sender: 스마트 컨트랙트를 실행시키는 주체
    }

}

contract You {

    // receive()
    // DepositWithSend() 실행시켰을 때, Bank의 msg.sender는 You이고, You의 msg.dender는 account1
    function DepositWithSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed");
    }

    function DepositWithTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function DepositWithCall(address payable _to) public payable {
        // ~ 0.7
        (bool sent, ) = _to.call.value(msg.value)("");
        require(sent, "Failed to send ether");

        // 0.7 ~
        // (bool sent, ) = _to.call{value: msg.value}("");
        // require(sent, "Failed");
    }

    // fallback
    function JustGiveMessage(address _to) public {
        // ~ 0.7
        (bool sent, ) = _to.call("HI"); // 예시. HI라는 함수 호출 -> 그러나 HI라는 함수가 없기 때문에 fallback 함수 실행
        require(sent, "Failed to send ether");

        // 0.7 ~
        // (bool success, ) = _to.call("HI");
        // require(success, "Failed");
    }

    // To the fallback() with Funds
    function JustGiveMessageWithFunds(address payable _to) public payable {
        // ~ 0.7
        (bool sent, ) = _to.call.value(msg.value)("HI");
        require(sent, "Failed to send ether");

        // 0.7 ~
        // (bool success, ) = _to.call{value:msg.value}("HI");
        // require(success, "Failed");
    }
}
```


- `Bank` 컨트랙트의 주소를 매개변수로 입력

<img width="1213" height="424" alt="image" src="https://github.com/user-attachments/assets/f5ab21b8-5483-4c7a-add9-4b18e7d7ecbe" />


## 0.6 이후의 fallback

- `fallback`은 `receive`와 `fallback`으로 두가지 형태로 나뉨
  - `receive`: 순수하게 이더만 받을 때 작동
  - `fallback`: 함수를 실행하면서 이더를 보낼 때, 혹은 불려진 함수가 없을 때 작동

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

/*
// 기본형: 불려진 함수가 특정 스마트 컨트랙트가 없을 때, fallback 함수가 발동
fallback() external {
...
}

// payable 적용 시: 이더를 받고 나서도 fallback 함수가 발동
fallback() external payable {
...
}

recerive() external payable {
...
}
*/

contract Bank {

    event JustFallback(address _from, string message);
    event ReceiveFallback(address _from, uint256 _value, string message);
    event JustFallbackWithFunds(address _from, uint256 _value, string message);

    // ~ 0.6
    // bank는 fallback을 통해 이더를 받음
    // function() external payable {
    //     emit JustFallbackWithFunds(msg.sender, msg.value, "JustFallbackWithFunds is called"); // msg.sender: 스마트 컨트랙트를 실행시키는 주체
    // }

    // 0.6 ~
    // fallback() external {
    //     emit JustFallback(msg.sender, "JustFallback is called");
    // }
    receive() external payable { // Bank 컨트랙트는 receive()를 통해 이더를 받음
        emit ReceiveFallback(msg.sender, msg.value, "ReceiveFallback is called");
    }
    fallback() external payable {
        emit JustFallbackWithFunds(msg.sender, msg.value, "JustFallbackWithFunds is called"); // msg.sender: 스마트 컨트랙트를 실행시키는 주체
    }

}

contract You {

    // receive()
    // DepositWithSend() 실행시켰을 때, Bank의 msg.sender는 You이고, You의 msg.dender는 account1
    function DepositWithSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed");
    }

    function DepositWithTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function DepositWithCall(address payable _to) public payable {
        // ~ 0.7
        // (bool sent, ) = _to.call.value(msg.value)("");
        // require(sent, "Failed to send ether");

        // 0.7 ~
        (bool sent, ) = _to.call{value: msg.value}(""); // ReceiveFallback 출력됨
        require(sent, "Failed");
    }

    // fallback
    function JustGiveMessage(address _to) public {
        // ~ 0.7
        // (bool sent, ) = _to.call("HI"); // 예시. HI라는 함수 호출 -> 그러나 HI라는 함수가 없기 때문에 fallback 함수 실행
        // require(sent, "Failed to send ether");

        // 0.7 ~
        (bool success, ) = _to.call("HI"); // JustFallback 출력됨
        require(success, "Failed");
    }

    // To the fallback() with Funds
    function JustGiveMessageWithFunds(address payable _to) public payable {
        // ~ 0.7
        // (bool sent, ) = _to.call.value(msg.value)("HI");
        // require(sent, "Failed to send ether");

        // 0.7 ~
        (bool success, ) = _to.call{value:msg.value}("HI"); // JustFallbackWithFunds 출력됨
        require(success, "Failed");
    }
}

```

- `DepositWithSend()`와 `DepositWithTransfer()`은 에러가 발생함. 왜냐하면 `send()`와 `tranfer`은 2300 gas만으로 해당 event를 출력하기 어려움
  - `ReceiveFallback()`의 에러 메시지 출력 부분만 지워도 `send()`와 `tranfer`가 작동
  - 혹은 0.7 버전으로 실행하면 잘 작동됨 -> 0.8 버전 되면서 gas가 비싸짐을 의미


- `JustGiveMessageWithFunds()` 실행 결과
  
  <img width="900" height="273" alt="image" src="https://github.com/user-attachments/assets/2a47a3b9-43d7-4144-a0a3-50cc2ca1d497" />


- `Bank` 컨트랙트에 `receive()`와 `fallback()`이 있으므로 이더를 송금 받을 수 있음
  - 배포된 Bank 컨트랙트에서 Transact 버튼 누르면 Bank 컨트랙트 주소로 이더 전송됨

  <img width="896" height="395" alt="image" src="https://github.com/user-attachments/assets/fe557cfa-3c1c-4d89-9121-591a6b24c5c4" />
