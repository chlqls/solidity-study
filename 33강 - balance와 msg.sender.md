# 33강 - balance와 msg.sender

### 주소.balance
- `주소.balance`는 해당 특정 주소의 현재 갖고 있는 이더의 잔액을 나타냄 (`msg.value`는 송금액)
- `주소.balance`와 같은 형태로 사용


### msg.sender
- `msg.sender`는 스마트 컨트랙트를 사용하는 주체
- `msg.sender`는 이후 다루게 될 call vs delegate call에서 중요한 내용

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract MobileBanking {
    
    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

    function sendEther(address payable _to) public payable {
        require(msg.sender.balance >= msg.value, "Your balance is not enough");
        _to.transfer(msg.value);
        emit SendInfo(msg.sender, (msg.sender).balance);
    }

    function checkValueNow() public {
        emit MyCurrentValue(msg.sender, msg.sender.balance);
    }

    function checkUserMoney(address _to) public {
        emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
    }

}
```

- `sendEther()`로 첫번째 계정 -> 두번째 계정으로 10 ether 보낸 결과: `(msg.sender, (msg.sender).balance)` 출력

  <img width="893" height="261" alt="image" src="https://github.com/user-attachments/assets/4747486b-e505-4d90-8ef6-f48a4485663c" />

- 첫번째 계정으로 `checkValueNow()` 실행 결과: `(msg.sender, msg.sender.balance)` 출력

  <img width="885" height="253" alt="image" src="https://github.com/user-attachments/assets/34dbedc2-fe8b-4f52-a623-b99d461f91f2" />

- `checkUserMoney()` 이용해서 첫번째 계정으로 두번째 계정 정보 조회: `(msg.sender, _to, _to.balance)` 출력

  <img width="878" height="274" alt="image" src="https://github.com/user-attachments/assets/e3d44364-fd62-41ff-a71f-74dac2b38a57" />
