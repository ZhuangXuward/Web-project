//查看是否已经登录账号
window.onload = function() {
   if (document.cookie.length == 0) 
      window.location.href = "login.jsp";
}

//获取被选中的文本值
function getSelectText() {
   return window.getSelection ? window.getSelection().toString() :     
   document.selection.createRange().text;
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

//解决加入图片后粗体等不再编辑的bug
function solveHBI() {
   var _ebold = document.getElementById("ebold");
   if (_ebold.src.search('2') != -1) {
      document.execCommand("bold", false, null);
      ebold = true;
   }
   var _etitle = document.getElementById("etitle");
   if (_etitle.src.search('2') != -1) {
      document.execCommand("fontsize", false, 6);
      etitle = true;
   }
   var _eitalic = document.getElementById("exieti");
   if (_eitalic.src.search('2') != -1) {
      document.execCommand("italic", false, null);
      eitalic = true;
   }
   var _eunderline = document.getElementById("eunderline");
   if (_eunderline.src.search('2') != -1) {
      document.execCommand("underline", false, null);
      eunderline = true;
   }
}

//编辑div的光标问题解决

//使光标保持
function efocus() {
   var msg = document.getElementById("msg");
   msg.focus();
}

//是光标位于文本末
function elast() {
   var msg = document.getElementById("msg");
   if (window.getSelection) {//ie11 10 9 ff safari
      msg.focus(); //解决ff不获取焦点无法定位问题
      var range = window.getSelection();//创建range
      range.selectAllChildren(msg);//range 选择obj下所有子内容
      range.collapseToEnd();//光标移至最后
      }
   else if (document.selection) {//ie10 9 8 7 6 5
      var range = document.selection.createRange();//创建选择对象
       //var range = document.body.createTextRange();
      range.moveToElementText(msg);//range定位到obj
      range.collapse(false);//光标移至最后
      range.select();
   }
   solveHBI();
   solveHBI(); //必须重复
   efocus();
}

function appendixto2(obj) {
   if (obj.src.search('2') == -1)
   {
      var temp = obj.src.split('.png');
      temp[0] += "2.png";
      obj.src = temp[0];
   }
}

function removethe2(obj) {
   if (obj.src.search('2') != -1)
   {
      var temp = obj.src.split('2.png');
      temp[0] += ".png";
      obj.src = temp[0];
   }
}

//输出#话题#
function hotTopic() {
   var msg = document.getElementById("msg");
   if (msg.innerHTML.search("#输入话题#") == -1)
   { 
      var temp = msg.innerHTML;
      msg.innerHTML = "#输入话题#" + temp;
      //选中文本
      var range = document.createRange();
      var startNode = document.getElementById("msg").firstChild;
      var startOffset = 1;
      range.setStart(startNode, startOffset);
      var endOffset = 5;
      range.setEnd(startNode, endOffset);
      var selection = window.getSelection();
      selection.removeAllRanges();
      selection.addRange(range) 
   }
}

//表情包部分
//显示表情包
function showEmojis() {
   var emojis = document.getElementById("emojis");
   emojis.style.display = "block";
   efocus();
}

//隐藏表情包
function hideEmojis() {
   var emojis = document.getElementById("emojis");
   emojis.style.display = "none";
}

//向文本中插入表情
function insertEmoji(obj) {
   var temp = obj.getAttribute("id");
   var imgPath = "images/emoji/" + temp + ".png";
   document.execCommand('insertHTML', false, '<img src="' + imgPath + '" width="20px" height="20px">');
   solveHBI();
   efocus();
}

//上传图片
function uploadFile(event){
   var files = event.target.files, file;
   if (files && files.length > 0) {
      //获取目前上传的文件
      file = files[0];// 文件大小校验的动作
   }
   var URL = window.URL || window.webkitURL;
   //获取文件的路径
   var imgURL = URL.createObjectURL(file);
   var msg = document.getElementById("msg");
   msg.focus();
   document.execCommand('insertHTML', false, '<img src="' + imgURL + '" width="30%" height="auto">');
}

function picClick() {
   var uploadFiless = document.getElementById("uploadFiles");
   uploadFiless.click();  
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
   efocus();
}

//****高级编辑半部分****//

function editOut(obj) {
   var edit = document.getElementById("edit");
   if(edit.style.display != "inline-block")
   {
      removethe2(obj);
   }
}

var etitle = false;
var ebold = false;
var eitalic = false;
var eunderline = false;
//判断是否在使用该模式
function editHide(num, obj) {
   if (num == 0)
      condition = etitle;
   if (num == 1)
      condition = ebold;
   if (num == 2)
      condition = eitalic;
   if (num == 3)
      condition = eunderline;
   if (condition == false) 
      removethe2(obj);
   if (condition == true) 
      appendixto2(obj);
}

//标题字体
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
   efocus();
}

