# 22강 - 반복문 (for, while, do-while)

1. for

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

// for, while, do-while
contract lec22 {

    event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];


/*
    for (초깃값; 값이 얼마나 forLoop을 돌아야하는지; forLoop 한번 돌때마다 값의 변화;) {
        // forLoop 내용
    }
*/

    function forLoopEvents() public {
        for(uint256 i = 0; i < countryList.length; i++) {
            emit CountryIndexName(i, countryList[i]);
        }
    }
}
```

<img width="1845" height="825" alt="image" src="https://github.com/user-attachments/assets/07ecdd82-5a31-40d7-b117-5e4d018a0af5" />

<br>

2. while

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

// for, while, do-while
contract lec22 {

    event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];


/*
    초깃값
    
    while (값이 얼마나 whileLoop을 돌아야하는지) {
        // whileLoop 내용
        // whileLoop 한번 돌때마다 값의 변화
    }
*/

    function whileLoopEvents() public {
        uint256 i = 0;
        while(i < countryList.length) {
            emit CountryIndexName(i, countryList[i]);
            i++;
        }
    }
}
```

<br>

3. do-while

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

// for, while, do-while
contract lec22 {

    event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];


/*
    초기값
    
    do {
        // doWhileLoop 내용
    }
    while (값이 얼마나 do-while loop을 돌아야하는지)
*/

    function doWhileLoopEvenets() public {
        uint256 i = 0;
        do {
            emit CountryIndexName(i, countryList[i]);
            i++;
        }
        while(i < countryList.length);
    }
}
```

