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

//生成1950年到2019年
for(var i = 2019; i >= 1950; i--) {
    var option = document.createElement('option');
    option.setAttribute('value', i);
    option.innerHTML = i;
    sel1.appendChild(option);
}
//生成1月-12月
for(var i = 1; i <= 12; i ++) {
    var option = document.createElement('option');
    option.setAttribute('value', i);
    option.innerHTML = i;
    sel2.appendChild(option);    
}
//生成1日—31日
sel2.onchange = function() {
    var dayNum = getDayNum(sel2.value, sel1.value);
    for(var i = 1; i <= dayNum; i ++) {
        var option = document.createElement('option');
        option.setAttribute('value', i);
        option.innerHTML = i;
        sel3.appendChild(option);    
    }
    showDay();
}

sel3.onchange = function() {
    document.getElementById('sel3').removeAttribute("disabled");
    document.getElementById("birthday_result").innerHTML = sel1.value + "-" + sel2.value + "-" + sel3.value;
    sel1.style.display = "none";
    sel2.style.display = "none";
    sel3.style.display = "none";
    document.getElementById("forChange").style.display = "inline-block";
    document.getElementById("birthdayPost").value = document.getElementById("birthday_result").innerHTML;
}

//设置修改资料
//通过上一个跳转过来的网页是否是setting.jsp确定
window.onload = function() {
    if (document.referrer.search("setting.jsp") != -1) 
        document.getElementById("dataEdit").click();
}

//修改用户资料
function uploadData() {
    if (window.confirm('是否进行资料修改？')) 
    { 
        var nameFlag = true;
        var emailFlag = true;
        //检查用户名是否被注册
        <%for (int i = 0; i < index; i ++) { %>
            //注意要加双引号！
            if ("<%=name_array[i]%>" == namePost.value && namePost.value != "<%=webUser%>")
            {
                alert('"'+namePost.value+'"'+"这个用户名已被注册");
                flag = false;
                namePost.value = "<%=webUser%>";
            }
        <%}%>

        //检查邮箱是否被注册
        if (nameFlag == true) {
            <%for (int i = 0; i < index; i ++) { %>
                if ("<%=email_array[i]%>" == emailPost.value && emailPost.value != "<%=email_value%>")
                {
                    alert('"'+emailPost.value+'"'+"这个邮箱已被注册");
                    flag = false;
                    emailPost.value = "<%=email_value%>";
                }
            <%}%>
        }

        if (nameFlag == true && emailFlag == true) {
            document.getElementById('dataForm').submit();  
            datatoShow();           
        }
    }
}





