//滑动按钮滑动
function toSlide(obj) {
	if (obj.lastElementChild.style.left != "12px") {
		obj.firstElementChild.style.width = "100%";
		obj.lastElementChild.style.left = "12px";
	} else {
		obj.firstElementChild.style.width = "0px";
		obj.lastElementChild.style.left = "-1px";
	}
}

//边栏判断值
var flagHOS = false;

//隐藏边栏
function hideHome() {
	document.getElementById("home").style.display = "none";
	document.getElementById("main").style.setProperty('width', '100%');
	flagHOS = true;
}

//显示边栏
function showHome() {
	document.getElementById("home").style.display = "block";
	document.getElementById("main").style.setProperty('width', '80%');
	flagHOS = false;
}

//对边栏的操作
function hideOrShow(obj) {
	toSlide(obj);
	if (flagHOS == false)
		hideHome();
	else
		showHome();
}

//上传头像
function uploadHead() {
	document.getElementById("upload_img").click();
}

//修改密码
function updatePassword() {
	var inputs = document.getElementsByClassName("password");
	for (var i = 0; i < inputs.length; i++) {
		inputs[i].style.display = "block";
	}
	var settingRow = document.getElementsByClassName("settingRow");
	for (var i = 0; i < settingRow.length; i++) {
		settingRow[i].style.display = "none";
	}
	var buttons = document.getElementsByClassName("buttons");
	for (var i = 0; i < buttons.length; i++) {
		buttons[i].style.display = "inline-block";
	}
}

function exitButton() {
	var password1 = document.getElementById("password1").value;
	var password2 = document.getElementById("password2").value;
	var password3 = document.getElementById("password3").value;
	if (password1 != "" || password2 != "" || password3 != "") {
		if (window.confirm("是否放弃此次修改")) {
			var inputs = document.getElementsByClassName("password");
			for (var i = 0; i < inputs.length; i++) {
				inputs[i].style.display = "none";
			}
			var settingRow = document.getElementsByClassName("settingRow");
			for (var i = 0; i < settingRow.length; i++) {
				settingRow[i].style.display = "block";
			}
			var buttons = document.getElementsByClassName("buttons");
			for (var i = 0; i < buttons.length; i++) {
				buttons[i].style.display = "none";
			}
			document.getElementById("password1").value = "";
			document.getElementById("password2").value = "";
			document.getElementById("password3").value = "";
		}
	}
	//没有填值直接退出
	else {
		var inputs = document.getElementsByClassName("password");
		for (var i = 0; i < inputs.length; i++) {
			inputs[i].style.display = "none";
		}
		var settingRow = document.getElementsByClassName("settingRow");
		for (var i = 0; i < settingRow.length; i++) {
			settingRow[i].style.display = "block";
		}
		var buttons = document.getElementsByClassName("buttons");
		for (var i = 0; i < buttons.length; i++) {
			buttons[i].style.display = "none";
		}
		document.getElementById("password1").value = "";
		document.getElementById("password2").value = "";
		document.getElementById("password3").value = "";
	}
}

function updateButton() {

	if (window.confirm("确定修改密码吗？")) {

		var flag1 = true;
		var flag2 = true;
		var flag3 = true;
		var password1 = document.getElementById("password1").value;
		var password2 = document.getElementById("password2").value;
		var password3 = document.getElementById("password3").value;

		if (password1 == "") {
			document.getElementById("alert1").innerHTML = "请输入原始密码";
			flag1 = false;
		} else {
			document.getElementById("alert1").innerHTML = "&nbsp;";
			flag1 = true;
		}
		if (password2 == "") {
			document.getElementById("alert2").innerHTML = "请输入新密码";
			flag2 = false;
		} else {
			document.getElementById("alert2").innerHTML = "&nbsp;";
			flag2 = true;
		}
		if (password3 == "") {
			document.getElementById("alert3").innerHTML = "请输入确认密码";
			flag3 = false;
		} else {
			document.getElementById("alert3").innerHTML = "&nbsp;";
			flag3 = true;
		}

		if (flag1 == true && flag2 == true && flag3 == true) {

			if (password1 != "<%=oldPassword%>") {
				document.getElementById("alert1").innerHTML = "密码不正确";
			} else {
				document.getElementById("alert1").innerHTML = "&nbsp;";
				if (password2 != password3)
					document.getElementById("alert2").innerHTML = "两次密码不同";
				else {
					document.getElementById("alert2").innerHTML = "&nbsp;";
					document.getElementById("alert3").innerHTML = "密码修改成功";
					//延时一秒后上传表单
					setTimeout(function () {
						document.getElementById('updateForm').submit();
					}, 1 * 1000);
				}
			}
		}
	}
}


//清除所有cookie函数
function clearAllCookie() {
	var keys = document.cookie.match(/[^ =;]+(?=\=)/g);
	if (keys) {
		for (var i = keys.length; i--;)
			document.cookie = keys[i] + '=0;expires=' + new Date(0).toUTCString()
	}
}

//退出登录
function exitLogin() {
	if (window.confirm("是否退出登录")) {
		clearAllCookie();
		window.location.href = "login.jsp";
	}
}