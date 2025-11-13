# 17강 - Mapping(맵핑)
- Key와 Value로 이루어짐 -> `length` 구할 수 없음
- Key 값을 입력하면 대응되는 Value 값을 반환받음
  
### 예시 1
```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec17 {
    mapping(uint256=>uint256) private ageList;

    function setAgeList(uint256 _index, uint256 _age) public {
        ageList[_index] = _age;
    }

    function getAge(uint256 _index) public view returns(uint256) {
        return ageList[_index];
    }
}

```

- `setAgeList`로 (key, value) 값을 `(3, 21)`로 입력하고, `getAgeList`에 `3`을 넣으면 `21`이 나오는 것을 확인

  <img width="262" height="310" alt="image" src="https://github.com/user-attachments/assets/3d375fc7-2a8b-4bbd-aa65-d89fe5fc7672" />

- `getAgeList`에 `2`를 넣으면 `0`, 즉 null이 나옴

  <img width="252" height="308" alt="image" src="https://github.com/user-attachments/assets/e0a4dfb3-985f-4397-83b1-56721ad07d4a" />

<br>

### 예시 2 : 다양한 데이터타입 사용

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

// Length X
contract lec17 {
    mapping(uint256=>uint256) private ageList;
    mapping(string=>uint256) private priceList;
    mapping(uint256=>string) private nameList;
    

    function setAgeList(uint256 _index, uint256 _age) public {
        ageList[_index] = _age;
    }

    function getAge(uint256 _index) public view returns(uint256) {
        return ageList[_index];
    }

    function setNameList(uint256 _index, string memory _name) public {
        nameList[_index] = _name;
    }

    function getName(uint256 _index) public view returns(string memory) {
        return nameList[_index];
    }

    function setPriceList(string memory _itemName, uint256 _price) public {
        priceList[_itemName] = _price;
    }

    function getPriceList(string memory _index) public view returns(uint256) {
        return priceList[_index];
    }
}
```

- `setNameList`로 `(2, Kim)`을 입력하고, `getName`에 `2`을 넣으면 `Kim`이 나오는 것을 확인

  <img width="256" height="454" alt="image" src="https://github.com/user-attachments/assets/3ceccf34-102a-4e70-90e4-cff0e893e59b" />

- `setPriceList`로 `(mouse, 10000)`을 입력하고, `getPriceList`에 `mouse`을 넣으면 `10000`이 나오는 것을 확인

  <img width="258" height="479" alt="image" src="https://github.com/user-attachments/assets/08733aac-3346-4acb-a644-5e66a475aafb" />
