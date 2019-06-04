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

/********************关于编辑文本的JS************************/
function appendixto2(obj) {
   if (obj.src.search('2') == -1)
   {
      var temp = obj.src.split('.');
      temp[0] += "2.png";
      obj.src = temp[0];
   }
}

function removethe2(obj) {
   if (obj.src.search('2') != -1)
   {
      var temp = obj.src.split('2');
      temp[0] += ".png";
      obj.src = temp[0];
   }
}

//高级编辑
function topEdit() {
   var edit = document.getElementById("edit");
   if (edit.style.display == "inline-block")
   {   
      edit.style.display = "none";
   }
   else {
      edit.style.display = "inline-block";
   }
   var colorBar = document.getElementById("colorBar");
   colorBar.style.display = "none";
}

var emsg = document.getElementById("msg");

function editOut(obj) {
   var edit = document.getElementById("edit");
   if(edit.style.display != "inline-block")
   {
      removethe2(obj);
   }
}

//全屏模式
function quanPing() {
   var home = document.getElementById("home");
   home.style.display = "none";
   var wrap = document.getElementById("wrap");
   wrap.style.display = "none";
   var information = document.getElementById("information");
   information.style.display = "none";

   var board = document.getElementById("board");
   board.style.position = "fixed";
   board.style.width = "100%";
   board.style.height = "100%"; 

   var huanyuan = document.getElementById("huanyuan");
   huanyuan.style.display = "inline-block";
   var quanping = document.getElementById("quanping");
   quanping.style.display = "none";
}

//全屏还原
function huanYuan() {
   var home = document.getElementById("home");
   home.style.display = "block";
   var wrap = document.getElementById("wrap");
   wrap.style.display = "block";
   var information = document.getElementById("information");
   information.style.display = "block";

   var board = document.getElementById("board");
   board.style.position = "relative";
   board.style.width = "70%";
   board.style.height = "200px";

   var quanping = document.getElementById("quanping");
   quanping.style.display = "inline-block";
   var huanyuan = document.getElementById("huanyuan");
   huanyuan.style.display = "none";
}

var etitle = false;
var ebold = false;
var eitalic = false;
//判断是否在使用该模式
function editHide(num, obj) {
   if (num == 0)
      condition = etitle;
   if (num == 1)
      condition = ebold;
   if (num == 2)
      condition = eitalic;
   if (condition == false) 
      removethe2(obj);
   if (condition == true) 
      appendixto2(obj);
}

//字体加粗

function Title(obj) {
   if (etitle == false)
   {
      etitle = true;
      document.execCommand("fontsize", false, 6);
   }
   else
   {
      etitle = false;
      document.execCommand("fontsize", false, 4);
   }
}

function bold(obj) {
   if (ebold == false)
      ebold = true;
   else
      ebold = false;
   document.execCommand("bold", false, null);
}

function italic(obj) {
   if (eitalic == false)
      eitalic = true;
   else
      eitalic = false;
   document.execCommand("italic", false, null);
   document.execCommand("forecolor", false, "green");

}

function linka() {
   document.execCommand("createlink", false, "#");
}

function showColors() {
   var colorBar = document.getElementById("colorBar");
   colorBar.style.display = "block";
}

function colorHover(obj) {
   obj.style.opacity = "0.8";
}

function colorBarHide() {
   var colorBar = document.getElementById("colorBar");
   colorBar.style.display = "none";
}

function colorOut(obj) {
   obj.style.opacity = "1";
}

function changeColor(str) {
   var ecolor = document.getElementById("ecolor");
   ecolor.style.backgroundColor = str;
   colorBarHide();
}

function editMode() {
   var ecolor = document.getElementById("ecolor").style.backgroundColor;
   //document.execCommand("forecolor", false, "green");
   //console.log(document.execCommand("forecolor", false, "green"));

   var etitle = document.getElementById("etitle");
   if (etitle.src.search('2') != -1) 
      document.execCommand("fontsize", false, 6);

   var ebold = document.getElementById("ebold");
   if (ebold.src.search('2') != -1) 
      document.execCommand("bold", false, null);

   var eitalic = document.getElementById("exieti");
   if (eitalic.src.search('2') != -1) 
      document.execCommand("italic", false, null);
}


/******************跟随鼠标移动的提示框************************/
/*var tip={
   $: function(ele){ 
   if(typeof(ele) == "object") 
      return ele; 
   else if(typeof(ele) == "string" || typeof(ele) == "number") 
      return document.getElementById(ele.toString()); 
      return null; 
   }, 

   mousePos: function(e){ 
      var x, y; 
      var e = e || window.event; 
      return { x : e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft,
         y : e.clientY + document.body.scrollTop + document.documentElement.scrollTop }; 
   }, 

   start:function(obj){ 
      var self = this; 
      var t = self.$("mjs:tip"); 
      obj.onmousemove = function(e) { 

         var mouse = self.mousePos(e);   
         t.style.left = mouse.x + 10 + 'px'; 
         t.style.top = mouse.y + 10 + 'px'; 
         t.innerHTML = obj.getAttribute("tips"); 
         t.style.display = ''; 
      }; 
      obj.onmouseout = function(){ 
         t.style.display = 'none'; 
      }; 
   } 
}*/



















