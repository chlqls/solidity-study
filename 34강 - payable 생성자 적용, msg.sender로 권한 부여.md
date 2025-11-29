# 34강 - payable 생성자 적용, msg.sender로 권한 부여

## payable을 생성자에 붙이는 경우

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract MobileBanking {
    
    // 1. payable을 생성자에 붙이는 경우 -> 스마트 컨트랙트가 배포될 때 스마트 컨트랙트가 이더를 받을 수 있음
    constructor() payable {

    }

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

- 배포할 때 이더를 넣어줌

  <img width="452" height="686" alt="image" src="https://github.com/user-attachments/assets/6f7c54fd-90de-44b7-bba3-a785aeb55868" />

- `checkUserMoney()`로 스마트 컨트랙트 주소 보내서 스마트 컨트랙트의 이더 조회 -> 10 받은 것을 확인

  <img width="247" height="145" alt="image" src="https://github.com/user-attachments/assets/e4619b0f-922d-4d32-98ea-f6b346c5302e" />
  <img width="899" height="283" alt="image" src="https://github.com/user-attachments/assets/26f173e1-9398-4685-a5ae-286c7de954da" />

<br>

## 특정 주소에게만 권한 주기

1. `require` 사용

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract MobileBanking {

    // 2. 특정 주소에게만 권한 주기
    address owner;
    constructor() payable { // 배포한 주소를 owner에 넣음
        owner = msg.sender;
    }

    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

    function sendEther(address payable _to) public payable {
        require(msg.sender == owner, "Only owner!"); // 추가, owner만 sendEther 사용 가능함
        require(msg.sender.balance >= msg.value, "Your balance is not enough");
        _to.transfer(msg.value);
        emit SendInfo(msg.sender, (msg.sender).balance);
    }

// ...

}
```

- 배포는 첫번째 계정으로 하고, 두번째 계정으로 `sendEther` 실행하려고 할 때 에러 발생 (첫번째 계정으로는 정상 작동)

  <img width="746" height="128" alt="image" src="https://github.com/user-attachments/assets/9665077e-74da-46be-ba3e-38b9cd43c701" />


2. `modifier` 사용

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract MobileBanking {

    // 2. 특정 주소에게만 권한 주기
    address owner;
    constructor() payable { // 배포한 주소를 owner에 넣음
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only Owner!");
        _;
    }

    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(address _msgSender, address _to, uint256 _value);

    function sendEther(address payable _to) public onlyOwner payable { // onlyOwner 추가
        require(msg.sender.balance >= msg.value, "Your balance is not enough");
        _to.transfer(msg.value);
        emit SendInfo(msg.sender, (msg.sender).balance);
    }

    function checkValueNow() public onlyOwner { // onlyOwner 추가
        emit MyCurrentValue(msg.sender, msg.sender.balance);
    }

    function checkUserMoney(address _to) public onlyOwner { // onlyOwner 추가
        emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
    }

}
```



