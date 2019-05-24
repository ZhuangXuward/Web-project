function doCheck_SignUp() {
    var inPut = document.querySelectorAll("div#signUpContain form input");
    var password1 = document.querySelectorAll("div#signUpContain form input")[2].value;
    var password2 = document.querySelectorAll("div#signUpContain form input")[3].value;
    let flag = 0;
    for (let i = 0; i < inPut.length - 1; ++ i) {
        if (inPut[i].value == "") {
            alert("请输入 " + inPut[i].placeholder);
            flag++;
            break;
        }
    }
    if (password1 != password2) {
        alert("两次密码输入不相同！");
        flag++;
    }
    if (flag == 0) {
        alert("注册成功！");
    }
}

function doCheck_logIn() {
    var inPut = document.querySelectorAll("div#logInContain form input");
    let flag = 0;
    for (let i = 0; i < inPut.length - 1; ++i) {
        if (inPut[i].value == "") {
            alert("请输入 " + inPut[i].placeholder);
            flag++;
            break;
        }
    }
    if (flag == 0) {
        alert("登录成功！");
    }
}