function blockHover(obj) {
    obj.style.opacity = "0.9";       
    obj.lastElementChild.lastElementChild.style.display = "block";
}

function bolckOut(obj) {
    obj.style.opacity = "1";
    obj.lastElementChild.lastElementChild.style.display = "none";
}
