// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Father {

    event FatherName(string name);

    function who() public virtual {
        emit FatherName("KimDaeho");
    }
}

contract Son is Father {

    event SonName(string name);

    // super: 오버라이드할 때 원래 함수 가져오기 위해 사용

    function who() public override {
        super.who();
        // emit FatherName("KimDaeho"); // -> 원래 함수 코드와 동일하다면 반복해서 쓸 필요없이 super 사용

        emit SonName("KimJin");
    }
}