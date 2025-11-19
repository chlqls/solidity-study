# 28강 - 에러 핸들러4 : try-catch 2

3. 어디서 쓰는가?
     - 외부 스마트 컨트랙트의 함수를 부를 때: 다른 스마트 컨트랙트를 인스턴스화 해서 `try-catch`문이 있는 스마트 컨트랙트로 불러와서 사용
     - 외부 스마트 컨트랙트를 생성할 때: 다른 스마트 컨트랙트를 인스턴스화 할 때 사용
     - 스마트 컨트랙트 내에서 함수를 부를 때: `this`를 통해 `try-catch`문 사용

<br>


```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;


// 외부 스마트 컨트랙트를 생성할 때
contract character {

    string private name;
    uint256 private power;

    constructor(string memory _name, uint256 _power) {
        // revert("error"); // catch로 핸들링되는 에러
        name = _name;
        power = _power;
    }

}

contract runner {

    event catchOnly(string _name, string _err);

    function playTryCatch(string memory _name, uint256 _power) public returns(bool successOrFail) {
        try new character(_name, _power) {
            // revert("errors in the try-catch block"); // try문 안에 있기 때문에 catch로 잡히지 않고 바로 에러 발생하여 프로그램 중단시킴
            return(true);
        } catch {
            emit catchOnly("catch", "Errors!!");
            return(false);
        }
    }
}

// 스마트 컨트랙트 내에서 함수를 부를 때
contract runner2 {
    event catchOnly(string _name, string _err);

    function simple() public returns(uint256) {
        return 4;
    }
    
    function playTryCatch() public returns(uint256, bool) {

        try this.simple() returns(uint256 _value) {
            return(_value, true);
        } catch {
            emit catchOnly("catch", "Errors!!");
            return(0, false);
        }
    }
}
```
