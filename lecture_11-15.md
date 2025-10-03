# 11강 - 상속2 : overriding 오버라이딩

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father {
    string public familyName = "Kim";
    string public givenName = "Jung";
    uint256 public money = 100;

    constructor(string memory _givenName) { // 생성자
        givenName = _givenName;
    }

    function getFamilyName() view public returns(string memory) {
        return familyName;
    }

    function getGivenName() view public returns(string memory) {
        return givenName;
    }

    function getMoney() view public virtual returns(uint256) { // 부모 컨트랙에서 오버라이딩 할 함수에 'virtual' 추가 (접근제어자 앞뒤에 사용 가능)
        return money;
    }
}

//contract Son is Father("James") { // 상속받는 방법 : is
contract Son is Father {

    constructor() Father("James") { // 부모 컨트랙의 생성자를 이용해서 상속 받는 또 다른 방법
    }

    uint256 public earning = 0;
    
    function work() public {
        earning += 100;
    }

    // 오버라이딩 -> 쉽게 생각하면 덮어 씌우기
    function getMoney() view override public returns(uint256) { // 자식 컨트랙에서 오버라이딩 할 함수에 'override' 추가
        return money + earning;
    }
}

```

<br>

# 12강 - 상속3 : 두개 이상 상속하기

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father {
    uint256 public fatherMoney = 100;
    function getFatherName() public pure returns (string memory) {
        return "KimJung";
    }

    function getMoney() public view virtual returns(uint256) {
        return fatherMoney;
    }
}

contract Mother {
    uint256 public motherMoney = 500;
    function getMotherName() public pure returns (string memory) {
        return "LeeSol";
    }

    function getMoney() public view virtual  returns(uint256) {
        return motherMoney;
    }
}

contract Son is Father, Mother { // 두개 이상의 컨트랙 상속 받기

    // 두개의 부모 컨트랙에 같은 이름의 함수가 있으면 꼭 override 해야함
    function getMoney() public view override(Father, Mother) returns(uint256) { //override() -> 괄호 안에 상속 받는 부모 컨트랙 모두 쓰기
        return fatherMoney + motherMoney;
    }

}
```

<br>

# 13강 event1 : 정의

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

<br>

# 14강 - event2 : indexed

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec14 {

    //indexed : event 내에서만 사용 가능한 키워드, 특정한 이벤트의 값들을 들고올 때 사용

    event numberTracker(uint256 num, string str);
    event numberTracker2(uint256 indexed num, string str); // indexed

    uint256 num = 0;
    function PushEvent(string memory _str) public {
        emit numberTracker(num, _str);
        emit numberTracker2(num, _str);
        num++;
    }
}
```

<br>

- 강의에서는 vscode로 넘어가서 Truffle, ganache 사용해서 실습

    <img width="2360" height="1323" alt="image" src="https://github.com/user-attachments/assets/767ee26e-125c-4dd9-a5f6-d0e28d1e790c" />

    

<br>

- `getPastEvents`: numberTracker2의 첫번째 블록부터 최신 블록 중에 num이 1이나 2인 이벤트를 가지고 오는 함수

    ```solidity
      // App.js 코드 일부
      async function getEvent (){
        let events = await lecture14.getPastEvents('numberTracker2',{ filter:{num:[2,1]},fromBlock: 1, toBlock:'latest'});
        console.log(events)
    
        let events2 = await lecture14.getPastEvents('numberTracker',{ filter:{num:[2,1]},fromBlock: 1, toBlock:'latest'});
        console.log(events2)
      } 
    ```
    <img width="2000" height="1097" alt="image" src="https://github.com/user-attachments/assets/7a8d333a-efad-4fc3-a8e8-9de754776753" />


<br>

- 결과
    - numberTracker의 `getPastEvents` 는 num에 `indexed` 가 없기 때문에 filter 해도 적용이 안되고 모든 이벤트가 출력됨
    - 반대로, numberTracker2의 `getPastEvents` 는 num에 `indexed` 가 있기 때문에 filter가 적용되어 num이 1 또는 2인 이벤트만 출력됨

      <img width="2336" height="1319" alt="image" src="https://github.com/user-attachments/assets/babef82f-7a1c-445f-90b8-c31504abb189" />

<br>

# 15강 상속4 : super

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
