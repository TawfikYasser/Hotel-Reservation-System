/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//JQuery
//$(function(){
//    $(".btn-search").click(function(event){
//        //$("#city").hide();
//    });
//});


function func(id) {
    window.location.href = "userProfile.jsp?user_Id=" + id;
}

//Js
function searchHotels() {
    var selectedCity = document.getElementById("city").value;
    if (selectedCity === "") {

    } else {
        var xmlhttp = new XMLHttpRequest();

        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                //Response
                //document.getElementById("form_group_search").innerHTML = xmlhttp.responseText;
                $(".form_group_search").html(xmlhttp.responseText);
                $("#searchResult").html("<b>Hotels Search Result</b>");
                $("#form_g_text").show();
                $(".filter_box").show();
            }
        };
        xmlhttp.open("GET", "hotelSearch?selectedCity=" + selectedCity, true);
        xmlhttp.send();
    }
}

function filterStar(stars) {
    var selectedCity = document.getElementById("city").value;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            //Response
            $(".form_group_search").html(xmlhttp.responseText);
        }
    };
    xmlhttp.open("GET", "filterStars?selectedCity=" + selectedCity + "&star=" + stars, true);
    xmlhttp.send();

}
function filterOther(value) {

    if (value === "rate") {
        var selectedCity = document.getElementById("city").value;
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                //Response
                $(".form_group_search").html(xmlhttp.responseText);
            }
        };
        xmlhttp.open("GET", "filterRate?selectedCity=" + selectedCity, true);
        xmlhttp.send();
    } else if (value === "price") {
        var selectedCity = document.getElementById("city").value;
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                //Response
                $(".form_group_search").html(xmlhttp.responseText);
            }
        };
        xmlhttp.open("GET", "filterPrice?selectedCity=" + selectedCity, true);
        xmlhttp.send();
    } else if (value === "distance") {
        var selectedCity = document.getElementById("city").value;
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                //Response
                $(".form_group_search").html(xmlhttp.responseText);
            }
        };
        xmlhttp.open("GET", "filterDistance?selectedCity=" + selectedCity, true);
        xmlhttp.send();
    }

}

function filterMeal(meal) {
    var selectedCity = document.getElementById("city").value;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            //Response
            $(".form_group_search").html(xmlhttp.responseText);
        }
    };
    xmlhttp.open("GET", "filterMeal?selectedCity=" + selectedCity + "&meal=" + meal, true);
    xmlhttp.send();


}
