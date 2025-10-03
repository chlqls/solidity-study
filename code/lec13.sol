// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec13 {
    // 이벤트를 통해 값 출력 -> 이때 값들은 블록 안에 저장됨

    // 이벤트 정의 : event 이벤트명(출력하고 싶은 값들)
    event info(string name, uint256 money);

    function sendMoney() public {
        emit info("KimDaeJin", 1000);
    }
}