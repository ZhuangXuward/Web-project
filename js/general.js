//隐藏指向的内容
function hideById(obj) {
   var hideObj = document.getElementById("obj");
   hideObj.style.display = "none";
}

//显示指向的内容
function showById(obj, num) {
   var showObj = document.getElementById("obj");
   if (num == 1)
      showObj.style.display = "inline-block";
   else
      showObj.style.display = "block";
}

//显示mobile模式中的shadow，并能显示相关的链接
function showShadow() {
   var shadow = document.getElementById("mobile_shadow");
   shadow.style.width = "" + document.documentElement.scrollWidth + "px";
   
   if(document.documentElement.clientHeight>document.documentElement.scrollHeight)
      shadow.style.height = "" + document.documentElement.clientHeight + "px";
   else
      shadow.style.height = "" + document.documentElement.scrollHeight + "px";
   shadow.style.display = "block";

   //隐藏三横图像
   var hideObj = document.getElementById("expand-menu");
   hideObj.style.display = "none";

   var showBox = document.getElementById("mobile_box");
   showBox.style.display = "block";
}

function hideShadow() {
   var shadow = document.getElementById("mobile_shadow");
   shadow.style.display = "none";

   var hideBox = document.getElementById("mobile_box");
   hideBox.style.display = "none";

   var showObj = document.getElementById("expand-menu");
   showObj.style.display = "inline-block";
}

window.onresize = function() {
   var temp = document.documentElement.clientWidth;
   var temp2 = document.documentElement.clientHeight;
   var shadow = document.getElementById("mobile_shadow");
   shadow.style.width = temp + "px";
   shadow.style.height = temp2 + "px";
   if (document.documentElement.clientWidth > 600) 
      hideShadow();
}