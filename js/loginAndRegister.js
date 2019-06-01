

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