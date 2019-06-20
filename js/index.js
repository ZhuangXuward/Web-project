//点击div外会隐藏emojis和colorBar
window.onclick = function(event) {
   var target = event ? event.target : window.event.srcElement;
   if(target.id != "colorBar" && target.id != "ecolor" && target.id != "msg")
        colorBarHide();
   if(target.id != "emojis" && target.id != "xiaolian")
        hideEmojis();
    //console.log(document.cookie);
} 

//提交博客内容
function submitMyBlog(obj) {
    if (document.getElementById('msg').innerHTML != "") {
        obj.form.cntt.value=document.getElementById('msg').innerHTML; 
        obj.form.cntt.click();
    }
    else {
        alert("未输入博客内容");
    }
}

/****************** 博客区用到的JS *****************/
//放在博客区
function blockHover(obj) {
    var temp = obj.id;
    if (!replyFlag[temp - 1]) {
        obj.style.opacity = "0.9";       
        obj.lastElementChild.lastElementChild.style.display = "block";
    }
}

//离开博客区
function bolckOut(obj) {
    var temp = obj.id;
    if (!replyFlag[temp - 1]) {
        obj.style.opacity = "1";
        obj.lastElementChild.lastElementChild.style.display = "none";
    }
}

//删除某博客，以时间为介定
function deleteBlog(obj) {
    if(window.confirm("确定删除此博客？")) {
        document.getElementById("deleteButton").value = obj.id;
        document.getElementById("deleteButton").click();
    }
}

//展开回复框
function replyShow(obj) {
    //展开的回复框之外的回复框要隐藏
    for (var i = index - 1; i >= 0; i --) {
        if (replyFlag[i - 1] == true) {
            replyClose(document.getElementById(i.toString()).children[2].lastElementChild);
        }
    }
    //显示replyText
    obj.parentNode.parentNode.previousElementSibling.style.display = "block";
    //隐藏blog_operator
    obj.parentNode.style.display = "none";
    var temp = obj.parentNode.parentNode.parentNode.id;
    replyFlag[temp - 1] = true;
}

//隐藏回复框
function replyClose(obj) {
    //显示blog_operator
    obj.parentNode.nextElementSibling.style.display = "block";
    //隐藏replyText
    obj.parentNode.style.display = "none";
    var temp = obj.parentNode.parentNode.id;
    replyFlag[temp - 1] = false;
}

//回复博客
function replyBlog(obj) {
    if (obj.parentNode.children[0].value != "") {
        //回复框的值
        document.getElementById("replyButton").value = obj.parentNode.children[0].value;
        //回复框所属的博客的日期
        document.getElementById("blogDate").value = obj.parentNode.parentNode.children[0].id; 
        document.getElementById("replyButton").click();
    }

    else {
        window.alert("尚未输入回复内容");
    }
}