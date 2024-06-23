<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Joe Transport</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .modal-content {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,.5);
        }
        .modal-header {
            background-color: #007bff;
            color: #fff;
        }
        .modal-body {
            padding: 2rem;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        img.imgLogo {
    /*width: 15%;*/
    width: 10%;
    cursor: pointer;
}
.centerDiv{
    display: flex;
    justify-content: center;
}
.divRight{
    /*display: flex;
    justify-content:right;*/
    position: absolute;
    top:0;
    right:20px;
    color:white;
    font-size:15px;
    cursor: pointer;
}
.spanClass{
    font-size: 25px;
    color: whitesmoke;
    cursor: pointer;
}

    </style>
    <style>
/*loader*/
.cover-spin {
  position:fixed;
  width:100%;
  left:0;right:0;top:0;bottom:0;
  background-color: rgba(255,255,255,0.7);
  z-index:120000;

  }

  @-webkit-keyframes spin {
  from {-webkit-transform:rotate(0deg);}
  to {-webkit-transform:rotate(360deg);}
  }

  @keyframes spin {
  from {transform:rotate(0deg);}
  to {transform:rotate(360deg);}
  }
  .two_columns_75_25>.column1{
width: 100% !important;
  }
  .cover-spin::after {
  content:'';
  display:block;
  position:absolute;
  left:48%;top:40%;
  width:40px;height:40px;
  border-style:solid;
  border-color:black;
  border-top-color:transparent;
  border-width: 4px;
  border-radius:50%;
  -webkit-animation: spin .8s linear infinite;
  animation: spin .8s linear infinite;
  }
  /*loader*/
table {
  border: 1px solid #ccc;
  border-collapse: collapse;
  margin: 0;
  padding: 0;
  width: 100%;
  table-layout: fixed;
}

table caption {
  font-size: 1.5em;
  margin: .5em 0 .75em;
}

table tr {
  background-color: #f8f8f8;
  border: 1px solid #ddd;
  padding: .35em;
}

table th,
table td {
  padding: .625em;
  text-align: center;
}

table th {
  font-size: .85em;
  letter-spacing: .1em;
  text-transform: uppercase;
}


@media  screen and (max-width: 800px) {
  table {
    border: 0;
  }

  table caption {
    font-size: 1.3em;
  }

  table thead {
    border: none;
    clip: rect(0 0 0 0);
    height: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
    width: 1px;
  }

  table tr {
    border-bottom: 3px solid #ddd;
    display: block;
    margin-bottom: .625em;
  }

  table td {
    border-bottom: 1px solid #ddd;
    display: block;
    font-size: .8em;
    text-align: right;
  }

  table td::before {
    /*
    * aria-label has no advantage, it won't be read inside a table
    content: attr(aria-label);
    */
    content: attr(data-label);
    float: left;
    font-weight: bold;
    text-transform: uppercase;
  }

  table td:last-child {
    border-bottom: 0;
  }

}




@media  screen and (max-width: 4800px) {
  .mytable {
    border: 0;
  }

  .mytable caption {
    font-size: 1.3em;
  }

  .mytable thead {
    border: none;
    clip: rect(0 0 0 0);
    height: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
    width: 1px;
  }

  .mytable tr {
    border-bottom: 3px solid #ddd;
    display: block;
    margin-bottom: .625em;
  }

  .mytable td {
    border-bottom: 1px solid #ddd;
    display: block;
    font-size: .8em;
    text-align: right;
  }

  .mytable td::before {
    /*
    * aria-label has no advantage, it won't be read inside a table
    content: attr(aria-label);
    */
    content: attr(data-label);
    float: left;
    font-weight: bold;
    text-transform: uppercase;
  }

  .mytable td:last-child {
    border-bottom: 0;
  }
}













/* general styling */


</style>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
        }
        .bg-img {
            /* The image used */
            /*background-image: url('https://plus.unsplash.com/premium_photo-1661932015882-c35eee885897?q=80&w=1906&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');*/
            background-image: url('{{ asset('images/1hd.jpeg') }}');
            /* Control the height of the image */
            height: 100%;
            /* Center and scale the image nicely */
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }
       /* .centered-form {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100%;
            max-width:400px;
        }
        .max80{
            max-width: 80%;
        }
        .max60{
            max-width: 40%;
        }*/
        .max80{
            padding-top:10%;

        }
          </style>
