# 19강 - Mapping(맵핑) 과 Array(배열) 주의할 점

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

// Length X
contract lec19 {

    uint256 num = 89;
    mapping(uint256 => uint256) numMap;
    uint256[] numArray;

    function changeNum(uint256 _num) public {
        num = _num;
    }

    function showNum() public view returns(uint256) {
        return num;
    }

    function numMapped() public {
        numMap[0] = num;
    }

    function showNumMap() public view returns(uint256) {
        return numMap[0];
    }

    function numArrayAdd() public {
        numArray.push(num);
    }

    function showNumArray() public view returns(uint256) {
        return numArray[0];
    }

    function updateArray() public {
        numArray[0] = num;
    }

}
```


<img width="242" height="332" alt="image" src="https://github.com/user-attachments/assets/9e00e61d-00cc-478a-a3ea-11b6ccd6cf68" />

- num을 99로 바꾼 후 Map과 Array를 확인했을 때 99가 아니고 여전히 89
  - num을 reference로 저장하는 것이 아니라 그 당시의 값을 캡쳐해서 그 값만 저장
  - `numMapped`나 `updateArray()`를 통해 값을 업데이트 해줘야 함
 
  
