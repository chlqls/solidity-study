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