</head>
<body>
<!-- Trigger button -->
<button type="button" class="btn btn-primary d-none" data-bs-toggle="modal" data-bs-target="#loginModal" onclick="return loginApp('noNumber')">
        Open Login Modal
    </button>

    <!-- Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="return hideModal()"></button>
                </div>
                <div class="modal-body">
                    <form class="Form_AdminLogin">
                        <div class="mb-3 loginNumber">

                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" id="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100" onclick="return Admin_login()">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="bg-img">
        <div class="">

        <span class="divRight " onclick="return loginApp('noNumber')">Sign in</span>
        <div class="centerDiv" onclick="return loginApp('+250782389359')"><img src="{{ asset('images/test.jpeg') }}" class="imgLogo"></div>
        <span onclick="return loginApp('+250782389359')" class="centerDiv spanClass d-none">Joe family</span>

            <div class="p-2">
            <div class="row">
            <div class="col-md-3  "></div>
            <div class="col-md-6 ">
            <form class="mb-4 formSearch" onsubmit="return SearchTrack()">
                <div class="input-group">
                    <input type="text" class="form-control" name="PhoneNumber" placeholder="Search Tel:+250782389359">
                    <button class="btn btn-primary" type="submit">Search</button>
                </div>
            </form>
            </div>
            <div class="col-md-3 "></div>
           </div>
            <div class="row">
            <div class="col-md-2  "></div>
            <div class="col-md-8 MainForm "></div>
            <div class="col-md-2 "></div>
           </div>
            </div>


        </div>

    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script>
function loginApp(number){
    console.log(number);
    var withNumber=`<label for="email" class="form-label ">Tel</label>
                    <input type="email" class="form-control" id="email" name="email" required>`;
    var withoutNumber=`<p class="text-center" text-align="center">Joe Family</p>
    <input type="hidden" class="form-control" id="email" name="email" value="+250782389359">
    `;
 var login=(number=='noNumber')?withNumber:withoutNumber;
    $('.loginNumber').html(login);
    $('#loginModal').modal("show");
}
function hideModal(){
    $('#loginModal').modal("hide");
}
function Admin_login(){
    $('.cover-spin').show();
    $.ajax({

url:`./api/AdminLoginEmail`,
type:'post',
data:$('.Form_AdminLogin').serialize(),
success:function(data){
if(data.status){//return data as true

    localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);

 window.location.href ="admin";
}
else{
    //console.log("false");
    $('.cover-spin').hide();
    alert("password or email are incorrect");

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}


function LoadShippingTemplate(data){
    //
//console.log(data.permission.shippingEditStatus);
 //var permission=JSON.parse(data.permission);
    /*var resultDataInterest=data.CalculateInterest;
    var resultData=data.ProductResult;
    var resultDataSpend=data.OtherSpend;*/



$('.MyRequest_table').html("");

getData="";

//console.log(data);

getData+=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Client</th>
<th scope="col">Driver</th>
<th scope="col">Plaque</th>
<th scope="col">From->To</th>
<th scope="col">C Location</th>
<th scope="col">Status</th>





</tr>
</thead>
<tbody>
`;
var resultData=data["result"];
console.log(resultData);
for(var i=0;i<resultData.length;i++){
var resultObject=resultData[i];
 getData+=`

 <tr>
  <td data-label="#"><i class="fas fa-trash text-danger mylogout " title="Delete This Product in Safari" onclick="return deleteShipping()"></i>  ${i+1}</td>
  <td data-label="Client"><p>${resultData[i].name}<p>
  <p>${resultData[i].PhoneNumber}<p>

  </td>
   <td data-label="Driver"><p>${resultData[i].driverName}<p>
  <p>${resultData[i].driverTel}<p>

  </td>
  <td data-label="PlaQue"><p>${resultData[i].numberPlate}<p>
   </td>
   <td data-label="From->To"><p>${resultData[i].origin}->${resultData[i].destination}<p>
   </td>
    <td data-label="C Location"><p>${resultData[i].liveLocation}<p>
   </td>
   <td data-label="Status"><p class="text-danger">${resultData[i].status} <i class="fas fa-eye text-primary mylogout" title="View Safari Items Load" onClick="return ViewEditStatusShipping('${btoa(JSON.stringify(resultData[i]))}')"></i><p>
   <p>${resultData[i].eta}<p>
   </td>






</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);


    //
}
    function SearchTrack(){
//console.log("hello");

$.ajax({

url:`./api/trackNumber`,
type:'get',
headers: {
"Content-Type": "application/json;charset=UTF-8",

},
data:$('.formSearch').serialize(),

success:function(data){


if(data.status){//return data as true
console.log(data);
LoadShippingTemplate(data);



}
else{
//LoadSafariStockAddItemBtnTemplate(data);






$('.MainForm').html(getData);

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
        </script>
</body>
</html>
