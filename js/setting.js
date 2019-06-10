//滑动按钮滑动
function toSlide(obj) {
	if (obj.lastElementChild.style.left != "12px") {	
	     obj.firstElementChild.style.width = "100%";
	     obj.lastElementChild.style.left = "12px";
	}

	else {
	    obj.firstElementChild.style.width = "0px";
	    obj.lastElementChild.style.left = "-1px";
	}
}

//边栏判断值
var flagHOS = false;

//隐藏边栏
function hideHome() {
	document.getElementById("home").style.display = "none";
    document.getElementById("main").style.setProperty('width','100%');
    flagHOS = true;
}

//显示边栏
function showHome() {
	document.getElementById("home").style.display = "block";
    document.getElementById("main").style.setProperty('width','80%');
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

//修改资料
function updateData() {
	window.location.href = "Data.jsp";
}

//退出登录
function exitLogin() {
	if(window.confirm("是否退出登录"))
		window.location.href = "login.jsp";
}

window.onload = function() {
	console.log(document.referrer);
}


