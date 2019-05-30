//进行轮播
window.onload = function() {
	var pic = document.querySelectorAll(".carousel_content")[0];
	var picOuter = document.getElementsByClassName('carousel_outer')[0];
	var next = document.getElementsByClassName("rightArrow")[0];
	var pre = document.getElementsByClassName("leftArrow")[0];
	var Obtn = document.getElementsByClassName("navDot");
	var Width = pic.offsetWidth;
	var Width3 = Width * 3;
	console.log(Width);
	var current = 0; 
	// 记录当前图片

	pic.style.left = 0;

	// 开始计时器
	var playCarousel = setInterval(move, 2000);
	buttonRed();
	// 鼠标移入移出，停止和开始自动轮播。 注意onmouseover不大写
	picOuter.onmouseover = function() {	
		clearInterval(playCarousel);
	}
	picOuter.onmouseout = function() {
		playCarousel = setInterval(move, 2000);
		// 注意添加定时器名字，否则会出错，开启多个定时器
	}

	function buttonRed() {
		for (let j = 0; j < Obtn.length; ++ j) {
			Obtn[j].classList.remove("navDotRed");
            //Obtn[j].style.backgroundColor = red;
		}
		let currentIndex = (- parseInt(pic.style.left)) / Width;
		Obtn[parseInt(currentIndex % Obtn.length)].classList.add("navDotRed");
	}

	// 自动轮播函数
	function move() {
		if (parseInt(pic.style.left) > Width3) {
			pic.classList.add("tranSition");   	
			var newLeft = parseInt(pic.style.left) - Width;
			pic.style.left = newLeft + 'px';
			// 这一步很重要，left本身为字符串
			console.log(pic.style.left);
				console.log(Width);
		}
		else {
			pic.classList.remove("tranSition");
			var newLeft = 0;
			pic.style.left = newLeft + 'px';
			// 这一步很重要，left本身为字符串
			console.log(pic.style.left);
		}
		buttonRed();
	}

	// 点击next箭头
	next.onclick = function () {
		pic.classList.remove("tranSition");   	
		if (parseInt(pic.style.left) > Width3) {
			var newLeft = parseInt(pic.style.left) - Width;
			pic.style.left = newLeft + 'px';
			console.log(pic.style.left);
		}
		else {
			var newLeft = Width;
			pic.style.left = newLeft + 'px';
			console.log(pic.style.left);
		}
		buttonRed();
	}

	// 点击pre箭头
	pre.onclick = function () {
		pic.classList.remove("tranSition");   	
		if (parseInt(pic.style.left) < 0) {
			var newLeft = parseInt(pic.style.left) + Width;
			pic.style.left = newLeft + 'px';
			console.log(pic.style.left);
		}
		else if (parseInt(pic.style.left) == 0) {
			var newLeft = Width * 2;
			pic.style.left = newLeft + 'px';
			console.log(pic.style.left);
		}
		buttonRed();
	}



	function setLeft(whichpic) {
		var newLeft = Width * (whichpic - 1);
		pic.style.left = newLeft + 'px';
		console.log(pic.style.left);
		buttonRed();
	}

    for (let k = 0; k < Obtn.length; ++ k) {
        Obtn[k].addEventListener("click", function() {
            pic.classList.remove("tranSition");     
            var newLeft = - (Width) * k;
            pic.style.left = newLeft + 'px';
            // if (parseInt(pic.style.left) > -2325) {
            //     var newLeft = parseInt(pic.style.left) - 775;
            //     pic.style.left = newLeft + 'px';
            //     console.log(pic.style.left);
            // }
            // else {
            //     var newLeft = -775;
            //     pic.style.left = newLeft + 'px';
            //     console.log(pic.style.left);
            // }
            buttonRed();
        });
    }
}