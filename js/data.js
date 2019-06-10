function dataToEdit(obj) {
    obj.style.display = "none";
    document.getElementById('saveData').style.display = "block";
    document.getElementById('exit').style.display = "block";
    var inputs = document.getElementsByClassName("dataInput");
    for (var i = 0; i < inputs.length; i ++)
    {
        inputs[i].style.display = "inline-block";
    }
    var dataValues = document.getElementsByClassName("dataValue");
    for (var i = 0; i < dataValues.length; i ++)
    {
        dataValues[i].style.display = "none";
    }
}

function datatoShow(obj) {
    var inputs = document.getElementsByClassName("dataInput");
    for (var i = 0; i < inputs.length; i ++)
    {
        inputs[i].style.display = "none";
    }
    var dataValues = document.getElementsByClassName("dataValue");
    for (var i = 0; i < dataValues.length; i ++)
    {
        dataValues[i].style.display = "inline-block";
    }
    document.getElementById('dataEdit').style.display = "block";
    document.getElementById('saveData').style.display = "none";
    document.getElementById('exit').style.display = "none";
}

//判断是否为闰年
function isLeapYear(year) {  
    return ((0 == year % 4) && ((year % 100 != 0) || (yaer % 400 == 0))); 
}

//年份选定
function showMonth() {
    document.getElementById('sel2').removeAttribute("disabled");
    document.getElementById('sel1').setAttribute("disabled", "true");
}

//年份选定
function showDay() {
    document.getElementById('sel3').removeAttribute("disabled");
    document.getElementById('sel2').setAttribute("disabled", "true");
}

//通过日期和年份获得该年改月的总日期数 
function getDayNum(month, year) {
    if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
        return 31;
    else if (month == 2 && isLeapYear(year))
        return 29;
    else if (month == 2 && !isLeapYear(year))
        return 28;
    else
        return 30;
}

//更改前一次修改的生日
function changeBirthDay() {
    document.getElementById('sel1').value = "";
    document.getElementById('sel2').value = "";
    document.getElementById('sel3').value = "";
    document.getElementById('sel1').removeAttribute("disabled");
    document.getElementById('sel3').setAttribute("disabled", "true");
    sel1.style.display = "inline-block";
    sel2.style.display = "inline-block";
    sel3.style.display = "inline-block";
    document.getElementById("forChange").style.display = "none";
    document.getElementById("birthday_result").innerHTML = "";   
}





