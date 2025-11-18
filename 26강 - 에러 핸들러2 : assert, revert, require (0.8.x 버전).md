# 26강 - 에러 핸들러2 : assert, revert, require (0.8.x 버전)

- 0.8.0 포함 X
- 0.8.1 ~
- `assert`: 오직 내부적 에러 테스트 용도, 불변성 체크 용도
  - assert가 에러를 발생시키면, `Panic(uint256)이라는 에러타입의 에러 발생

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec26 {

    // 0.7.4 버전과 0.8.7 버전을 비교
    function assertVow() public pure {
        assert(false);
    }

}
```

- 0.7.4 버전

  <img width="718" height="394" alt="image" src="https://github.com/user-attachments/assets/b2a5304c-d9d4-46d0-90b0-85df0e2871f9" />

- 0.8.7 버전 -> gas를 환불 받음

  <img width="630" height="384" alt="image" src="https://github.com/user-attachments/assets/484cab3a-6efa-4201-b871-78be736c33eb" />
