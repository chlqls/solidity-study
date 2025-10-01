# 6강 - function3 : view와 pure

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec6 {
    /*
    function 이름 () public { // (public, private, internal, external) 변경 가능
        // 내용
    }
    */

    // function get_a() external view returns (uint256) // view와 pure는 접근제어자 앞뒤에 사용 가능

    /*
    - view: function 밖의 변수들을 읽을 수 있으나 변경 불가능
    - pure: function 밖의 변수들을 읽지 못하고, 변경도 불가능
    - view와 pure 둘 다 명시 안 할 때: function 밖의 변수들을 읽어서 변경 가능
    */

    // 1. view
    uint256 public a = 1;

    function read_a() public view returns(uint256) {
        return a + 2;
    }

    // 2. pure
    function read_a2() public pure returns(uint256) {
        uint256 b = 1;
        return 4 + 2 + b;
    }

    // 3. pure, view 둘 다 사용 X
    function read_a3() public returns(uint256) {
        a = 13;
        return a;
    }
}
```

<br>

# 7강 function4 : 4개의 저장영역과 String

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec7 {

    /*
    솔리디티의 4가지 저장영역
    1. storage: 대부분의 변수(함수 밖), 함수들이 저장되며, 영속적으로 저장이 되어 가스 비용이 비쌈
    2. memory: 함수의 파라미터, 리턴값, 레퍼런스 타입이 주로 저장됨(+ 함수 내에서 정의된 변수), 
               그러나 storage처럼 영속적이지 않고, 함수 내에서만 유효하기에 storage보다 가스 비용 저렴
    3. Calldata: 주로 external function의 파라미터에서 사용됨
    4. stack: EVM(Ethereum Virtual Machine)에서 stack data를 관리할 때 사용하는 영역, 1024Mb 제한적
    */

    // function -string.
    function get_string(string memory _str) public pure returns(string memory) { // string이 파라미터나 리턴값에 올 때 memory 지정해줘야 함
        return _str;
    }

    function get_uint(uint256 _ui) public pure returns(uint256) {
        return _ui;
    }
}

```

<br>

# 8강 - instance1 : 정의

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract A {

    uint256 public a = 5;

    function change(uint256 _value) public {
        a = _value;
    }

}

contract B {

    A instance1 = new A(); // A의 분신을 만든거나 마찬가지. -> 컨트랙 B에서 a 값 변경해도 실제로 컨트랙 A에서 a 값은 바뀌지 않음.

    function get_A() public view returns(uint256) {
        return instance1.a(); // 인스턴스의 변수에 접근할 때에서 () 괄호 써주기
    }
    function change_A(uint256 _value) public {
        instance1.change(_value);
    }

}
```

<br>

# 9강 - instance2 : constructor

```solidity
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
```

<br>

# 10강 - 상속1 : 정의

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

    function getMoney() view public returns(uint256) {
        return money;
    }
}

contract Son is Father("James") { // 상속받는 방법 : is
    // Father 컨트랙에서 정의된 변수와 함수 접근 가능

}
```
