// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec14 {

    //indexed : event 내에서만 사용 가능한 키워드, 특정한 이벤트의 값들을 들고올 때 사용

    event numberTracker(uint256 num, string str);
    event numberTracker2(uint256 indexed num, string str); // indexed

    uint256 num = 0;
    function PushEvent(string memory _str) public {
        emit numberTracker(num, _str);
        emit numberTracker2(num, _str);
        num++;
    }
}