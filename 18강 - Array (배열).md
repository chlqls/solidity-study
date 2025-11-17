# 18강 - Array (배열)

- Mapping과 다르게 `length`를 구할 수 있음
- 배열 안에 있는 값들을 순회할 수 있음
  - 그러나 DDoS 공격에 취약할 수 있으므로 사용 지양, `Mapping`을 더 선호
  - 악의적인 공격자가 배열을 무한반복 시키면 -> 가스 이더리움 네트워크 과부하
- 배열의 크기를 `50`으로 제한해서 사용하는 것을 권장

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec18 {

    // 배열 정의
    uint256[] public ageArray;
    uint256[10] public ageFixedSizeArray; // 배열 크기 제한
    string[] public nameArray = ["Kai", "John", "Kerri"];
    
    

    // 배열 길이 구하기
    function AgeLength() public view returns(uint256) {
        return ageArray.length;
    }

    // 배열에 값 추가 (index 0부터 시작)
    // ex) 0 -> 50 / 1 -> 70 / length: 2
    function AgePush(uint256 _age) public {
        ageArray.push(_age);
    }

    // 배열 범위 밖의 index 값 입력하면 에러 발생
    // 1 -> 70
    function AgeGet(uint256 _index) public view returns(uint256) {
        return ageArray[_index];
    }

    // pop하면 가장 최신의 값이 삭제됨
    // 0 -> 50 / length: 1
    function AgePop() public {
        ageArray.pop();
    }

    // 원하는 index의 값 삭제
    // ex) index로 0을 입력하면 완전히 삭제되는 것이 아닌 default 값인 0으로 채워짐, length도 그대로
    // 0 -> 0 / 1 -> 70 / length: 2
    function AgeDelete(uint256 _index) public {
        delete ageArray[_index];
    }
    
    // 0 -> 90 / 1 -> 70 / length: 2
    function AgeChange(uint256 _index, uint256 _age) public {
        ageArray[_index] = _age;
    }
}
```

<img width="263" height="476" alt="image" src="https://github.com/user-attachments/assets/9838d21a-7517-457d-ab99-fd499c55563b" />
