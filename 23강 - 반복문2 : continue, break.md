# 23강 - 반복문2 : continue, break

 `continue`: 다음 반복문으로 이동

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec23 {

    event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];

    function useContinue() public {
        for(uint256 i = 0; i < countryList.length; i++) {
            if(i % 2 == 1) { // odds
                continue;
            }
            // index가 짝수일 때만 이벤트 출력
            emit CountryIndexName(i, countryList[i]);
        }
    }
}
```


<img width="2346" height="1059" alt="image" src="https://github.com/user-attachments/assets/8718dc1a-0b98-4b99-8e61-a65f7d4b453e" />

---

- `break`: 반복문을 끝냄

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec23 {

    event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];

    function useBreak() public {
        for(uint256 i = 0; i < countryList.length; i++) {
            if(i == 2) {
                break;
            }
            // i가 2가 되기 전까지 이벤트 출력
            emit CountryIndexName(i, countryList[i]);
        }
    }
}
```


<img width="2178" height="1078" alt="image" src="https://github.com/user-attachments/assets/8272006c-31e1-44e5-9370-0972fa505ceb" />
