# 15강 - 상속4 : super

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father {

    event FatherName(string name);

    function who() public virtual {
        emit FatherName("KimDaeho");
    }
}

contract Son is Father {

    event SonName(string name);

    // super: 오버라이드할 때 원래 함수 가져오기 위해 사용

    function who() public override {
        super.who();
        // emit FatherName("KimDaeho"); // -> 원래 함수 코드와 동일하다면 반복해서 쓸 필요없이 super 사용

        emit SonName("KimJin");
    }
}
```

<br>

- Son 컨트랙 배포 후 `who()` 실행시키면 `FatherName`과 `SonName` 두개의 이벤트가 출력된 것을 확인 가능

  <img width="2177" height="585" alt="image" src="https://github.com/user-attachments/assets/2ada2001-92bb-4ec2-8c3f-09de0dfa2760" />
