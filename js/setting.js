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