function showBox(boxId, title, msg) {
    pos();
    var box = document.getElementById("head_portrait_box");
    box.style.display = "block";
    box.style.left = (document.documentElement.clientWidth/2 - box.clientWidth/2) + "px";
    box.style.top = (document.documentElement.clientHeight/2 - box.clientHeight/2) + "px";
}

function hideBox() {
    hideShadow();
}

function showshadow_avatar() {
    var shadow = document.getElementById("shadow");
    shadow.style.width = "" + document.documentElement.scrollWidth + "px";
    if (document.documentElement.clientHeight > document.documentElement.scrollHeight) {
        shadow.style.height = "" + document.documentElement.clientHeight + "px";
    }
    else {
        shadow.style.height = "" + document.documentElement.scrollHeight + "px";
    }
    window.onresize = function() {
        var temp = document.documentElement.clientWidth;
        var shadow = document.getElementById("shadow");
        shadow.style.width = temp + "px";
    };
    shadow.style.display = "block";
    showBox();
}

function hideShadow_avatar() {
    var shadow = document.getElementById("shadow");
    shadow.style.display = "none";
    var showBtn = document.getElementById("head_portrait_box");
    showBtn.style.display = "none";
}

function pos() {
}

function test() {
    showshadow_avatar();
}

function onSubmit() {
    var reads = new FileReader();
    f = document.getElementById("upload_img").files[0];
    reads.readAsDataURL(f);
    reads.onload = function (e) {
        document.getElementById("Preview").src = this.result;
    }
}