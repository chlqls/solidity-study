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