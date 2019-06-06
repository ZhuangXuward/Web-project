window.onload = function () {
	var carouImg = document.getElementById("carousel_images");
	var carouWrap = document.getElementById("carousel_wrap");
	var img = carouImg.getElementsByTagName("img")[0];
	var leftArrow = document.getElementsByClassName("left-arrow")[0];
	var rightArrow = document.getElementsByClassName("right-arrow")[0];
	var oBtn = document.getElementsByClassName("dot");
	var index = 0;
	var index_length = oBtn.length;

	// 给图片添加过渡效果
	carouImg.classList.add("transition");

	// 动态获取绝对定位轮播图的高度，设置carousel_wrap的高度，宽度为整个main宽度
	// 如果mystyle.css中使用overflow:auto->含有滚动条宽度; 故使用overflow:scroll
	carouImg.style.left = -img.clientWidth + "px";
	console.log(carouImg.style.left);
	carouWrap.style.height = img.offsetHeight + "px";

	// 监听body大小变化，修改轮播图的图片位置和高度
	document.body.onresize = function () {
		carouImg.style.left = -img.clientWidth + "px";
		carouWrap.style.height = img.offsetHeight + "px";
	}

	// 点击右箭头
	rightArrow.onclick = function () {
		next_pic();
		showCurrentDot(index);
	}

	// 点击左箭头
	leftArrow.onclick = function () {
		pre_pic();
		showCurrentDot(index);
	}

	// 点击小点
	for (let i = 0; i < oBtn.length; ++i) {
		oBtn[i].onclick = function () {
			var left = parseInt(carouImg.style.left);
			var newLeft;

			// 如果没有临界判断，当图片位于“替补图片”时，点击提示点会有错乱过渡
			if (left <= (-img.clientWidth) * (index_length + 1)) {
				// 临界情况判断
				carouImg.classList.remove("transition");
				newLeft = -img.clientWidth * 1;
				carouImg.style.left = newLeft + 'px';
			}
			if (left >= -10) {
				// 临界情况判断
				carouImg.classList.remove("transition");
				newLeft = -img.clientWidth * index_length;
				carouImg.style.left = newLeft + 'px';
			}

			newLeft = (-img.clientWidth) * (i + 1);
			carouImg.style.left = newLeft + 'px';
			// 注意click事件的执行过程，要在修改完left后添加transition类
			carouImg.classList.add("transition");
			index = i;
			showCurrentDot(i);
		}
	}

	// 下一张图片
	function next_pic() {
		var left = parseInt(carouImg.style.left);
		if (left <= (-img.clientWidth) * (index_length + 1)) {
			// 临界情况判断
			carouImg.classList.remove("transition");
			var newLeft = -img.clientWidth * 1;
			carouImg.style.left = newLeft + 'px';
			newLeft = -img.clientWidth * 2;
			carouImg.classList.add("transition");
			index = 1;
		} else {
			// 一般情况
			var newLeft = parseInt(carouImg.style.left) - img.clientWidth;
			(index == (index_length - 1)) ? index = 0: index += 1;
		}
		carouImg.style.left = newLeft + 'px'; // 不要忘记添加'px'
		console.log(newLeft);
	}

	// 上一张图片
	function pre_pic() {
		var left = parseInt(carouImg.style.left);
		if (left >= -10) {
			// 临界情况判断
			carouImg.classList.remove("transition");
			var newLeft = -img.clientWidth * index_length;
			carouImg.style.left = newLeft + 'px';
			newLeft = -img.clientWidth * (index_length - 1);
			carouImg.classList.add("transition");
			index = index_length - 2;
		} else {
			// 一般情况
			var newLeft = parseInt(carouImg.style.left) + img.clientWidth;
			(index == 0) ? index = (index_length - 1): index -= 1;
		}
		carouImg.style.left = newLeft + 'px';
		console.log(newLeft);
	}

	function showCurrentDot(index) {
		for (let i = 0; i < oBtn.length; ++i) {
			(i == index) ? oBtn[i].classList.add("active"): oBtn[i].classList.remove("active");
		}
	}

	// 设置轮播定时器
	var timer = setInterval(function () {
		next_pic();
		showCurrentDot(index);
	}, 3000);

	carouWrap.onmouseover = function () {
		clearInterval(timer);
	}

	carouWrap.onmouseout = function () {
		timer = setInterval(function () {
			next_pic();
			showCurrentDot(index);
		}, 3000);
	}
}
