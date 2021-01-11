/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function searchHotels() {
    var x = document.getElementById("city").value;
    if (x === "") {

    } else {
        var xmlhttp = new XMLHttpRequest();

        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                //Response
                document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
            }
        };
        xmlhttp.open("GET", "hotelSearch?sc=" + x, true);
        xmlhttp.send();
    }

}

