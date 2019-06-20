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

function showshadow() {
    var shadow = document.getElementById("shadow");
    shadow.style.width = "" + document.documentElement.scrollWidth + "px";
    if (document.documentElement.clientHeight > document.documentElement.scrollHeight) {
        shadow.style.height = "" + document.documentElement.clientHeight + "px";
    }
    else {
        shadow.style.height = "" + document.documentElement.scrollHeight + "px";
    }
    shadow.style.display = "block";
    showBox();
}

function hideShadow() {
    var shadow = document.getElementById("shadow");
    shadow.style.display = "none";
    var showBtn = document.getElementById("head_portrait_box");
    showBtn.style.display = "none";
}

function pos() {
}

function test() {
    showshadow();
}

function handleImageFile(file) {
	var previewArea = document.getElementById("upload_img");
	var img = document.createElement("img");
	var fileInput = document.getElementById("myFile");
	var file = fileInput.files[0];
	img.file = file;
	previewArea.appendChild(img);
	
	var reader = new FileReader();
	reader.onload = (function(aImg) {
		return function(e) {
			aImg.src = e.target.result;
		}
	})(img);
	reader.readAsDataURL(file);
}

function onSubmit() {
    var reads = new FileReader();
    f = document.getElementById("upload_img").files[0];
    reads.readAsDataURL(f);
    reads.onload = function (e) {
        document.getElementById("Preview").src = this.result;
    }
}