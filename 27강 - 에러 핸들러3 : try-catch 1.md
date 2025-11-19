# 27강 - 에러 핸들러3 : try-catch 1

- 0.6 버전 이상에서 사용 가능
- `try-catch` 왜 써야하는가?
  - 기존의 에러 핸들러 `assert`/`revert`/`require`는 에러를 발생시키고 프로그램을 끝냄
  - 그러나, `try-catch`로 에러가 났어도 프로그램을 종료시키지 않고 어떠한 대처를 하게 만들 수 있음

 <br>

## `try-catch` 특징
1. `assert`/`revert`/`require`의 위치에 따른 에러 핸들 방식  
    - `try-catch`문 안에서 `assert`/`revert`/`require`을 통해 에러가 난다면, `catch`는 에러를 잡지 못하고, 개발자가 의도한 줄 알고 정상적으로 프로그램을 끝냄
    - `try-catch`문 밖에서 `assert`/`revert`/`require`을 통해 에러가 난다면, `catch`는 에러를 잡고 에러를 해늘할 수 있음

2. 3가지 catch
  ```solidity
  catch Error(string memory reason) { ... } // revert나 require를 통해 생성된 에러를 잡기 위한 용도
  catch Panic(uint errorCode) { ... } // assert를 통해 생선된 에러를 잡기 위한 용도도
  catch(bytesmemoryLowLevelData) { ... } // 로우 레벨 에러를 잡기 위한 용도
  ```

  - Solidity에서 정의한 10가지 ErrorCode (Panic exception, 0.8.1 버전 이후)
    - 0x00: Used for generic compiler inserted panics.
    - 0x01: If you call assert with an argument that evaluates to false.
    - 0x11: If an arithmetic operation results in underflow or overflow outside of an unchecked { ... } block.
    - 0x12; If you divide or modulo by zero (e.g. 5 / 0 or 23 % 0).
    - 0x21: If you convert a value that is too big or negative into an enum type.
    - 0x22: If you access a storage byte array that is incorrectly encoded.
    - 0x31: If you call .pop() on an empty array.
    - 0x32: If you access an array, bytesN or an array slice at an out-of-bounds or negative index (i.e. x[i] where i >= x.length or i < 0).
    - 0x41: If you allocate too much memory or create an array that is too large.
    - 0x51: If you call a zero-initialized variable of internal function type.

     
3. 어디서 쓰는가?
     - 외부 스마트 컨트랙트의 함수를 부를 때: 다른 스마트 컨트랙트를 인스턴스화 해서 `try-catch`문이 있는 스마트 컨트랙트로 불러와서 사용
     - 외부 스마트 컨트랙트를 생성할 때: 다른 스마트 컨트랙트를 인스턴스화 할 때 사용
     - 스마트 컨트랙트 내에서 함수를 부를 때: `this`를 통해 `try-catch`문 사용
  
 <br>
 
## 예시 (외부 스마트 컨트랙트의 함수를 부를 때)

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract math {
        function division(uint256 _num1, uint256 _num2) public pure returns (uint256) {
            require(_num1 < 10, "num1 should not be more than 10");
            return _num1 / _num2;
        }
    }


contract runner {
    event catchErr(string _name, string _err);
    event catchPanic(string _name, uint256 _err);
    event catchLowLevelErr(string _name, bytes _err);

    math public mathInstance = new math(); // 외부 스마트 컨트랙스(math) 인스턴스화

    function playTryCatch(uint256 _num1, uint256 _num2) public returns(uint256, bool) {
        try mathInstance.division(_num1, _num2) returns(uint256 value) {
            return(value, true);
        } catch Error(string memory _err) {
            emit catchErr("revert/require", _err);
            return(0, false);
        } catch Panic(uint256 _errorCode) {
            emit catchPanic("assertError/Panic", _errorCode);
            return(0, false);
        } catch (bytes memory _errorCode) {
            emit  catchLowLevelErr("LowLevelError", _errorCode);
            return(0, false);
        }
    }
}
```

- 정상 작동
  
  <img width="770" height="302" alt="image" src="https://github.com/user-attachments/assets/f422539d-5696-4ab0-abfd-9a619170ef2a" />

- `catch Error` 작동
  
  <img width="1070" height="305" alt="image" src="https://github.com/user-attachments/assets/1b04a1fd-17e5-40b3-8d10-0ae682979553" />

- `catch Panic` 작동 (0x12 -> 10진수로 18)
  
  <img width="1047" height="296" alt="image" src="https://github.com/user-attachments/assets/1c472b71-88a5-48c3-a91f-739e8b21f301" />
