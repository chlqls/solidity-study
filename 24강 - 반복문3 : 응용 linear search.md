# 24강 - 반복문3 : 응용 linear search

```solidity
// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec24 {

    event CountryIndexName(uint256 indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];

    function linearSearch(string memory _search) public view returns (uint256, string memory) {

        for(uint256 i = 0; i < countryList.length; i++) {

            // solidity 내에서 string끼리 비교 불가능 -> 해시값으로 비교
            if(keccak256(bytes(countryList[i])) == keccak256(bytes(_search))) {
                return (i, countryList[i]);
            }
        }
        return (0, "Nothing");
    }
}
```

<img width="433" height="331" alt="image" src="https://github.com/user-attachments/assets/ddd63a99-87c1-4600-af3a-a92990dc362f" />

<br>

<img width="430" height="325" alt="image" src="https://github.com/user-attachments/assets/0a8d4dcb-1965-4111-919a-2c7082066c25" />
