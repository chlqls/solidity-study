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
