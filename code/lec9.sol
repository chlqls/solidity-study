// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

// 생성자: 인스턴스 초기화

contract A {

    string public name;
    uint256 public age;

    constructor(string memory _name, uint256 _age) { // 생성자
        name = _name;
        age = _age;
    }

    function change(string memory _name, uint256 _age) public {
        name = _name;
        age = _age;
    }

}

contract B {

    A instance = new A("Alice", 52); // 그러나 이렇게 인스턴스 만들어서 사용하는건 많은 가스가 필요

    function change(string memory _name, uint256 _age) public {
        instance.change(_name, _age);
    }

    function get() public view returns(string memory, uint256) {
        return (instance.name(), instance.age()); // 여러 개의 리턴값 반환 가능
    }
}