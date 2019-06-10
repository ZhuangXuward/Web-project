//点击div外会隐藏emojis和colorBar
    window.onclick = function(event) {
       var target = event ? event.target : window.event.srcElement;
       if(target.id != "colorBar" && target.id != "ecolor" && target.id != "msg")
            colorBarHide();
       if(target.id != "emojis" && target.id != "xiaolian")
            hideEmojis();
    }
    function blockHover(obj) {
        obj.style.opacity = "0.9";       
        obj.lastElementChild.lastElementChild.style.display = "block";
    }

    function bolckOut(obj) {
        obj.style.opacity = "1";
        obj.lastElementChild.lastElementChild.style.display = "none";
    }
