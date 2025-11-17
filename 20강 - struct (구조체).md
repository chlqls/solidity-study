# 20강 - struct (구조체)

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec20 {

    struct Character {
        uint256 age;
        string name;
        string job;
    }

    mapping(uint256=>Character) public CharacterMapping;
    Character[] public CharacterArray;


    function createCharacter(uint256 _age, string memory _name, string memory _job) pure public returns (Character memory) {
        return Character(_age, _name, _job);
    }

    // Mapping에 구조체 저장
    function createCharacterMapping(uint256 _key, uint256 _age, string memory _name, string memory _job) public {
        CharacterMapping[_key] = Character(_age, _name, _job);
    }

    function getCharacterMapping(uint256 _key) public view returns (Character memory) {
        return CharacterMapping[_key];
    }

    // Array에 구조체 저장
    function createCharacterArray(uint256 _age, string memory _name, string memory _job) public {
        CharacterArray.push(Character(_age, _name, _job));
    }

    function getCharacterArray(uint256 _index) public view returns (Character memory) {
        return CharacterArray[_index];
    }

}
```


- Mapping에 구조체 저장 및 조회

  <img width="277" height="451" alt="image" src="https://github.com/user-attachments/assets/8ad420a0-7ed5-469a-9852-38aa3172a61c" />

- Array에 구조체 저장 및 조회

  <img width="285" height="435" alt="image" src="https://github.com/user-attachments/assets/b2d8d3e3-0490-48c6-b88f-13405dd817f0" />