//字体加粗
function bold(obj) {
   if (ebold == false)
      ebold = true;
   else
      ebold = false;
   document.execCommand("bold", false, null);
   efocus();
}

//斜体字体
function italic(obj) {
   if (eitalic == false)
      eitalic = true;
   else
      eitalic = false;
   document.execCommand("italic", false, null);
   efocus();
}

//加下划线
function underline(obj) {
   if (eunderline == false)
      eunderline = true;
   else
      eunderline = false;
   document.execCommand("underline", false, null);
   efocus();
}


function editMode() {
   // var msg = document.getElementById("msg");
   // var temp = msg.innerHTML;
   // //编辑框有内容才可以进行
   // if (temp[0] != undefined) {
   // var selection = getSelection();
   // // 设置最后光标对象
   // var cursorPos = selection.anchorOffset;
   // console.log(msg.style.innerHTML);
   var _etitle = document.getElementById("etitle");
   if (_etitle.src.search('2') != -1) {
      document.execCommand("fontsize", false, 6);
      etitle = true;
   }

   var _ebold = document.getElementById("ebold");
   if (_ebold.src.search('2') != -1)  {
      document.execCommand("bold", false, null);
      ebold = true;
   }

   var _eitalic = document.getElementById("exieti");
   if (_eitalic.src.search('2') != -1) {
      document.execCommand("italic", false, null);
      eitalic = true;
   }

   var _ecolor = document.getElementById("ecolor");
   var color = ecolor.style.backgroundColor;
   document.execCommand("forecolor", false, color);
// }
}

function showColors() {
   var colorBar = document.getElementById("colorBar");
   colorBar.style.display = "block";
}

function colorHover(obj) {
   obj.style.opacity = "0.8";
}

function colorOut(obj) {
   obj.style.opacity = "1";
}

function colorBarHide() {
   var colorBar = document.getElementById("colorBar");
   colorBar.style.display = "none";
}

function changeColor(str) {
   var ecolor = document.getElementById("ecolor");
   ecolor.style.backgroundColor = str;
   document.execCommand("forecolor", false, str);
}

//生成链接
function linka() {
   document.execCommand("createlink", false, "输入链接");
}

//全屏模式
function quanPing() {
   //将其他div隐藏
   var home = document.getElementById("home");
   home.style.display = "none";
   var head = document.getElementById("head_portrait");
   head.style.display = "none";
   var wrap = document.getElementById("wrap");
   wrap.style.display = "none";
   var information = document.getElementById("information");
   information.style.display = "none";

   var board = document.getElementById("board");
   board.style.position = "fixed";
   board.style.Width = "100%";
   board.style.height = "95%";
   board.style.left = "15%"; 

   var huanyuan = document.getElementById("huanyuan");
   huanyuan.style.display = "inline-block";
   var quanping = document.getElementById("quanping");
   quanping.style.display = "none";

   var main = document.getElementById("main");
   main.style.overflowY = "visible";

   //调整表情包div的长宽
   var emojis = document.getElementById("emojis");
   emojis.style.height = "60px";
   emojis.style.width = "360px"
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
   board.style.left = "6%"

   var quanping = document.getElementById("quanping");
   quanping.style.display = "inline-block";
   var huanyuan = document.getElementById("huanyuan");
   huanyuan.style.display = "none";

   var main = document.getElementById("main");
   main.style.overflowY = "scroll";

   var emojis = document.getElementById("emojis");
   emojis.style.height = "85px";
   emojis.style.width = "180px"
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



















