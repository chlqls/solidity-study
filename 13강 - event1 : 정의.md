# 13강 - event1 : 정의

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec13 {
    // 이벤트를 통해 값 출력 -> 이때 값들은 블록 안에 저장됨

    // 이벤트 정의 : event 이벤트명(출력하고 싶은 값들)
    event info(string name, uint256 money);

    function sendMoney() public {
        emit info("KimDaeJin", 1000);
    }
}
```

<br>

- deploy 후 `sendMoney()` 실행시켜보면 log에 info의 값이 저장됨 → 블록에 저장된 것을 알 수 있음

    <img width="1046" height="292" alt="image" src="https://github.com/user-attachments/assets/7cab86c1-b5c5-4a09-ac81-94549c75c29c" />
