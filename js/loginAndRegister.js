// 检测按键：enter
window.onload = function () {
    var confirm = document.getElementById("confirm");
    document.addEventListener("keydown", keydown);
    //键盘监听，注意：在非ie浏览器和非ie内核的浏览器
    //参数1：表示事件，keydown:键盘向下按；参数2：表示要触发的事件
    function keydown(event) {
        //表示键盘监听所触发的事件，同时传递参数event
        switch (event.keyCode) {
            case 13: //enter
                confirm.click();
                break;
        }
    }
}


//注册检查函数：验证是否输入完全，两次输入的密码是否相同。
function doCheck_Register() {
    var inPut = document.querySelectorAll("div#signUpContain form input");
    let flag = 0;
    for (let i = 0; i < inPut.length - 1; ++i) {
        if (inPut[i].value == "") {
            alert("请输入 " + inPut[i].placeholder);
            document.querySelectorAll("div#signUpContain form input")[i].focus();
            flag++;
            break;
        }
    }
    var pass1 = document.querySelector("div#signUpContain form input#password");
    var pass2 = document.querySelector("div#signUpContain form input#password2");
    if(flag == 0) {
        if (pass1.value != pass2.value) {
            alert("两次密码不相同！")
            document.querySelector("div#signUpContain form input#password2").focus();
            flag++;
        }
    }

    if (flag == 0) {
        formRegister.submit();
    }
    return false;
}

//登录检查函数：验证是否输入，否则提示输入。
function doCheck_logIn() {
    var inPut = document.querySelectorAll("div#logInContain form input");
    let flag = 0;
    for (let i = 0; i < inPut.length - 1; ++i) {
        if (inPut[i].value == "") {
            alert("请输入 " + inPut[i].placeholder);
            document.querySelectorAll("div#logInContain form input")[i].focus();
            flag++;
            break;
        }
    }
    if (flag == 0) {
        formLogin.submit();
    }
    return false;
}