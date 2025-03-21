<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Dashboard.</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no" />
    <meta name="description" content="This is an example dashboard created using build-in elements and components.">
    <meta name="msapplication-tap-highlight" content="no">

<!--Menu Css-->
<style>
      @media only screen and (min-width: 1024px) {
    .customizeContainer{
        padding-right:15% !important;
        padding-left:15% !important;
    }
}
span.Formchange {
    /* width: 200px; */
    padding-top: 10px;
    padding-left: 2px;
    padding-right: 5px;
    outline: 0;
    border-bottom: 2px dashed #e0e0e0;
    /* border-width: 0 0 20px; */
    border-color: blue;
}
.Count_table{
    display: none;
}
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
/*Navigation Menu */

.sidenav {
        height: 100%;
        width: 0;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color:#0b1419f5;

        overflow-x: hidden;
        transition: 0.5s;
        padding-top: 60px;
      }

      .sidenav a {
        padding: 8px 8px 8px 32px;
        text-decoration: none;
        font-family: 'Poppins', sans-serif;
        font-weight: 600;
        font-size: 14px;
        letter-spacing: 0.06em;
        color:#fff8f8c7;
        display: block;
        transition: 0.3s;
      }



      .sidenav a:hover {
        color: #f1f1f1;
      }

      .sidenav .closebtn {
        position: absolute;
        top: 0;
        right: 25px;
        font-size: 36px;
        margin-left: 50px;
      }
      @media screen and (max-height: 450px) {
        .sidenav {padding-top: 15px;}
        .sidenav a {font-size: 18px;}
      }
      @media only screen and (max-width : 785px) {
            .mob-logo,.sidenav{
                display: block !important;
            }
          .mob-logo{
              position: absolute;
              top: 5px;
              left:20px;
              z-index: 999999;
          }
            .logo.mymoblogo {
        position: absolute;
        top: 5px;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    ul.menu-ul-center{
        display: none;
    }

        }
    /*navigation*/

</style>
<!--Menu Css-->
<!--style table -->
<style>

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


@media screen and (max-width: 800px) {
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




@media screen and (max-width: 4800px) {
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
<!--style table -->
<!--header-->
@include('components.header.header')
<!--header-->
<!--navigation Mobile-->

<div class="cover-spin"></div>
<span  style="font-size:30px;cursor:pointer" onclick="openNav()" class="mob-logo text-dark">&#9776; </span>
     <div id="mySidenav" class="sidenav" >
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>

            <div class="app-sidebar sidebar-shadow bg-vicious-stance sidebar-text-light">

<div class="app-sidebar__inner">
                        <ul class="vertical-nav-menu metismenu">


      <!--Capturing Taxation-->
      <li class="app-sidebar__heading">Sales</li>
                            <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-rocket"></i>Sales Data
                                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                </a>
                            </li>
                                <ul class="mm-collapse mm-show" style="">
                                    <li>
                                        <a href="#View All Products" onclick="return CaptureData()" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Capture Sales
                                        </a>
                                    </li>

                                    <li>
                                        <a  href="#ViewCard" aria-expanded="false"  onclick="return viewDataSales()">
                                            <i class="metismenu-icon"></i>Sales
                                        </a>
                                    </li>


                                    </ul>
                                    <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-graph2"></i>Report Sales
                                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                </a>
                            </li>

                         <!--Capturing Sales-->

                           <!--Reports Taxation-->
                           <ul class="mm-collapse mm-show" style="">
                                    <li>
                                        <a href="#View All Products" onclick="return TaxReportTotal()" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Report
                                        </a>
                                    </li>




                            </ul>
                            <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-rocket"></i>Sales Data

                                </a>
                            </li>
                         <!--Reports Taxation-->

                        <!--Create Taxation-->

                            <li class="app-sidebar__heading">Add Taxation</li>
                            <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-rocket"></i>Category
                                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                </a>
                            </li>
                                <ul class="mm-collapse mm-show" style="">
                                    <li>
                                        <a href="#Add Category" onclick="return CategoryForm()" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Add Category
                                        </a>
                                    </li>

                                    <li>
                                        <a  href="#ViewCard" aria-expanded="false"  onclick="return ViewTaxCategory()">
                                            <i class="metismenu-icon"></i>View Category
                                        </a>
                                    </li>


                                    </ul>
                                    <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-rocket"></i>Products
                                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                </a>
                            </li>
                         <!--Capturing Taxation-->

                           <!--Reports Taxation-->
                           <ul class="mm-collapse mm-show" style="">
                                    <li>
                                        <a href="#View All Products" onclick="return TaxProductCreateForm()" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Add Products
                                        </a>
                                    </li>

                                    <li>
                                        <a  href="#ViewCard" aria-expanded="false"  onclick="return ViewTaxProduct()">
                                            <i class="metismenu-icon"></i>View Product
                                        </a>
                                    </li>


                            </ul>
                         <!--Taxation-->




                         <li class="app-sidebar__heading">Users</li>
                            <li>
                                <a href="#View All Users" onclick="return ViewAllUsers()">
                                    <i class="metismenu-icon pe-7s-graph2"></i>View
                                </a>
                            </li>
                         <li class="app-sidebar__heading">Profile</li>
                            <li>
                                <a href="#View All Sales" onclick="return UpdateProfileMenu()">
                                    <i class="metismenu-icon pe-7s-graph2"></i> Update
                                </a>
                            </li>



                              <!--Sponsoship-->



                                    <!--Quick Bonus -->


                                    <!--CardCode-->
                            <!--Safarinew and Code-->

                                    <!--SafariCode-->
                                      <!--SafariCode-->
                              <!--   <li class="app-sidebar__heading">Safari</li>
                            <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-rocket"></i>items Safari
                                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                </a>
                            </li>
                                <ul class="mm-collapse mm-show" style="">
                                    <li>
                                        <a href="#View All Products" onclick="return CheckSafari()" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Create
                                        </a>
                                    </li>

                                    <li>
                                        <a  href="#Create Product" onclick="return ViewSafari()" aria-expanded="false">
                                            <i class="metismenu-icon"></i>View
                                        </a>
                                    </li>-->




                                    <!--SafariCode-->
                                <li class="app-sidebar__heading mylogout" style="color:rgb(195 211 88);" onclick="logout()">

                                Logout<i class="fa text-white fa-power-off  pr-1 pl-1"></i>

                                </li>
                            </li>

                         <!--   <li class="app-sidebar__heading">Menu</li>
                            <li class="mm-active">
                                <a href="#" aria-expanded="true">
                                    <i class="metismenu-icon pe-7s-rocket"></i>Dashboards
                                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                </a>
                                <ul class="mm-collapse mm-show" style="">
                                    <li>
                                        <a href="index.html" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Analytics
                                        </a>
                                    </li>
                                    <li>
                                        <a href="dashboards-commerce.html" aria-expanded="false">
                                            <i class="metismenu-icon"></i>Commerce
                                        </a>
                                    </li>
                                    <li>
                                        <a href="dashboards-sales.html" aria-expanded="false">
                                            <i class="metismenu-icon">
                                            </i>Sales
                                        </a>
                                    </li>
                                    <li class="mm-active">
                                        <a href="#" aria-expanded="true">
                                            <i class="metismenu-icon"></i> Minimal
                                            <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                                        </a>
                                        <ul class="mm-collapse mm-show" style="">
                                            <li>
                                                <a href="dashboards-minimal-1.html">
                                                    <i class="metismenu-icon"></i>Variation 1
                                                </a>
                                            </li>
                                            <li>
                                                <a href="dashboards-minimal-2.html">
                                                    <i class="metismenu-icon"></i>Variation 2
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="dashboards-crm.html" aria-expanded="false">
                                            <i class="metismenu-icon"></i> CRM
                                        </a>
                                    </li>
                                </ul>
                            </li>-->


                        </ul>
                    </div>

</div>

            <!--<li ><a href="#Search Product" onclick="return ViewSearchForm()">Create Facture</a></li>-->
           <!-- <li ><a href="#Display Order" onclick="return DisplayOrderData()">Display Order</a></li>-->
            <!--<li ><a href="#Create Contact" onclick="return CreateContactMenu()">Create Contact</a></li>-->

          </div>
        <!--navigation Mobile-->
</head>
<body>

<!--search form-->
<!--<div class="container-fluid customizeContainer">-->
<div class="container ">
<!--form -->

<div class="modal fade bd-example-modal-lg viewOrder" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content ">

<div class="modal-header MyTitleModal"></div>
      <!--Order Request table-->
<div class="ModalPassword">
    <table class="viewReqTable">

<thead>
  <tr>
    <th scope="col">#</th>
    <th scope="col">Code</th>
    <th scope="col">qty</th>
    <th scope="col">pcs</th>
    <th scope="col">dz</th>

  </tr>
</thead>
<tbody>


</tbody>
</table>
</div>
                     <!--Order Request-->
      ...
    </div>
  </div>
</div>


<div class="main-card mb-3 card p-4">


<div class="MainbigTitle">



</div>
<div class="main-card card">
    <div class="card-body">

    <div class="MainForm ">



</div>
    </div>
</div>





<!--Modal table-->

<div class="Count_table">
<h6 class="text-center orderIdDsp"></h6>
<div class="float-left pt-2 pb-2">
<button type="button" class="btn btn-lg btn-danger" onclick="return DisplayOrderData()">Back</button>
</div>

</div>

            <!--Order Request table-->
            <div class="OrderDspTable">
            <table class="MyRequest_table">


  <tbody>


  </tbody>
</table>
</div>
                       <!--Order Request-->
        </div>
<!--form -->
</div>
</div>


<!--search form-->
@include('components.Footerjs.footerjs')
@include('Search')

<script>

    //copy Link //




// Add click event listener to the button
//copyLinkBtn.addEventListener('click', copyLinkToClipboard);


// Function to copy the link to the clipboard
function onCopy() {
    const copyLinkBtn = document.getElementById('copy-link-btn');
  // Create a temporary input element
  const tempInput = document.createElement('input');

  // Set the input value to the current URL
  tempInput.value = $('.linkCopy').val();

  // Append the input element to the document body
  document.body.appendChild(tempInput);

  // Select the input field
  tempInput.select();

  // Copy the selected text to the clipboard
  document.execCommand('copy');

  // Remove the temporary input element
  document.body.removeChild(tempInput);

  // Change the button text temporarily
  copyLinkBtn.textContent = 'Link Copied!';

  // Reset the button text after 2 seconds

}

/*charts script */
let chart;


/*charts script */


    //copy Link //
//search page



$(function() {
   // DisplayOrderData();
   //AllOpenSaleReport();
   $('.cover-spin').hide();
   //ViewSearchForm();

})

/*Taxation */
/*autocomplete script*/
const countriesData =[
  { id: 1, code: "+93", country: "Afghanistan" },
  { id: 2, code: "+355", country: "Albania" },
  { id: 3, code: "+213", country: "Algeria" },
  { id: 4, code: "+376", country: "Andorra" },
  { id: 5, code: "+244", country: "Angola" },
  { id: 6, code: "+1-268", country: "Antigua and Barbuda" },
  { id: 7, code: "+54", country: "Argentina" },
  { id: 8, code: "+374", country: "Armenia" },
  { id: 9, code: "+61", country: "Australia" },
  { id: 10, code: "+43", country: "Austria" },
  { id: 11, code: "+994", country: "Azerbaijan" },
  { id: 12, code: "+1-242", country: "Bahamas" },
  { id: 13, code: "+973", country: "Bahrain" },
  { id: 14, code: "+880", country: "Bangladesh" },
  { id: 15, code: "+1-246", country: "Barbados" },
  { id: 16, code: "+375", country: "Belarus" },
  { id: 17, code: "+32", country: "Belgium" },
  { id: 18, code: "+501", country: "Belize" },
  { id: 19, code: "+229", country: "Benin" },
  { id: 20, code: "+975", country: "Bhutan" },
  { id: 21, code: "+591", country: "Bolivia" },
  { id: 22, code: "+387", country: "Bosnia and Herzegovina" },
  { id: 23, code: "+267", country: "Botswana" },
  { id: 24, code: "+55", country: "Brazil" },
  { id: 25, code: "+673", country: "Brunei" },
  { id: 26, code: "+359", country: "Bulgaria" },
  { id: 27, code: "+226", country: "Burkina Faso" },
  { id: 28, code: "+257", country: "Burundi" },
  { id: 29, code: "+238", country: "Cabo Verde" },
  { id: 30, code: "+855", country: "Cambodia" },
  { id: 31, code: "+237", country: "Cameroon" },
  { id: 32, code: "+1", country: "Canada" },
  { id: 33, code: "+236", country: "Central African Republic" },
  { id: 34, code: "+235", country: "Chad" },
  { id: 35, code: "+56", country: "Chile" },
  { id: 36, code: "+86", country: "China" },
  { id: 37, code: "+57", country: "Colombia" },
  { id: 38, code: "+269", country: "Comoros" },
  { id: 39, code: "+242", country: "Congo (Congo-Brazzaville)" },
  { id: 40, code: "+243", country: "Congo (Congo-Kinshasa)" },
  { id: 41, code: "+506", country: "Costa Rica" },
  { id: 42, code: "+385", country: "Croatia" },
  { id: 43, code: "+53", country: "Cuba" },
  { id: 44, code: "+357", country: "Cyprus" },
  { id: 45, code: "+420", country: "Czechia" },
  { id: 46, code: "+45", country: "Denmark" },
  { id: 47, code: "+253", country: "Djibouti" },
  { id: 48, code: "+1-767", country: "Dominica" },
  { id: 49, code: "+1-809", country: "Dominican Republic" },
  { id: 50, code: "+593", country: "Ecuador" },
  { id: 51, code: "+20", country: "Egypt" },
  { id: 52, code: "+503", country: "El Salvador" },
  { id: 53, code: "+240", country: "Equatorial Guinea" },
  { id: 54, code: "+291", country: "Eritrea" },
  { id: 55, code: "+372", country: "Estonia" },
  { id: 56, code: "+268", country: "Eswatini" },
  { id: 57, code: "+251", country: "Ethiopia" },
  { id: 58, code: "+679", country: "Fiji" },
  { id: 59, code: "+358", country: "Finland" },
  { id: 60, code: "+33", country: "France" },
  { id: 61, code: "+241", country: "Gabon" },
  { id: 62, code: "+220", country: "Gambia" },
  { id: 63, code: "+995", country: "Georgia" },
  { id: 64, code: "+49", country: "Germany" },
  { id: 65, code: "+233", country: "Ghana" },
  { id: 66, code: "+30", country: "Greece" },
  { id: 67, code: "+1-473", country: "Grenada" },
  { id: 68, code: "+502", country: "Guatemala" },
  { id: 69, code: "+224", country: "Guinea" },
  { id: 70, code: "+245", country: "Guinea-Bissau" },
  { id: 71, code: "+592", country: "Guyana" },
  { id: 72, code: "+509", country: "Haiti" },
  { id: 73, code: "+504", country: "Honduras" },
  { id: 74, code: "+36", country: "Hungary" },
  { id: 75, code: "+354", country: "Iceland" },
  { id: 76, code: "+91", country: "India" },
  { id: 77, code: "+62", country: "Indonesia" },
  { id: 78, code: "+98", country: "Iran" },
  { id: 79, code: "+964", country: "Iraq" },
  { id: 80, code: "+353", country: "Ireland" },
  { id: 81, code: "+972", country: "Israel" },
  { id: 82, code: "+39", country: "Italy" },
  { id: 83, code: "+1-876", country: "Jamaica" },
  { id: 84, code: "+81", country: "Japan" },
  { id: 85, code: "+962", country: "Jordan" },
  { id: 86, code: "+7", country: "Kazakhstan" },
  { id: 87, code: "+254", country: "Kenya" },
  { id: 88, code: "+686", country: "Kiribati" },
  { id: 89, code: "+965", country: "Kuwait" },
  { id: 90, code: "+996", country: "Kyrgyzstan" },
  { id: 91, code: "+856", country: "Laos" },
  { id: 92, code: "+371", country: "Latvia" },
  { id: 93, code: "+961", country: "Lebanon" },
  { id: 94, code: "+266", country: "Lesotho" },
  { id: 95, code: "+231", country: "Liberia" },
  { id: 96, code: "+218", country: "Libya" },
  { id: 97, code: "+423", country: "Liechtenstein" },
  { id: 98, code: "+370", country: "Lithuania" },
  { id: 99, code: "+352", country: "Luxembourg" },
  { id: 100, code: "+261", country: "Madagascar" },
  { id: 101, code: "+265", country: "Malawi" },
  { id: 102, code: "+60", country: "Malaysia" },
  { id: 103, code: "+960", country: "Maldives" },
  { id: 104, code: "+223", country: "Mali" },
  { id: 105, code: "+356", country: "Malta" },
  { id: 106, code: "+692", country: "Marshall Islands" },
  { id: 107, code: "+222", country: "Mauritania" },
  { id: 108, code: "+230", country: "Mauritius" },
  { id: 109, code: "+52", country: "Mexico" },
  { id: 110, code: "+691", country: "Micronesia" },
  { id: 111, code: "+373", country: "Moldova" },
  { id: 112, code: "+377", country: "Monaco" },
  { id: 113, code: "+976", country: "Mongolia" },
  { id: 114, code: "+382", country: "Montenegro" },
  { id: 115, code: "+212", country: "Morocco" },
  { id: 116, code: "+258", country: "Mozambique" },
  { id: 117, code: "+95", country: "Myanmar" },
  { id: 118, code: "+264", country: "Namibia" },
  { id: 119, code: "+674", country: "Nauru" },
  { id: 120, code: "+977", country: "Nepal" },
  { id: 121, code: "+31", country: "Netherlands" },
  { id: 122, code: "+64", country: "New Zealand" },
  { id: 123, code: "+505", country: "Nicaragua" },
  { id: 124, code: "+227", country: "Niger" },
  { id: 125, code: "+234", country: "Nigeria" },
  { id: 126, code: "+850", country: "North Korea" },
  { id: 127, code: "+389", country: "North Macedonia" },
  { id: 128, code: "+47", country: "Norway" },
  { id: 129, code: "+968", country: "Oman" },
  { id: 130, code: "+92", country: "Pakistan" },
  { id: 131, code: "+680", country: "Palau" },
  { id: 132, code: "+970", country: "Palestine State" },
  { id: 133, code: "+507", country: "Panama" },
  { id: 134, code: "+675", country: "Papua New Guinea" },
  { id: 135, code: "+595", country: "Paraguay" },
  { id: 136, code: "+51", country: "Peru" },
  { id: 137, code: "+63", country: "Philippines" },
  { id: 138, code: "+48", country: "Poland" },
  { id: 139, code: "+351", country: "Portugal" },
  { id: 140, code: "+974", country: "Qatar" },
  { id: 141, code: "+40", country: "Romania" },
  { id: 142, code: "+7", country: "Russia" },
  { id: 143, code: "+250", country: "Rwanda" },
  { id: 144, code: "+1-869", country: "Saint Kitts and Nevis" },
  { id: 145, code: "+1-758", country: "Saint Lucia" },
  { id: 146, code: "+1-784", country: "Saint Vincent and the Grenadines" },
  { id: 147, code: "+685", country: "Samoa" },
  { id: 148, code: "+378", country: "San Marino" },
  { id: 149, code: "+239", country: "Sao Tome and Principe" },
  { id: 150, code: "+966", country: "Saudi Arabia" },
  { id: 151, code: "+221", country: "Senegal" },
  { id: 152, code: "+381", country: "Serbia" },
  { id: 153, code: "+248", country: "Seychelles" },
  { id: 154, code: "+232", country: "Sierra Leone" },
  { id: 155, code: "+65", country: "Singapore" },
  { id: 156, code: "+421", country: "Slovakia" },
  { id: 157, code: "+386", country: "Slovenia" },
  { id: 158, code: "+677", country: "Solomon Islands" },
  { id: 159, code: "+252", country: "Somalia" },
  { id: 160, code: "+27", country: "South Africa" },
  { id: 161, code: "+82", country: "South Korea" },
  { id: 162, code: "+211", country: "South Sudan" },
  { id: 163, code: "+34", country: "Spain" },
  { id: 164, code: "+94", country: "Sri Lanka" },
  { id: 165, code: "+249", country: "Sudan" },
  { id: 166, code: "+597", country: "Suriname" },
  { id: 167, code: "+46", country: "Sweden" },
  { id: 168, code: "+41", country: "Switzerland" },
  { id: 169, code: "+963", country: "Syria" },
  { id: 170, code: "+992", country: "Tajikistan" },
  { id: 171, code: "+255", country: "Tanzania" },
  { id: 172, code: "+66", country: "Thailand" },
  { id: 173, code: "+670", country: "Timor-Leste" },
  { id: 174, code: "+228", country: "Togo" },
  { id: 175, code: "+676", country: "Tonga" },
  { id: 176, code: "+1-868", country: "Trinidad and Tobago" },
  { id: 177, code: "+216", country: "Tunisia" },
  { id: 178, code: "+90", country: "Turkey" },
  { id: 179, code: "+993", country: "Turkmenistan" },
  { id: 180, code: "+688", country: "Tuvalu" },
  { id: 181, code: "+256", country: "Uganda" },
  { id: 182, code: "+380", country: "Ukraine" },
  { id: 183, code: "+971", country: "United Arab Emirates" },
  { id: 184, code: "+44", country: "United Kingdom" },
  { id: 185, code: "+1", country: "United States" },
  { id: 186, code: "+598", country: "Uruguay" },
  { id: 187, code: "+998", country: "Uzbekistan" },
  { id: 188, code: "+678", country: "Vanuatu" },
  { id: 189, code: "+379", country: "Vatican City" },
  { id: 190, code: "+58", country: "Venezuela" },
  { id: 191, code: "+84", country: "Vietnam" },
  { id: 192, code: "+967", country: "Yemen" },
  { id: 193, code: "+260", country: "Zambia" },
  { id: 194, code: "+263", country: "Zimbabwe" }

];
var MeasurementData=[
  { "id": 1, "code": "kg", "name": "kilogram" },
  { "id": 2, "code": "g", "name": "gram" },
  { "id": 3, "code": "mg", "name": "milligram" },
  { "id": 4, "code": "t", "name": "tonne" },
  { "id": 5, "code": "lb", "name": "pound" },
  { "id": 6, "code": "oz", "name": "ounce" },
  { "id": 7, "code": "st", "name": "stone" },
  { "id": 8, "code": "ton", "name": "ton (US)" },
  { "id": 9, "code": "l", "name": "liter" },
  { "id": 10, "code": "ml", "name": "milliliter" },
  { "id": 11, "code": "gal", "name": "gallon (US)" },
  { "id": 12, "code": "qt", "name": "quart (US)" },
  { "id": 13, "code": "pt", "name": "pint (US)" },
  { "id": 14, "code": "fl oz", "name": "fluid ounce (US)" },
  { "id": 15, "code": "m", "name": "meter" },
  { "id": 16, "code": "cm", "name": "centimeter" },
  { "id": 17, "code": "mm", "name": "millimeter" },
  { "id": 18, "code": "km", "name": "kilometer" },
  { "id": 19, "code": "in", "name": "inch" },
  { "id": 20, "code": "ft", "name": "foot" },
  { "id": 21, "code": "yd", "name": "yard" },
  { "id": 22, "code": "mi", "name": "mile" },
  { "id": 23, "code": "m²", "name": "square meter" },
  { "id": 24, "code": "cm²", "name": "square centimeter" },
  { "id": 25, "code": "mm²", "name": "square millimeter" },
  { "id": 26, "code": "km²", "name": "square kilometer" },
  { "id": 27, "code": "ft²", "name": "square foot" },
  { "id": 28, "code": "in²", "name": "square inch" },
  { "id": 29, "code": "yd²", "name": "square yard" },
  { "id": 30, "code": "acre", "name": "acre" },
  { "id": 31, "code": "ha", "name": "hectare" },
  { "id": 32, "code": "m³", "name": "cubic meter" },
  { "id": 33, "code": "cm³", "name": "cubic centimeter" },
  { "id": 34, "code": "mm³", "name": "cubic millimeter" },
  { "id": 35, "code": "ft³", "name": "cubic foot" },
  { "id": 36, "code": "in³", "name": "cubic inch" },
  { "id": 37, "code": "yd³", "name": "cubic yard" },
  { "id": 38, "code": "s", "name": "second" },
  { "id": 39, "code": "min", "name": "minute" },
  { "id": 40, "code": "h", "name": "hour" },
  { "id": 41, "code": "day", "name": "day" },
  { "id": 42, "code": "week", "name": "week" },
  { "id": 43, "code": "month", "name": "month" },
  { "id": 44, "code": "year", "name": "year" },
  { "id": 45, "code": "°C", "name": "degree Celsius" },
  { "id": 46, "code": "°F", "name": "degree Fahrenheit" },
  { "id": 47, "code": "K", "name": "Kelvin" },
  { "id": 48, "code": "N", "name": "Newton" },
  { "id": 49, "code": "Pa", "name": "Pascal" },
  { "id": 50, "code": "J", "name": "Joule" },
  { "id": 51, "code": "W", "name": "Watt" },
  { "id": 52, "code": "A", "name": "Ampere" },
  { "id": 53, "code": "V", "name": "Volt" },
  { "id": 54, "code": "Ω", "name": "Ohm" },
  { "id": 55, "code": "Hz", "name": "Hertz" },
  { "id": 56, "code": "Bq", "name": "Becquerel" },
  { "id": 57, "code": "Gy", "name": "Gray" },
  { "id": 58, "code": "Sv", "name": "Sievert" },
  { "id": 59, "code": "mol", "name": "mole" },
  { "id": 60, "code": "cd", "name": "candela" },
  { "id": 61, "code": "%", "name": "percent" },
  { "id": 62, "code": "ppm", "name": "parts per million" },
  { "id": 63, "code": "ppb", "name": "parts per billion" },
  { "id": 64, "code": "bps", "name": "bits per second" },
  { "id": 65, "code": "kbps", "name": "kilobits per second" },
  { "id": 66, "code": "Mbps", "name": "megabits per second" },
  { "id": 67, "code": "GBps", "name": "gigabits per second" },
  { "id": 68, "code": "B", "name": "byte" },
  { "id": 69, "code": "KB", "name": "kilobyte" },
  { "id": 70, "code": "MB", "name": "megabyte" },
  { "id": 71, "code": "GB", "name": "gigabyte" },
  { "id": 72, "code": "TB", "name": "terabyte" },
  { "id": 73, "code": "PB", "name": "petabyte" },
  { "id": 74, "code": "EB", "name": "exabyte" },
  { "id": 75, "code": "ZB", "name": "zettabyte" },
  { "id": 76, "code": "YB", "name": "yottabyte" },
  { "id": 77, "code": "rad", "name": "radian" },
  { "id": 78, "code": "deg", "name": "degree (angle)" },
  { "id": 79, "code": "sr", "name": "steradian" },
  { "id": 80, "code": "lm", "name": "lumen" },
  { "id": 81, "code": "lx", "name": "lux" },
  { "id": 82, "code": "Oe", "name": "oersted" },
  { "id": 83, "code": "Gs", "name": "gauss" },
  { "id": 84, "code": "T", "name": "tesla" },
  { "id": 85, "code": "Wb", "name": "weber" },
  { "id": 86, "code": "H", "name": "henry" },
  { "id": 87, "code": "kat", "name": "katal" },
  { "id": 88, "code": "Da", "name": "dalton" },
  { "id": 89, "code": "u", "name": "unified atomic mass unit" },
  { "id": 90, "code": "AU", "name": "astronomical unit" },
  { "id": 91, "code": "ly", "name": "light-year" },
  { "id": 92, "code": "pc", "name": "parsec" },
  { "id": 93, "code": "knot", "name": "knot (nautical mile per hour)" },
  { "id": 94, "code": "pH", "name": "pH" },
  { "id": 95, "code": "dB", "name": "decibel" },
  { "id": 96, "code": "cal", "name": "calorie" },
  { "id": 97, "code": "kcal", "name": "kilocalorie" }
];
function initializeCountryAutocomplete(inputSelector, suggestionBoxSelector, ObjectData,combineData) {
  const input = document.querySelector(inputSelector);
  const suggestionBox = document.querySelector(suggestionBoxSelector);
  const autocompleteContainer = input.closest(".autocomplete-container"); // Assuming a container exists

  input.addEventListener("input", () => {
    const query = input.value.toLowerCase();
    suggestionBox.innerHTML = "";

    if (query.length === 0) {
      suggestionBox.style.display = "none";
      return;
    }
     var ag4=combineData[0].dataArgument["arg3"];;
    const filtered = ObjectData.filter(item =>

      item[ag4].toLowerCase().includes(query)
    );
    var funct1=combineData[0].funct["funct1"];
    window[funct1](filtered, input, suggestionBox,combineData);//dynnamic

    suggestionBox.style.display = filtered.length ? "block" : "none";
  });

  document.addEventListener("click", function (e) {
    if (autocompleteContainer && !autocompleteContainer.contains(e.target)) {
      suggestionBox.style.display = "none";
    } else if (!autocompleteContainer && !suggestionBox.contains(e.target) && e.target !== input) {
      suggestionBox.style.display = "none";
    }
  });
}

function dynamicF(filteredItems, input, suggestionBox,combineData) {
  var arg1=combineData[0].dataArgument["arg1"];
  var arg2=combineData[0].dataArgument["arg2"];
  var arg3=combineData[0].dataArgument["arg3"];
  var stateV=combineData[0].stateV;

  filteredItems.forEach(item => {
    const div = document.createElement("div");
    $checkArg2a=arg2===""?"":(item[arg2]);
  $checkArg2=arg2==="exist"?"Data Exist":$checkArg2a;
    div.textContent = `${item[arg3]} ${$checkArg2}`;
    div.style.cursor = "pointer"; // Add some visual feedback for clickability
    div.addEventListener("click", () => {
      input.value = item[arg3];
      suggestionBox.style.display = "none";
      //alert(item[arg3]);
     // console.log("Selected data:", item); // Handle selected data
    });
    suggestionBox.appendChild(div);
  });
}
/*var combineData = [
  {
    "stateV": 1,
    "funct": {
      "funct1": "dynamicF",
      "funct2": ""
    },
    "dataArgument": {
      "arg1": "id",
      "arg2": "code",
      "arg3": "country"
    }
  }
];
initializeCountryAutocomplete(".countryInput", ".suggestions", countriesData,combineData);*/
/*autocomplete script*/
function CategoryForm(){

$('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Create Category</strong></h5>`)
$('.ModalPassword').html(`
<form class="formSafariCreate" onsubmit="return CategoryCreate()">
<div class="p-2">
<div class="form-group autocomplete-container">
<label>Category</label>
<input type="hidden" class="form-control" name="isActionInput" value="create_category" required placeholder="Enter Category Name"/>
<input type="text"   name="name"  placeholder="Enter Category" class="form-control cat">
  <div class="catSuggestions  suggestions"></div>

</div>
<div class="form-group ">
<label>Enter Tax percentage</label>
<input type="text" class="form-control" name="percentage" value="0" required placeholder="Enter Tax Percentage"/>
</div>

<div class="form-group">
<label for="exampleFormControlTextarea3">Enter Comment</label>
<textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
LoadCategory("exist");
}

function CategoryCreate(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/TaxCategory`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formSafariCreate').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    ViewTaxCategory();
    //LoadSafariStockItemTemplate(data);
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}


function LoadCategory(checkExist)
{
    console.log(checkExist);

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/LoadCategory`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",

    },
    headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{

    isActionInput:"load_category"
},
success:function(data){
if(data.status){//return data as true



myCatData=data.result;
//window.LoadCatData="hello pepe";
//console.log(LoadCatData);
//c//onsole.log(LoadCatData);

var combineData3 = [
  {
    "stateV": 1,
    "funct": {
      "funct1": "dynamicF",
      "funct2": ""
    },
    "dataArgument": {
      "arg1": "id",
      "arg2":checkExist,
      "arg3": "name"
    }
  }
];

initializeCountryAutocomplete(".cat", ".catSuggestions",myCatData,combineData3);



}
else{

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}
function ViewTaxCategory(){
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/LoadCategory`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
    isActionInput:'load_category'

},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center"> Category</h5>

`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Percentage</th>
<th scope="col">Created At</th>
<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Name">${resultData[i].name}</td>
  <td data-label="Percentage">${resultData[i].percentage}</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>
  <td data-label="Action"><i class="fas fa-eye text-primary mylogout" title="View Safari Items Load" onClick="return ViewItemSafariStock('${btoa(encodeURIComponent(JSON.stringify(resultData[i])))}')"></i> <i class="fas fa-edit text-primary mylogout" title="Edit this Safari" onClick="return ViewEditSafari('${btoa(JSON.stringify(resultData[i]))}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Safari" onClick="return DeleteSafari('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}','${btoa(resultData[i].comment)}','${btoa(resultData[i].uidCreator)}','${btoa(resultData[i].subscriber)}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);



//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
function TaxProductCreateForm(){

$('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Tax On Product</strong></h5>`)
$('.ModalPassword').html(`
<form class="formSafariCreate" onsubmit="return TaxProductCreate()">
<div class="p-2">

<div class="form-group autocomplete-container">
<label>import From(Country)</label>
<input type="text"  name="catName"  placeholder="Start typing country..." class="form-control countryInput">
  <div class="suggestions"></div>

</div>

<div class="form-group autocomplete-container">
<label>Category</label>
<input type="text"  name="cat"  placeholder="Enter Category" class="form-control cat">
  <div class="catSuggestions  suggestions"></div>

</div>
<div class="form-group ">
<label>Enter Product Code</label>

<input type="text" class="form-control" name="productCode" required placeholder="Enter Product Code"/>
</div>

<div class="form-group ">
<label>Enter Product Name</label>

<input type="text" class="form-control" name="productName" placeholder="Enter Product Name"/>
</div>


<div class="form-group autocomplete-container">
<label>Enter product Tax Measure</label>
<input type="text"  name="measurement"  placeholder="Enter  product Tax measurement" class="form-control measureInput">
  <div class="meSuggestions  suggestions"></div>

</div>

<div class="form-group ">
<label>Enter qty per That  Measure</label>

<input type="text" class="form-control" name="qty" placeholder="Enter qty per That  Measure"/>
</div>
<div class="form-group ">
<label>Enter price Tax per That  Measure</label>

<input type="text" class="form-control" name="price" placeholder="Enter price Tax per That  Measure"/>
</div>






<div class="form-group">
<label for="exampleFormControlTextarea3">Enter Comment</label>
<textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
var combineData = [
  {
    "stateV": 1,
    "funct": {
      "funct1": "dynamicF",
      "funct2": ""
    },
    "dataArgument": {
      "arg1": "id",
      "arg2": "code",
      "arg3": "country"
    }
  }
];
initializeCountryAutocomplete(".countryInput", ".suggestions", countriesData,combineData);
var combineData2 = [
  {
    "stateV": 1,
    "funct": {
      "funct1": "dynamicF",
      "funct2": ""
    },
    "dataArgument": {
      "arg1": "id",
      "arg2": "code",
      "arg3": "name"
    }
  }
];
initializeCountryAutocomplete(".measureInput", ".meSuggestions",MeasurementData,combineData2);

LoadCategory("");
/*var combineData3 = [
  {
    "stateV": 1,
    "funct": {
      "funct1": "dynamicF",
      "funct2": ""
    },
    "dataArgument": {
      "arg1": "id",
      "arg2": "percentage",
      "arg3": "name"
    }
  }
];

initializeCountryAutocomplete(".cat", ".catSuggestions",LoadCatData,combineData3);*/

}

function TaxProductCreate(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/Taxproduct`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formSafariCreate').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    ViewTaxProduct();
    //LoadSafariStockItemTemplate(data);
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}
function ViewTaxProduct(){
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/Products`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
"productCode":"nyota",
"productName":"none",
"productQr":"none",
"LimitStart":1,
"LimitEnd":10,
"isProductAction":"none",
"withTotal":"none"
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center">Products</h5>

`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Category</th>
<th scope="col">Charge</th>
<th scope="col">Created At</th>
<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Name">${resultData[i].productCode }</td>
  <td data-label="Category">${resultData[i].catName}</td>
  <td data-label="Charge">${resultData[i].price}/${resultData[i].qty}${resultData[i].measurement}</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>
  <td data-label="Action"><i class="fas fa-eye text-primary mylogout" title="View Safari Items Load" onClick="return ViewItemSafariStock('${btoa(encodeURIComponent(JSON.stringify(resultData[i])))}')"></i> <i class="fas fa-edit text-primary mylogout" title="Edit this Safari" onClick="return ViewEditSafari('${btoa(encodeURIComponent(JSON.stringify(resultData[i])))}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Safari" onClick="return DeleteSafari('${btoa(encodeURIComponent(JSON.stringify(resultData[i])))}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);



//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
function CaptureData()
{

    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item </strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemSafariStock" onsubmit="return TaxSubmitDeclareOrder()">
<div class="p-2">


<div class="form-group right-inner-addon">
<label>Search Product<span class="text-danger">*</span></label>
<input type="text" class="form-control productCodeClass"  autocomplete="off" onkeyup="autoCompleteTax(this)" name="productCode" placeholder="Search Product" required/>
<span class="autocompleteIcon" onclick="hidePopup()"><i class="fas fa-exclamation-triangle text-danger" ></i></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>

<div class="d-flex justify-content-end TotalTax">

  </div>
<ul class="list-group cartData" id="myList ">



  </ul>







<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
loadTaxCart();

    //


}
function viewDataSales(){
    var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"today",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Today Sales"
};

var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));

}
function autoCompleteTax(thisdata)
{
    $('.autocompleteIcon').html(`<i class="fas fa-exclamation-triangle text-danger onclick="hidePopup()"></i>`);
    //
        if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/Products`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        //"Authorization": `Bearer ${Usertoken}`
    },
    headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
    productCode:thisdata.value,
    productName:"none",
    productQr:"none",
    isProductAction:"search",//product get Action(search,edit,view)
    LimitStart:1,  //page
    LimitEnd:10,
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){
    // console.log(data);

    getdata+=`

   <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemTaxInCart('${btoa(encodeURIComponent(JSON.stringify(data[i])))}')">

   ${data[i].productCode}(${data[i].ProductName}):(${data[i].price}$/${data[i].qty}${data[i].measurement})=>Category(${data[i].cat})=>Country(${data[i].catName})=>${data[i].pcs}pcs

    <span class="badge "></span>
  </li>

    `;

 }

 $('.autoCompleteTopItem').html(getdata);







}
else{
    isAvailable=true;

    $('.isProductExist').show();
    $('.isProductNotExist').show();
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}


function addItemTaxInCart(dataPass)
{
    dataString=atob(dataPass);


    data=JSON.parse(decodeURIComponent(dataString));

    if(localStorage.getItem("CartUId"))
    {
        var MyDataArr=localStorage.getItem(localStorage.getItem("CartUId"));
        MyDataArr=atob(MyDataArr);
        MyDataArr=JSON.parse(decodeURIComponent(MyDataArr));
        const result = MyDataArr.find(item => item.productCode === data.productCode);
        if(result)
        {
            alert(`${data.productCode} exist in Cart add New One`);
        }
        else{

            taxPlaceDeclareOrder(dataPass);
        }

    }else{

        taxPlaceDeclareOrder(dataPass);
    }

}
function taxPlaceDeclareOrder(dataPass){

    dataString=atob(dataPass);


data=JSON.parse(decodeURIComponent(dataString));
    $('.cover-spin').show();

var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/TaxplaceDeclareOrder`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{


productCode:data["productCode"],
uidClient:"ERICMUSHI_1688628812",
req_qty:35,
ref:"test",
comment:"ok",
statusForm:"none",
orderIdFromEdit:(localStorage.getItem("CartUId")?localStorage.getItem("CartUId"):'none')



},
success:function(data){
if(data.status){//return data as true

    /*if(localStorage.getItem("CartUId"))
    {

        const ArrayData = localStorage.getItem(data.OrderId);
        ArrayData=JSON.parse(ArrayData);
        ArrayData.unshift(dataString);

        addDataInCart();


    }else{
        localStorage.setItem("CartUId", data.OrderId);
        localStorage.setItem(data.OrderId,dataString);
        addDataInCart();
        //addDataInCart();
    }*/
    $('.cover-spin').hide();
    hidePopup();
    loadTaxCart();

}
else{
    $('.cover-spin').hide();
alert("This Product has been used Please Contact System Admin if you want to edit this Quantity");

}



},
error:function(data){
    $('.cover-spin').hide();
}
});
}
function TaxSubmitDeclareOrder(dataPass)
{

    var uid=localStorage.getItem("CartUId");
    if(confirm(`Do you Want to Create this Invoice ${uid}?`))
    {

    $('.cover-spin').show();

var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/TaxSubmitDeclareOrder`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
uid:"Nyota_1672353378",
uidUser:"ERICMUSHI_1688628812",
OrderId:localStorage.getItem("CartUId"),
inputData:"200",
all_total:"2450",
reach:"1200",
gain:"350",
systemUid:"PointSales1"



},
success:function(data){
if(data.status){//return data as true
$('.cover-spin').hide();
hidePopup();
localStorage.removeItem(localStorage.getItem("CartUId"));
localStorage.removeItem("CartUId");
var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"today",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Today Sales"
};
$('.TotalTax').html("");
$('.cartData').html("");
var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));


//load all Sales Captured Today


}
else{
    $('.cover-spin').hide();
alert("There is something Wrong");

}



},
error:function(data){
    $('.cover-spin').hide();
}
});

}

return false;
}
/*Loading chats */
function todayChart(dataPass,todayDate,advancedSearch){
 //console.log(dataPass);

 var transactions = dataPass;

  const today = todayDate;
  const hourLabels = Array.from({ length: 24 }, (_, i) =>
    `${i.toString().padStart(2, "0")}:00`
  );
  const hourlyCounts = Array(24).fill(0);
  const userDetailsByHour = {};

  transactions.forEach(tx => {
    const [date, time] = tx.created_at.split(" ");
    const hour = parseInt(time.split(":")[0]);

    if (date === today) {
      hourlyCounts[hour]++;
      if (!userDetailsByHour[hour]) {
        userDetailsByHour[hour] = [];
      }
      userDetailsByHour[hour].push({
        name: tx.name,
        paid: tx.totalPaid
      });
    }
  });

  const ctx = document.getElementById("salesChart").getContext("2d");
  const chart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: hourLabels,
      datasets: [{
        label: 'Number of Sales Per Hour',
        data: hourlyCounts,
        backgroundColor: 'rgba(75, 192, 192, 0.7)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      }]
    },
    options: {
      interaction: {
        mode: 'nearest',
        intersect: true
      },
      plugins: {
        tooltip: {
          callbacks: {
            title: (tooltipItems) => {
              const hour = tooltipItems[0].label;
              return `Details for ${today} at ${hour}`;
            },
            label: (tooltipItem) => {
              const hourIndex = tooltipItem.dataIndex;
              const count = tooltipItem.dataset.data[hourIndex];
              return `Number of Sales: ${count}`;
            },
            afterLabel: (tooltipItem) => {
              const hourIndex = tooltipItem.dataIndex;
              const users = userDetailsByHour[hourIndex] || [];
              return users.map((u, i) => `#${i + 1}. ${u.name} paid $${u.paid}`);
            }
          }
        },
        title: {
          display: true,
          text: `Sales Breakdown for ${today}`
        }
      },
      scales: {
        x: {
          title: { display: true, text: 'Hour of Day' }
        },
        y: {
          beginAtZero: true,
          title: { display: true, text: 'Number of Sales' }
        }
      }
    }
  });
}
function weekChart(dataPass,todayDate,advancedSearch){
    var transactions = dataPass;

     // Helper: Get start and end of the current week (Sunday to Saturday)
  const now = new Date(todayDate); // You can use new Date() in real app
  const startOfWeek = new Date(now);
  startOfWeek.setDate(now.getDate() - now.getDay());
  startOfWeek.setHours(0, 0, 0, 0);

  const endOfWeek = new Date(startOfWeek);
  endOfWeek.setDate(startOfWeek.getDate() + 6);
  endOfWeek.setHours(23, 59, 59, 999);

  // Initialize data
  const dailyCounts = {};
  const userDetailsByDate = {};

  // Prepare weekday labels
  const daysOfWeek = [];
  for (let i = 0; i < 7; i++) {
    const d = new Date(startOfWeek);
    d.setDate(startOfWeek.getDate() + i);
    const dateStr = d.toISOString().split("T")[0];
    dailyCounts[dateStr] = 0;
    userDetailsByDate[dateStr] = [];
    daysOfWeek.push(dateStr);
  }

  // Group transactions by day in the current week
  transactions.forEach(tx => {
    const dateTime = new Date(tx.created_at);
    const dateStr = tx.created_at.split(" ")[0];

    if (dateTime >= startOfWeek && dateTime <= endOfWeek) {
      dailyCounts[dateStr]++;
      userDetailsByDate[dateStr].push({
        time: tx.created_at.split(" ")[1].slice(0, 5), // Extract time like "03:53"
        name: tx.name,
        paid: tx.totalPaid
      });
    }
  });

  const ctx = document.getElementById("salesChart").getContext("2d");
  const chart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: daysOfWeek,
      datasets: [{
        label: 'Number of Sales Per Day (This Week)',
        data: daysOfWeek.map(date => dailyCounts[date]),
        backgroundColor: 'rgba(153, 102, 255, 0.7)',
        borderColor: 'rgba(153, 102, 255, 1)',
        borderWidth: 1
      }]
    },
    options: {
      interaction: {
        mode: 'nearest',
        intersect: true
      },
      plugins: {
        tooltip: {
          callbacks: {
            title: (tooltipItems) => {
              const date = tooltipItems[0].label;
              return `Details for ${date}`;
            },
            label: (tooltipItem) => {
              const date = tooltipItem.label;
              const count = dailyCounts[date];
              return `Number of Sales: ${count}`;
            },
            afterLabel: (tooltipItem) => {
              const date = tooltipItem.label;
              const users = userDetailsByDate[date] || [];
              return users.map((u, i) => `#${i + 1}. ${u.time}: ${u.name} paid $${u.paid}`);
            }
          }
        },
        title: {
          display: true,
          text: `Weekly Sales Breakdown (${startOfWeek.toISOString().split('T')[0]} to ${endOfWeek.toISOString().split('T')[0]})`
        }
      },
      scales: {
        x: {
          title: { display: true, text: 'Date' }
        },
        y: {
          beginAtZero: true,
          title: { display: true, text: 'Number of Sales' }
        }
      }
    }
  });
}
function otherChatDisplay(dataPass,todayDate,advancedSearch)
{
   // advancedSearch="today,week,month,year,all,lastyear"
    updateChart(advancedSearch,dataPass);
}
function formatDate(dateStr) {
    return new Date(dateStr.replace(" ", "T"));
  }

  function updateChart(filter,dataPass) {
    const ctx = document.getElementById("salesChart").getContext("2d");

    var transactions=dataPass;
    let filteredData = [];
    let now = new Date();
    let labels = [];
    let dataMap = new Map();
    let userDetailsByLabel = {};

    const formatMap = {
      "day": { label: "hour", getLabel: d => `${d.getHours().toString().padStart(2, "0")}:00` },
      "week": { label: "day", getLabel: d => d.toLocaleDateString() },
      "month": { label: "day", getLabel: d => d.toLocaleDateString() },
      "year": { label: "month", getLabel: d => `${d.getFullYear()}-${(d.getMonth() + 1).toString().padStart(2, '0')}` },
      "lastYear": { label: "month", getLabel: d => `${d.getFullYear()}-${(d.getMonth() + 1).toString().padStart(2, '0')}` },
      "all": { label: "month", getLabel: d => `${d.getFullYear()}-${(d.getMonth() + 1).toString().padStart(2, '0')}` },
    };

    const { getLabel } = formatMap[filter];

    transactions.forEach(tx => {
      const txDate = formatDate(tx.created_at);
      let include = false;

      switch (filter) {
        case "day":
          include = isSameDay(txDate, now);
          break;
        case "week":
          include = isSameWeek(txDate, now);
          break;
        case "month":
          include = isSameMonth(txDate, now);
          break;
        case "year":
          include = txDate.getFullYear() === now.getFullYear();
          break;
        case "lastYear":
          include = txDate.getFullYear() === now.getFullYear() - 1;
          break;
        case "all":
          include = true;
          break;
      }

      if (include) {
        const label = getLabel(txDate);
        if (!dataMap.has(label)) {
          dataMap.set(label, 0);
          userDetailsByLabel[label] = [];
        }
        dataMap.set(label, dataMap.get(label) + 1);
        userDetailsByLabel[label].push({ name: tx.name, paid: tx.totalPaid,time:tx.created_at });
      }
    });

    labels = Array.from(dataMap.keys());
    const counts = Array.from(dataMap.values());

    if (chart) chart.destroy();

    chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'Number of Sales',
          data: counts,
          backgroundColor: 'rgba(75, 192, 192, 0.7)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        }]
      },
      options: {
        plugins: {
          tooltip: {
            callbacks: {
              title: (tooltipItems) => {
                const label = tooltipItems[0].label;
                return `Sales on ${label}`;
              },
              label: (tooltipItem) => {
                return `Sales: ${tooltipItem.formattedValue}`;
              },
              afterLabel: (tooltipItem) => {
                const label = tooltipItem.label;
                const users = userDetailsByLabel[label] || [];
                return users.map((u, i) => `#${i + 1}.${u.time}:  ${u.name} paid $${u.paid}`);
              }
            }
          },
          title: {
            display: true,
            text: `Sales Breakdown (${filter})`
          }
        },
        scales: {
          x: { title: { display: true, text: formatMap[filter].label.toUpperCase() } },
          y: { beginAtZero: true, title: { display: true, text: 'Number of Sales' } }
        }
      }
    });
  }

  function isSameDay(d1, d2) {
    return d1.toDateString() === d2.toDateString();
  }

  function isSameWeek(d1, d2) {
    const oneJan = new Date(d2.getFullYear(), 0, 1);
    const week1 = Math.ceil((((d1 - oneJan) / 86400000) + oneJan.getDay() + 1) / 7);
    const week2 = Math.ceil((((d2 - oneJan) / 86400000) + oneJan.getDay() + 1) / 7);
    return d1.getFullYear() === d2.getFullYear() && week1 === week2;
  }

  function isSameMonth(d1, d2) {
    return d1.getFullYear() === d2.getFullYear() && d1.getMonth() === d2.getMonth();
  }
/*Loading chats */
function TaxReportTotal(){
    var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"today",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Today Sales",
"functionName":"todayChart"
};

var dataString=JSON.stringify(dataR);
SumReportTotal(btoa(encodeURIComponent(dataString)));
}
function SumReportTotal(dataPass){

//console.log(atob(dataPass));
    var dataR=atob(dataPass);
    dataR=JSON.parse(decodeURIComponent(dataR));
    console.log(dataR);
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/SumReportTotal`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
searchOption:dataR.searchOption,
name:dataR.name,
advancedSearch:dataR.advancedSearch,
thisDate:dataR.thisDate,
toDate:dataR.toDate
},

success:function(data){


if(data.status){//return data as true

//console.log(data)
var resultData=data.Charts.original.result;
var sumData=data.result;
//console.log(resultData);

$('.MainbigTitle').html(`
<h5 class="text-center">Sales Report </h5>

<div class="d-flex justify-content-end mb-3">
<div class="d-inline-block dropdown">
                                        <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn-shadow dropdown-toggle btn btn-info">

                                            <span class="btn-icon-wrapper pr-2 opacity-7">
                                                <i class="fa fa-search fa-w-20"></i>
                                            </span>
                                            Search
                                        </button>
                                        <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(107px, 33px, 0px);">
                                            <ul class="nav flex-column list-group">
                                            <li class="nav-item ">
                                                <div class="input-group p-2">
  <input type="text" class="form-control border-right-0" placeholder="Search...">
  <div class="input-group-append">
    <span class="input-group-text bg-white border-left-0">
      <i class="fa fa-search"></i>
    </span>
  </div>
</div>
                                                </li>
                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SumReportTotal('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"today",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Today Sales",
"functionName":"todayChart"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-inbox"></i>
                                                        <span>
                                                            Today
                                                        </span>

                                                    </a>
                                                </li>
                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SumReportTotal('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"week",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Week Sales",
"functionName":"weekChart"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            This Week
                                                        </span>

                                                    </a>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SumReportTotal('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"month",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Monthly Sales",
"functionName":"otherChatDisplay"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            This Month
                                                        </span>

                                                    </a>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SumReportTotal('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"year",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Year Sales",
"functionName":"otherChatDisplay"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            This Year
                                                        </span>

                                                    </a>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0 " >

                                                <div class="form-group p-2">
                                                <input type="text" class="form-control chooseTaxDate" placeholder="choose Date">
                                                </div>


                                                </li>
                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                <div class="form-group p-2">
                                                <input type="text" class="form-control rangeTaxDate" placeholder="choose Range">
                                                </div>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SumReportTotal('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"all",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"All Sales",
"functionName":"otherChatDisplay"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            All My Sale
                                                        </span>

                                                    </a>
                                                </li>


                                            </ul>
                                        </div>
                                    </div>
</div>
<h5 class="text-center text-success">${dataR.saleStatus}</h5>


<div class="main-card card mb-3">
    <div class="card-body">
	<div class="row TaxReport">
    <div class="col-md-6 col-xl-4">
        <div class="card mb-3 widget-content bg-midnight-bloom">
            <div class="widget-content-wrapper text-white">
                <div class="widget-content-left">
                    <div class="widget-heading">Today Orders</div>
                    <div class="widget-subheading">Total Today Earn</div>
                </div>
                <div class="widget-content-right">
                    <div class="widget-numbers text-white"><span>$${Math.round(sumData[0].today_sales)}</span></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-xl-4">
        <div class="card mb-3 widget-content bg-arielle-smile">
            <div class="widget-content-wrapper text-white">
                <div class="widget-content-left">
                    <div class="widget-heading">Weekly Orders</div>
                    <div class="widget-subheading">Total Week Earn</div>
                </div>
                <div class="widget-content-right">
                    <div class="widget-numbers text-white"><span>$${Math.round(sumData[0].week_sales)}</span></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-xl-4">
        <div class="card mb-3 widget-content bg-grow-early">
            <div class="widget-content-wrapper text-white">
                <div class="widget-content-left">
                    <div class="widget-heading">Monthly Orders</div>
                    <div class="widget-subheading">Total Month Earn</div>
                </div>
                <div class="widget-content-right">
                    <div class="widget-numbers text-white"><span>$${Math.round(sumData[0].month_sales)}</span></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-6 col-xl-4">
        <div class="card mb-3 widget-content bg-asteroid">
            <div class="widget-content-wrapper text-white">
                <div class="widget-content-left">
                    <div class="widget-heading">Years Orders</div>
                    <div class="widget-subheading">Total Year Earns</div>
                </div>
                <div class="widget-content-right">
                    <div class="widget-numbers text-warning"><span>$${Math.round(sumData[0].year_sales)}</span></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-6 col-xl-4">
        <div class="card mb-3 widget-content bg-love-kiss">
            <div class="widget-content-wrapper text-white">
                <div class="widget-content-left">
                    <div class="widget-heading">Last years Orders</div>
                    <div class="widget-subheading">Total Last years Earn</div>
                </div>
                <div class="widget-content-right">
                    <div class="widget-numbers text-warning"><span>$${Math.round(sumData[0].last_year_sales)}</span></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-6 col-xl-4">
        <div class="card mb-3 widget-content bg-premium-dark">
            <div class="widget-content-wrapper text-white">
                <div class="widget-content-left">
                    <div class="widget-heading">All Sales Orders</div>
                    <div class="widget-subheading">All Total Earn</div>
                </div>
                <div class="widget-content-right">
                    <div class="widget-numbers text-warning"><span>$${Math.round(sumData[0].all_sales)}</span></div>
                </div>
            </div>
        </div>
    </div>
</div>

	</div>

   </div>

                        <div class="main-card card mb-4 ${resultData!=0?"":"d-none"}">
    <div class="card-body">
	<canvas id="salesChart" width="600" height="300"></canvas>
	</div>

   </div>


   <div class="d-flex justify-content-end ${resultData!=0?"":"d-none"}">
<ul class="list-group ${resultData!=0?"":"d-none"}">
      <li class="list-group-item"><strong>Total ~ :</strong>${Math.round(resultData!=0?resultData[0].saleBalance:0)}$</li>

    </ul>
  </div>
`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable ${resultData!=0?"":"d-none"}">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">UID</th>
<th scope="col">name</th>
<th scope="col">Total</th>
<th scope="col">Created At</th>


</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="UID">${resultData[i].OrderId}</td>
  <td data-label="name">${resultData[i].name}</td>
  <td data-label="Total">${resultData[i].totalPaid}$</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>

</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);
//this is todayChart, weekChart
(resultData!=0)?window[dataR.functionName](resultData,(data.Charts.original.test),(dataR.advancedSearch)):0;


$('.chooseTaxDate').flatpickr(
    {
    onChange:function(selectedDates,dateStr,instance){
     console.log(dateStr);

     var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"choosedate",
"thisDate":dateStr,
"toDate":"none",
"saleStatus":`${dateStr} Sales`
};

var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));
    },

    dateFormat: "Y-m-d ",
}
);

$('.rangeTaxDate').flatpickr(
    {
    onChange:function(selectedDates,dateStr,instance){
     //console.log(dateStr);

     if(selectedDates.length===2){
        var startDate=instance.formatDate(selectedDates[0],"Y-m-d");
        var endDate=instance.formatDate(selectedDates[1],"Y-m-d");
       console.log(startDate);
       var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"choosedaterange",
"thisDate":startDate,
"toDate":endDate,
"saleStatus":`From ${startDate} to ${endDate} Sales`
};

var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));
       //console.log(dateStr[0]);
     }

    },
    mode: "range",

    dateFormat: "Y-m-d ",
}
);





}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;

}
function viewSales(dataPass){

//console.log(atob(dataPass));
    var dataR=atob(dataPass);
    dataR=JSON.parse(decodeURIComponent(dataR));
    console.log(dataR);
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/viewSales`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
searchOption:dataR.searchOption,
name:dataR.name,
advancedSearch:dataR.advancedSearch,
thisDate:dataR.thisDate,
toDate:dataR.toDate
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center">Capturing Invoice </h5>

<div class="d-flex justify-content-end mb-3">
<div class="d-inline-block dropdown">
                                        <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn-shadow dropdown-toggle btn btn-info">

                                            <span class="btn-icon-wrapper pr-2 opacity-7">
                                                <i class="fa fa-search fa-w-20"></i>
                                            </span>
                                            Search
                                        </button>
                                        <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(107px, 33px, 0px);">
                                            <ul class="nav flex-column list-group">
                                            <li class="nav-item ">
                                                <div class="input-group p-2">
  <input type="text" class="form-control border-right-0" placeholder="Search...">
  <div class="input-group-append">
    <span class="input-group-text bg-white border-left-0">
      <i class="fa fa-search"></i>
    </span>
  </div>
</div>
                                                </li>
                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SalesThis('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"today",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Today Sales"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-inbox"></i>
                                                        <span>
                                                            Today
                                                        </span>

                                                    </a>
                                                </li>
                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SalesThis('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"week",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Week Sales"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            This Week
                                                        </span>

                                                    </a>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SalesThis('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"month",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Monthly Sales"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            This Month
                                                        </span>

                                                    </a>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link" onclick="return SalesThis('${btoa(
                                                        encodeURIComponent(JSON.stringify({
"searchOption":"false",
"name":"be",
"advancedSearch":"year",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Year Sales"
}))
                                                    )}')">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            This Year
                                                        </span>

                                                    </a>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0 " >

                                                <div class="form-group p-2">
                                                <input type="text" class="form-control chooseTaxDate" placeholder="choose Date">
                                                </div>


                                                </li>
                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                <div class="form-group p-2">
                                                <input type="text" class="form-control rangeTaxDate" placeholder="choose Range">
                                                </div>
                                                </li>

                                                <li class="nav-item list-group-item list-group-item-action p-0">
                                                    <a href="javascript:void(0);" class="nav-link">
                                                        <i class="nav-link-icon lnr-book"></i>
                                                        <span>
                                                            All My Sale
                                                        </span>

                                                    </a>
                                                </li>


                                            </ul>
                                        </div>
                                    </div>
</div>
<h5 class="text-center text-success">${dataR.saleStatus}</h5>


<div class="d-flex justify-content-end ">
<ul class="list-group">
      <li class="list-group-item"><strong>Total ~ :</strong>${Math.round(resultData[0].saleBalance)}$</li>

    </ul>
  </div>
`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">UID</th>
<th scope="col">name</th>
<th scope="col">Total</th>
<th scope="col">Created At</th>


</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="UID">${resultData[i].OrderId}</td>
  <td data-label="name">${resultData[i].name}</td>
  <td data-label="Total">${resultData[i].totalPaid}$</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>

</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);


$('.chooseTaxDate').flatpickr(
    {
    onChange:function(selectedDates,dateStr,instance){
     console.log(dateStr);

     var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"choosedate",
"thisDate":dateStr,
"toDate":"none",
"saleStatus":`${dateStr} Sales`
};

var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));
    },

    dateFormat: "Y-m-d ",
}
);

$('.rangeTaxDate').flatpickr(
    {
    onChange:function(selectedDates,dateStr,instance){
     //console.log(dateStr);

     if(selectedDates.length===2){
        var startDate=instance.formatDate(selectedDates[0],"Y-m-d");
        var endDate=instance.formatDate(selectedDates[1],"Y-m-d");
       console.log(startDate);
       var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"choosedaterange",
"thisDate":startDate,
"toDate":endDate,
"saleStatus":`From ${startDate} to ${endDate} Sales`
};

var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));
       //console.log(dateStr[0]);
     }

    },
    mode: "range",

    dateFormat: "Y-m-d ",
}
);
//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;

}
function SalesThis(thisData){
    viewSales(thisData);
}
function loadTaxCart(){
//

var dataR={
"searchOption":"false",
"name":"be",
"advancedSearch":"today",
"thisDate":"2024-2-8",
"toDate":"none",
"saleStatus":"Today Sales"
};

var dataString=JSON.stringify(dataR);
viewSales(btoa(encodeURIComponent(dataString)));
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/ViewUserTempOrder`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
success:function(data){
if(data.status){//return data as true

    var dataR=data.result;

    var dataString=btoa(encodeURIComponent(JSON.stringify(dataR)));


        localStorage.setItem("CartUId", dataR[0].uid);
        localStorage.setItem(dataR[0].uid,dataString);


        const totalAmount = dataR.reduce((sum, item) => sum + item.totalAmount, 0);

        $('.TotalTax').html(`<ul class="list-group">
      <li class="list-group-item"><strong>Total:</strong>${totalAmount}</li>

    </ul>`);


        addDataInCart();


}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
//
}
function addDataInCart(){
    if(localStorage.getItem("CartUId"))
    {
    var ArrayData = localStorage.getItem(localStorage.getItem("CartUId"));
    ArrayData=atob(ArrayData);
    data=JSON.parse(decodeURIComponent(ArrayData));

    var getData="";
    for(var i=0;i<data.length;i++){
        getData+=`<li class="list-group-item">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div><strong>Code:</strong> ${data[i].productCode}(${data[i].productName})</div>
          <div><strong>Qty:</strong>${data[i].totalQty}</div>
          <div><strong>Price:</strong>${data[i].price}$ </div>
          <div><strong>Total:</strong>${data[i].totalAmount}</div>

        </div>
        <button class="btn btn-sm btn-danger ms-3" onclick="removeItem(this)">Remove</button>
      </div>
    </li>`;

    }
    $('.cartData').html(getData);
    }
    else{
    console.log("Cart not exist");
    }


}




/*Taxation */
//CardCode
function CreateMultipleCardMenu(){
    $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
    closeNav();
    $('.MainForm').html(`
    <h5 class="text-center">Generate Card</h5>
    <form class="formDataCreate" onsubmit="return CreateMultipleCard()">

<div class="form-group">
<label>Number <span class="text-danger">*</span></label>
<input type="text" class="form-control" name="numberQr" required/>
</div>
<div class="form-group">

<button  class="btn btn-danger mycreateProduct" >Submit</button>
</div>


</form>
    `);




}
function CreateMultipleCard(){//Company
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");

   $.ajax({

url:`./api/CreateMultipleCard`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formDataCreate').serialize(),
success:function(data){
if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();

 //ViewAllProducts();

    alert("Card generated Successfully");
    $('.formDataCreate :input').val("");
    $('.mycreateProduct').val("Submit");

   // LoadSavedComeFrom();

}
else{
alert("Something is wrong please contact system Admin");
$('.cover-spin').hide();

}



},
error:function(data){
    console.log(data);
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}


function CreatePromotionEventMenu(){
    $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
    closeNav();
    $('.MainForm').html(`
    <h5 class="text-center">Create Promotion</h5>

    <form class="formDataCreate" onsubmit="return CreatePromotionEvent()">

<div class="form-group">
<label> Promotion Name <span class="text-danger">*</span></label>
<input type="text" class="form-control" name="promoName" required/>
</div>
<div class="form-group">

<div class="form-group">
<label>Reach<span class="text-danger">*</span></label>
<input type="text" class="form-control Promo_reach" name="reach" value="0" required onchange="return changePromoMsg()" onkeyup="changePromoMsg()"/>
</div>

<div class="form-group">
<label>Bonus<span class="text-danger">*</span></label>
<input type="text" class="form-control Promo_gain" name="gain" value="0" required onchange="return changePromoMsg()" onkeyup="changePromoMsg()"/>
</div>
<p><span class="text-danger">First text</span> <span class="text-primary">Reach</span> <span class="text-info">second Text</span> <span class="text-success">gain</span> <span class="text-dark">third Text</span></p>
<h6><h6 class="Promo_txtmsg text-danger">If you reach 0 i will give you 0</h6> <span class="reqclass"></span></h6>
<hr>
<div class="form-group">
  <label for="exampleFormControlTextarea3">Message 1</label>
  <textarea class="form-control Promo_msg1" name="msg1" placeholder="Enter msg1" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">If you reach</textarea>
</div>

<div class="form-group">
  <label for="exampleFormControlTextarea3">Message 2</label>
  <textarea class="form-control Promo_msg2" name="msg2" placeholder="Enter Comment" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">i will give you</textarea>
</div>
<div class="form-group">
  <label for="exampleFormControlTextarea3">Message 2</label>
  <textarea class="form-control Promo_msg3" name="msg2" placeholder="Enter Comment" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">i will give you</textarea>
</div>
<div class="form-group d-none">
  <label for="exampleFormControlTextarea3">Message 3</label>
  <textarea class="form-control Promo_submit" name="promoMsg" placeholder="Enter Comment" rows="7" ></textarea>
</div>


<div class="form-group">
    <label for="">From Date-To</label>
    <input type="text" class="form-control" name="extended_date" id="extended_date">
    </div>

    <div class="form-group">
    <label for="">Choose Status</label>
<select id="Ultra" name="status"  class="form-control">
     <option value="on" selected>On</option>
     <option value="off">off</option>

</select>
</div>

<div class="form-group">

<button  class="btn btn-danger mycreateProduct" >Submit</button>
</div>


</form>
    `);


    flatpickr('#extended_date',{
    enableTime: true,
  mode: "range",
  minDate: "today",
    //dateFormat: "d-m-Y H:i:s",
    dateFormat: "Y-m-d H:i:s",
    time_24hr: true
    //defaultDate: [start_time, end_time]
});

}
function changePromoMsg(){
    var Promo_reach=$('.Promo_reach').val();
    var Promo_gain=$('.Promo_gain').val();
    var Promo_msg1=$('.Promo_msg1').val();
    var Promo_msg2=$('.Promo_msg2').val();
    var Promo_msg3=$('.Promo_msg3').val();
    $('.Promo_submit').val(`${Promo_msg1} ${Promo_reach} ${Promo_msg2} ${Promo_gain} ${Promo_msg3} `);
    $('.Promo_txtmsg').text(`${Promo_msg1} ${Promo_reach} ${Promo_msg2} ${Promo_gain} ${Promo_msg3}`);

}
function CreatePromotionEvent(){//Company
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");

   $.ajax({

url:`./api/CreatePromotionEvent`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formDataCreate').serialize(),
success:function(data){
if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();

 //ViewAllProducts();

    alert("Promotion Created Successfully");
    $('.formDataCreate :input').val("");
    $('.mycreateProduct').val("Submit");

   // LoadSavedComeFrom();

}
else{
alert("Something is wrong please contact system Admin");
$('.cover-spin').hide();

}



},
error:function(data){
    console.log(data);
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}

function ViewAllPromotionEvent(){
    $('.testModalOrder').modal('show');

    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/ViewAllPromotionEvent`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center"> Safaris</h5>
`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
  <th scope="col">#</th>
  <th scope="col">Name</th>
  <th scope="col">reach</th>
  <th scope="col">gain</th>
  <th scope="col">status</th>
  <th scope="col">started</th>
  <th scope="col">ended</th>
  <th scope="col">Actions</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
 <td data-label="#">${i+1}</td>
  <td data-label="Name">${resultData[i].promoName}</td>
  <td data-label="reach">${resultData[i].reach}</td>
  <td data-label="gain">${resultData[i].gain}</td>
  <td data-label="gain">${resultData[i].status}</td>
  <td data-label="start">${resultData[i].started_date}</td>
  <td data-label="start">${resultData[i].ended_date}</td>
  <td data-label="Actions"><button type="button" class="btn btn-dark" onclick="return ViewPromotion('${encodeURIComponent(JSON.stringify(resultData[i]))}')" >View</button>|<button type="button" class="btn btn-dark" onclick="return EditPromotion('${encodeURIComponent(JSON.stringify(resultData[i]))}')">Edit</button></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);



//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
function ViewPromotion(data)
{
    data=JSON.parse(decodeURIComponent(data));
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>View Promotion</strong></h5>`)
$('.ModalPassword').html(`

<ul class="list-group">
  <li class="list-group-item active">${data.promoName}</li>
  <li class="list-group-item text-danger">Status:${data.status}</li>
  <li class="list-group-item">Title:${data.promo_msg}</li>
  <li class="list-group-item">Reach:${data.reach}$</li>
  <li class="list-group-item">Gain:${data.gain}$</li>
  <li class="list-group-item">Started:${data.started_date}</li>
  <li class="list-group-item">Ended:${data.ended_date}</li>
  <li class="list-group-item">Created:${data.created_at}</li>
</ul>

`);
}
function EditPromotion(data){
    data=JSON.parse(decodeURIComponent(data));
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Promotion</strong></h5>`)
$('.ModalPassword').html(`
<form class="formDataCreate pl-2 pr-2" onsubmit="return EditPromotionEvent()">

<div class="form-group">
<label> Promotion Name <span class="text-danger">*</span></label>
<input type="text" class="form-control" name="promoName" value="${data.promoName}" required/>
<input type="hidden" class="form-control" name="uid" value="${data.uid}" required/>
</div>
<div class="form-group">

<div class="form-group">
<label>Reach<span class="text-danger">*</span></label>
<input type="text" class="form-control Promo_reach" name="reach" value="${data.reach}" required onchange="return changePromoMsg()" onkeyup="changePromoMsg()"/>
</div>

<div class="form-group">
<label>Bonus<span class="text-danger">*</span></label>
<input type="text" class="form-control Promo_gain" name="gain" value="${data.gain}" required onchange="return changePromoMsg()" onkeyup="changePromoMsg()"/>
</div>
<p><span class="text-danger">First text</span> <span class="text-primary">Reach</span> <span class="text-info">second Text</span> <span class="text-success">gain</span> <span class="text-dark">third Text</span></p>
<h6><h6 class="Promo_txtmsg text-danger">If you reach 0 i will give you 0</h6> <span class="reqclass"></span></h6>
<hr>
<div class="form-group">
  <label for="exampleFormControlTextarea3">Message 1</label>
  <textarea class="form-control Promo_msg1" name="msg1" placeholder="Enter msg1" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">If you reach</textarea>
</div>

<div class="form-group">
  <label for="exampleFormControlTextarea3">Message 2</label>
  <textarea class="form-control Promo_msg2" name="msg2" placeholder="Enter Comment" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">i will give you</textarea>
</div>
<div class="form-group">
  <label for="exampleFormControlTextarea3">Message 2</label>
  <textarea class="form-control Promo_msg3" name="msg2" placeholder="Enter Comment" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">i will give you</textarea>
</div>
<div class="form-group d-none">
  <label for="exampleFormControlTextarea3">Message 3</label>
  <textarea class="form-control Promo_submit" name="promoMsg" placeholder="Enter Comment" rows="7" ></textarea>
</div>


<div class="form-group">
    <label for="">From Date-To</label>
    <input type="text" class="form-control" name="extended_date" id="extended_date">
    </div>

    <div class="form-group">
    <label for="">Choose Status</label>
<select id="Ultra" name="status"  class="form-control">
     <option value="on" selected>On</option>
     <option value="off">off</option>

</select>
</div>

<div class="form-group">

<button  class="btn btn-danger mycreateProduct" >Submit</button>
</div>


</form>

`);


flatpickr('#extended_date',{
    enableTime: true,
  mode: "range",
  minDate: "today",
    //dateFormat: "d-m-Y H:i:s",
    dateFormat: "Y-m-d H:i:s",
    time_24hr: true
    //defaultDate: [start_time, end_time]
});
$('#extended_date').val(`${data.started_date} to ${data.ended_date}`);
    return false;
}

function EditPromotionEvent(){//Company
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");

   $.ajax({

url:`./api/EditPromotionEvent`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formDataCreate').serialize(),
success:function(data){
if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();

 //ViewAllProducts();

    alert("Promotion Edited Successfully");
    $('.formDataCreate :input').val("");
    $('.mycreateProduct').val("Submit");

   // LoadSavedComeFrom();

}
else{
alert("Something is wrong please contact system Admin");
$('.cover-spin').hide();

}



},
error:function(data){
    console.log(data);
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}



//CardCode

//Quickie Bonus //

function SetupQuickBonusMenu(){

    $('.Gift').hide();
      $('.Money').show();
    $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
    closeNav();
    $('.MainForm').html(`
    <h5 class="text-center">Setup Quick Bonus</h5>

    <form class="formDataCreate" onsubmit="return SetupQuickBonus()">

<div class="form-group right-inner-addon">
<label> Product Name <span class="text-danger">*</span></label>
<input type="text" class="form-control productCodeClass"  autocomplete="off" onkeyup="autoCompleteQuickBonus(this)" name="productName" required/>
<span class="autocompleteIcon"><i class="fas fa-exclamation-triangle text-danger"></i></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>

<div class="form-group">
<label>Price<span class="text-danger">*</span></label>
<input type="text" class="form-control productCodePriceClass" name="price" value="0" required />
</div>
<div class="form-group">
    <label for="">Choose Bonus Type</label>
<select id="Ultra" name="bonusType"  class="form-control" onchange="return CheckQuickBonus(this)">

     <option value="Money" selected>Money</option>
     <option value="Gift" >Gift</option>

</select>
</div>

<p class="text-danger">Bonus Calculator</p>
<div class="form-group">
<label>Qty <span class="text-danger">*</span></label>
<input type="text" class="form-control bonusQty" name="qty" value="0" required />
</div>

<div class="Money">


<div class="form-group">
<label>Bonus in USD<span class="text-danger">*</span></label>
<input type="text" class="form-control" value="0" required onchange="return BonusValueCalcul(this)" onkeyup="BonusValueCalcul(this)" placeholder="Enter Bonus you will give him for that Qty"/>
</div>

<div class="form-group">
<label>Bonus Value Per Pc in USD<span class="text-danger">*</span></label>
<input type="text" class="form-control bonusValue" name="bonusValue" value="0" required />
</div>

<div class="form-group">
<label>Minimum Price<span class="text-danger">*</span></label>
<input type="text" class="form-control " name="moneyMin" value="0" required />
</div>
</div>
<div class="Gift">
<div  class="form-group right-inner-addon">
<label>Gift Name<span class="text-danger">*</span></label>
<input type="text" class="form-control productCodeGiftClass"  autocomplete="off" onkeyup="autoCompleteGiftQuickBonus(this)" name="giftName" value="0" required />
<span class="autocompleteGiftIcon"><i class="fas fa-exclamation-triangle text-danger"></i></span>
</div>

<ul class="list-group  autoCompleteGiftTopItem">

</ul>


<div class="form-group">
<label>Stock Price<span class="text-danger">*</span></label>
<input type="text" class="form-control productGiftPriceClass" name="giftValues" value="0" required />
</div>

<div class="form-group">
<label>Bonus <span class="text-danger">*</span></label>
<input type="text" class="form-control" value="0" required onchange="return giftBonusValueCalcul(this)" onkeyup="giftBonusValueCalcul(this)" placeholder="Enter Bonus you will give him for that Qty"/>
</div>

<div class="form-group">
<label>Bonus Value Per Pc in USD<span class="text-danger">*</span></label>
<input type="text" class="form-control giftPerPcs" name="giftPerPcs" value="0" required />
</div>

<div class="form-group">
<label>Minimum Gift<span class="text-danger">*</span></label>
<input type="text" class="form-control " name="giftMin" value="0" required />
</div>
</div>

<div class="form-group">
  <label for="exampleFormControlTextarea3">Description</label>
  <textarea class="form-control Promo_msg1" name="description" placeholder="Enter msg1" rows="2" onchange="return changePromoMsg()" onkeyup="changePromoMsg()">If you reach</textarea>
</div>


<div class="form-group">

<button  class="btn btn-danger mycreateProduct" >Submit</button>
</div>


</form>
    `);




}
function autoCompleteStock(thisdata)
{
    $('.autocompleteIcon').html(`<i class="fas fa-exclamation-triangle text-danger onclick="hidePopup()"></i>`);
    //
        if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/Products`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        //"Authorization": `Bearer ${Usertoken}`
    },
    headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
    productCode:thisdata.value,
    productName:"none",
    productQr:"none",
    isProductAction:"search",//product get Action(search,edit,view)
    LimitStart:1,  //page
    LimitEnd:10,
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){
     console.log(data);

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemStock('${btoa(data[i].productCode)}','${btoa(data[i].price)}')">
    ${data[i].productCode}=>${data[i].ProductName}${data[i].pcs} Pcs=>${data[i].tags}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteTopItem').html(getdata);







}
else{
    isAvailable=true;

    $('.isProductExist').show();
    $('.isProductNotExist').show();
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}
function autoCompleteSpendPurpose(thisdata)
{
    $('.autocompleteIcon').html(`<i class="fas fa-exclamation-triangle text-danger onclick="hidePopup()"></i>`);
    //
        if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/searchSpendPurpose`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        //"Authorization": `Bearer ${Usertoken}`
    },
    headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
    purpose:thisdata.value,
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){
     console.log(data);

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemStock('${btoa(data[i].productCode)}','${btoa(data[i].price)}')">
    ${data[i].purpose}=>${data[i].amount}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteTopItem').html(getdata);







}
else{
    isAvailable=true;
    $('.productCodePopup').val("productDataExistandCode");
    $('.isProductExist').hide();
    $('.isProductNotExist').show();
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}
function addItemQuickBonus(itemName,itemPrice){
    $('.productCodeClass').val(itemName);
    $('.productCodePriceClass').val(itemPrice);
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
    $('.autocompleteIcon').html(`<i class="fas fa-check text-success"></i>`);
}
function addItemStock(itemName,itemPrice){

console.log(data.safariuid);
    var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/IsProductExist`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        //"Authorization": `Bearer ${Usertoken}`
    },
    headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
   "safariId":data.safariuid,
   "productCode":atob(itemName)
},
success:function(data){
if(data.status){//return data as true


alert("product is already exist in this safari");


}
else{

    $('.productCodeClass').val(atob(itemName));
    $('.productCodePriceClass').val(atob(itemPrice));
    $('.productCodePopup').val("productDataExistandCode");
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
    $('.autocompleteIcon').html(`<i class="fas fa-check text-success"></i>`);
    $('.isProductExist').hide();
    $('.isProductNotExist').hide();

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}


function autoCompleteGiftQuickBonus(thisdata)
{
    $('.autocompleteGiftIcon').html(`<i class="fas fa-exclamation-triangle text-danger">`);
        //
        if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`https://stock.appdev.live/api/viewSearchAllStock`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        //"Authorization": `Bearer ${Usertoken}`
    },
data:{
    productCode:thisdata.value,
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteGiftTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){
     console.log(data);

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemGiftQuickBonus('${data[i].productCode}','${data[i].price}')">
    ${data[i].productCode}=>${data[i].tags}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteGiftTopItem').html(getdata);




}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}
function addItemGiftQuickBonus(itemName,itemPrice){
    $('.productCodeGiftClass').val(itemName);
    $('.productGiftPriceClass').val(itemPrice);
    $('.autoCompleteGiftTopItem').html("");
    $('.autoCompleteGiftTopItem').hide();
    $('.autocompleteGiftIcon').html(`<i class="fas fa-check text-success"></i>`);
}

function checkGiftMoney(thisData)
{
    if(thisData.value=='Gift')
    {
      $('.Gift').show();
      $('.Money').hide();
    }
    else{
    $('.Gift').hide();
      $('.Money').show();
    }

}
function CheckQuickBonus(thisData){
 console.log(thisData.value);


 checkGiftMoney(thisData);


    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/CheckQuickBonus`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
    bonusType:thisData.value,
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center"> Safaris</h5>
`);
$('.MyRequest_table').html("");

}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;


}

function BonusValueCalcul(thisData)
{
    var bonusQty=$('.bonusQty').val();//as reference qty
    $('.bonusValue').val(parseInt(thisData.value)/parseInt(bonusQty));


}
function giftBonusValueCalcul(thisData)
{
    var bonusQty=$('.bonusQty').val();
    $('.giftPerPcs').val(parseInt(thisData.value)/parseInt(bonusQty));

}

function SetupQuickBonus(){//Company
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");

   $.ajax({

url:`./api/SetupQuickBonus`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formDataCreate').serialize(),
success:function(data){
if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();

 //ViewAllProducts();

    alert("Promotion Created Successfully");
    $('.formDataCreate :input').val("");
    $('.mycreateProduct').val("Submit");

   // LoadSavedComeFrom();

}
else{
alert("Something is wrong please contact system Admin");
$('.cover-spin').hide();

}



},
error:function(data){
    console.log(data);
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}
//Quickie Bonus //

/*New SafariStock Code */
function CheckSafariStock(){

closeNav();

/*  $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
$('.MainForm').html("");*/
SafariStockForm();
//$('.viewOrder').modal('show');
return false;
}

function LoadSafariStockAddItemBtnTemplate(data){

$('.MainbigTitle').html(`
<h5 class="text-center d-none"> <button type="button" class="btn btn-danger" onclick="return FormCloseStockSafari('${data.safariuid}')">Close Safari</button></h5>
`);
$('.MyRequest_table').html("");
var getData=`
<hr>
<h6 class="text-center text-danger">${data.name}</h6>
<hr>

<div class="pb-2 ">
<button type="button" class="btn btn-danger" onclick="return spendButton('${btoa(JSON.stringify(data))}')">Spending</button>


<button type="button" class="btn btn-dark" onclick="return gainButton('${btoa(JSON.stringify(data))}')">Gain</button>


</div>
`;




$('.MainForm').html(getData);
}
function LoadSafariStockItemTemplate(data,safariName){
    //
console.log(data);
    /*var resultDataInterest=data.CalculateInterest;
    var resultData=data.ProductResult;
    var resultDataSpend=data.OtherSpend;*/


$('.MainbigTitle').html(`
<h5 class="text-center d-none"> <button type="button" class="btn btn-danger" onclick="return FormCloseStockSafari('${data.safariuid}')">Close Safari</button></h5>

`);
$('.MyRequest_table').html("");



getData=`
<h6 class="text-center"><span class="text-primary">${atob(safariName)}</span></h6>
<h6 class="text-right ${(data.interest[0].buyout==null?"d-none":"")}"><span class="text-primary">Total Buyout:</span>${data.interest[0].buyout} $</h6>

<h6 class="text-right ${(data.interest[0].Soldout==null?"d-none":"")}"><span class="text-primary">Tot SoldOut Price:</span><span>${data.interest[0].Soldout} $</span></h6>
<h6 class="text-right"><hr></h6>
<h6 class="text-right ${(data.interest[0].interest==null?"d-none":"")}"><span class="text-danger">Profit</span>:<span >${data.interest[0].interest}</span></h6>
<div class="flex-center">


<div class="form-group">
<label>Safari Name:${atob(safariName)}</label>

</div>
<div class="form-group ${(data.interest[0].TotQty==null?"d-none":"")}">
<label title="Total Qty">Total Qty:${data.interest[0].TotQty}</label>

</div>

<div class="form-group  ${(data.interest[0].QtySoldOut==null?"d-none":"")}">
<label title="Total Qty SoldOUT">SoldOut:<span>${data.interest[0].QtySoldOut} </span></label>

</div>
<div class="form-group">
<label title="Total Qty LEFT">Qty Left:<span>${(data.interest[0].TotQty)-(data.interest[0].QtySoldOut)} </span></label>

</div>



</div>
<div class="pb-2">
<button type="button" class="btn btn-dark" onclick="return FormCalcItemSafariStock('${btoa(JSON.stringify(data))}','spendProduct')">Products</button>

<button type="button" class="btn btn-danger d-none" onclick="return FormAddItemSafariStockSpent('${btoa(JSON.stringify(data))}','spendSafari')">Others</button>
</div>
<div class="pb-2 d-none">
<button type="button" class="btn btn-danger" onclick="return spendButton('${btoa(JSON.stringify(data))}')">Spending</button>


<button type="button" class="btn btn-dark" onclick="return gainButton('${btoa(JSON.stringify(data))}')">Gain</button>


</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">By</button>
    <div class="dropdown-menu">
    <a class="dropdown-item" href="#SearchByCode" onclick="return chooseSearchStock('${chooseSearchStock}')">Code</a>
      <a class="dropdown-item" href="#SearchByName" onclick="return chooseSearchStock('${chooseSearchStock}')">name</a>
    </div>
  </div>

  <input type="text" class="form-control searchProductTable" aria-label="Text input with dropdown button" placeholder="Search by Code" onkeyup="return SeachProductStock('${safariName}','${data.safariuid}',this)">
</div>
`;
//console.log(data);

getData+=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Fact Price $</th>
<th scope="col">Init qty</th>
<th scope="col">Spending</th>
<th scope="col">SoldOut Qty</th>
<th scope="col">SoldOut $</th>
<th scope="col">updated_at</th>



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
  <td data-label="#"><i class="fas fa-trash text-danger mylogout " title="Delete This Product in Safari" onclick="return deleteStockQty('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')"></i>  ${i+1}</td>
  <td data-label="Name">${resultData[i].productCode}</td>
  <td data-label="Fact Price $">
  ${(resultData[i].status!='spendSafaris')?`<span class="Formchange" id="CustomPrice_Add_1" onchange="return  OnChangeFactPrice('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" onkeyup="return OnChangeFactPrice('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" contenteditable="true">${resultData[i].price}</span><span class="${"Price_"+(resultData[i].productCode).replace(/[-!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~_.\s'`]/g, '')}"></span>`:'Spending'}
  </td>
  <td data-label="Init qty">
  ${(resultData[i].status!='spendSafaris')?`<span class="Formchange" id="CustomPrice_Add_1 test" onchange="return  OnChangeInitQty('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" onkeyup="return OnChangeInitQty('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" contenteditable="true">${resultData[i].totQty}</span><span class="${"Qty_"+(resultData[i].productCode).replace(/[-!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~_.\s'`]/g, '')}"></span>`:'Spending'}
 </td>
  <td data-label="Spending">${resultData[i].TotBuyAmount}</td>
  <td data-label="SoldOut Qty">${resultData[i].SoldOut}</td>
  <td data-label="SoldOut $">${resultData[i].TotSoldAmount}</td>
  <td data-label="updated_at">${resultData[i].updated_at}</td>



</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);


    //
}

function chooseSearchStock(optionsearch)
{
    if(optionsearch==="1")
    {
        chooseSearchStock=optionsearch;

        $(".searchProductTable").attr("placeholder", "Search By Code");

    }
    else{
        chooseSearchStock=optionsearch;

        $(".searchProductTable").attr("placeholder", "Search By Product Name");
    }
}
function SeachProductStock(safariName,safariId,thisData)
{
    console.log(safariId);
   var searchProductTable=$('.searchProductTable').val();
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/displayCalculate`,
type:'get',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
"safariId":safariId,
"name":"Mbona",
"actionStatus":"Search",
"productSearch":thisData.value,
"isproductCode":(chooseSearchStock===1)?"true":"false"


},
success:function(data){
if(data.status){//return data as true
$('.cover-spin').hide();

 getData="";
var resultData=data["result"];
 for(var i=0;i<resultData.length;i++){
 var resultObject=resultData[i];
     getData+=`  <tr>
  <td data-label="#"><i class="fas fa-trash text-danger mylogout " title="Delete This Product in Safari" onclick="return deleteStockQty('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')"></i>  ${i+1}</td>
  <td data-label="Name">${resultData[i].productCode}</td>
  <td data-label="Fact Price $">
  ${(resultData[i].status!='spendSafaris')?`<span class="Formchange" id="CustomPrice_Add_1" onchange="return  OnChangeFactPrice('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" onkeyup="return OnChangeFactPrice('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" contenteditable="true">${resultData[i].price}</span><span class="${"Price_"+(resultData[i].productCode).replace(/[-!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~_.\s'`]/g, '')}"></span>`:'Spending'}
  </td>
  <td data-label="Init qty">
  ${(resultData[i].status!='spendSafaris')?`<span class="Formchange" id="CustomPrice_Add_1 test" onchange="return  OnChangeInitQty('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" onkeyup="return OnChangeInitQty('${btoa(JSON.stringify(resultObject))}',this,'${safariName}')" contenteditable="true">${resultData[i].totQty}</span><span class="${"Qty_"+(resultData[i].productCode).replace(/[-!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~_.\s'`]/g, '')}"></span>`:'Spending'}
 </td>
  <td data-label="Spending">${resultData[i].TotBuyAmount}</td>
  <td data-label="SoldOut Qty">${resultData[i].SoldOut}</td>
  <td data-label="SoldOut $">${resultData[i].TotSoldAmount}</td>
  <td data-label="updated_at">${resultData[i].updated_at}</td>



</tr>`;

 }
 $('.viewReqTable tbody').html(getData);




}
else{
    $('.cover-spin').hide();
//alert("This Product has been used Please Contact System Admin if you want to edit this Quantity");

}



},
error:function(data){
     $('.cover-spin').hide();
}
});
}
function OnChangeInitQty(dataPass,thisdata,safari)
{



    var initQty=Number(thisdata.innerText);
    if (!(typeof(initQty) === "number" && initQty >= 0)) return null;
    console.log(dataPass);
    data=atob(dataPass);
    data=JSON.parse(data);
    console.log(data);
    var classData=(data["productCode"]).replace(/[-!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~_.\s'`]/g, '');
    console.log(classData);
    //classData=atob(classData);
   // classData="YWtheXVuZ2lybyBrYW5pbmkga2ljeWF5aSAoNTAgZHpuKQ==";

    $(`.${"Qty_"+classData}`).html(`<i class="fas fa-check text-success mylogout" onclick="return EditStockQty('${dataPass}','${btoa(initQty)}','${safari}')"></i>`);

}
function EditStockQty(dataPass,initQty,safari)
{
    dataV=atob(dataPass);
   dataV=JSON.parse(dataV);
    $('.cover-spin').show();

var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/EditStockQty`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
productCode:dataV["productCode"],
safariId:dataV["safariId"],
prevQty:dataV["totQty"],
qty:atob(initQty),


},
success:function(data){
if(data.status){//return data as true
$('.cover-spin').hide();

var safariId=btoa(dataV["safariId"]);

ViewItemSafariStock(safariId,safari);


}
else{
    $('.cover-spin').hide();
alert("This Product has been used Please Contact System Admin if you want to edit this Quantity");

}



},
error:function(data){
    $('.cover-spin').hide();
}
});
}
function deleteStockQty(dataPass,initQty,safari)
{
    dataV=atob(dataPass);
   dataV=JSON.parse(dataV);
    if(confirm(`Do you Want Delete ${dataV["ProductName"]} in this Safari?`))
    {

    $('.cover-spin').show();

var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/deleteStockQty`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
productCode:dataV["productCode"],
safariId:dataV["safariId"]



},
success:function(data){
if(data.status){//return data as true
$('.cover-spin').hide();

var safariId=btoa(dataV["safariId"]);

ViewItemSafariStock(safariId,safari);


}
else{
    $('.cover-spin').hide();
alert("This Product has been used Please Contact System Admin if you want to edit this Quantity");

}



},
error:function(data){
    $('.cover-spin').hide();
}
});
}
}
function OnChangeFactPrice(dataPass,thisdata,safari)
{
    var factPrice=Number(thisdata.innerText);
    if (!(typeof(factPrice) === "number" && factPrice >= 0)) return null;
    console.log(dataPass);
    data=atob(dataPass);
    data=JSON.parse(data);
    console.log(data);
    var classData=(data["productCode"]).replace(/[-!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~_.\s'`]/g, '');
    $(`.${"Price_"+classData}`).html(`<i class="fas fa-check text-success mylogout" onclick="return EditStockFactPrice('${dataPass}','${btoa(factPrice)}','${safari}')"></i>`);
}
function EditStockFactPrice(dataPass,factPrice,safari)
{
    dataV=atob(dataPass);
    dataV=JSON.parse(dataV);
    $('.cover-spin').show();

var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/EditStockFactPrice`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
productCode:dataV["productCode"],
safariId:dataV["safariId"],
price:atob(factPrice),


},
success:function(data){
if(data.status){//return data as true
$('.cover-spin').hide();

var safariId=btoa(dataV["safariId"]);

ViewItemSafariStock(safariId,safari);


}
else{
    $('.cover-spin').hide();
alert("This Product has been used Please Contact System Admin if you want to edit this Factory Price");

}



},
error:function(data){
    $('.cover-spin').hide();
}
});
}

function ViewEditItemSafariStock(id,uid,safariuid,qty,price,pcs,comment,name,SoldInterest){


$('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Item</strong></h5>`)
$('.ModalPassword').html(`

<form class="formEditItemSafariStock" onsubmit="return SafariStockEditItem()">
<div class="p-2">
<div class="form-group ">
<input type="hidden" class="form-control" name="id" value="${atob(id)}"/>
<input type="hidden" class="form-control" name="safariuid" value="${atob(safariuid)}"/>
<input type="hidden" class="form-control" name="name" value="${atob(name)}"/>
<input type="hidden" class="form-control" name="SoldInterest" value="${atob(SoldInterest)}"/>


</div>

<div class="form-group ">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="uid" onkeyup="SafariStockautoCompleteTopItem(this,'${btoa('product')}')" value="${atob(uid)}" required/>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" value="${atob(qty)}" required/>
</div>

<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" value="${atob(price)}" required/>
</div>

<div class="form-group ">
<label>pcs in 1BDS</label>
<input type="text" class="form-control" name="pcs" value="${atob(pcs)}" required/>
</div>

<div class="form-group">
<label for="exampleFormControlTextarea3">Enter Comment</label>
<textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7">${atob(comment)}</textarea>
</div>




<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`);
EmptyautoCompleteTopItem();
}
function OnChangeSoldIntStock(thisdata,id,uid,safariuid,qty,price,pcs,comment,name,SoldInterest){
   // $('.cover-spin').show();
  //console.log(thisdata.innerHTML);
  var solidData=Number(thisdata.innerHTML);
  if(isNaN(solidData)) {
  console.log("num is a number");
}
else{
    if(solidData=="")
    {
        console.log("empty");
    }
    else{
        //console.log(solidData);
        //
        var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariStockEditItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
    id:atob(id),
    uid:atob(uid),
    safariuid:atob(safariuid),
    qty:atob(qty),
    price:atob(price),
    pcs:atob(pcs),
    comment:atob(comment),
    name:atob(name),
    SoldInterest:solidData

},
success:function(data){
if(data.status){//return data as true
   // $('.cover-spin').hide();
    //console.log(`done $${CalculateDeclClass}`);
    $('.viewOrder').modal('hide');
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariId=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafari(safariId,safariName);
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
        //
    }

}
return false;
}
function SafariStockEditItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariStockEditItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formEditItemSafari').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    //console.log(`done $${CalculateDeclClass}`);
    $('.viewOrder').modal('hide');
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariuid=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafari(safariuid,safariName);
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}
function DeleteItemSafariStock(id,uid,name,profit,transpfees){
    if(confirm(`Do you Want Delete ${name} in this Safari?`))
    {
        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeleteItemSafariStock`,//close Safari
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    id:id,
    uid:uid,
    profit:profit,
    transpfees:transpfees
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();

   alert("Close Query Submitted Successfully")
   CheckSafariStock();

}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;

    }

}
function FormCloseSafariStock(uid){
    if(confirm('Do you Want to Close this Safari?'))
    {
        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminCloseSafariStock`,//close Safari
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();

   alert("Close Query Submitted Successfully")
   AllOpenSaleReport();

}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
    }

}
function SafariStockForm(){

    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Create Safari</strong></h5>`)
$('.ModalPassword').html(`
<form class="formSafariCreate" onsubmit="return formSafariStockCreate()">
<div class="p-2">
<div class="form-group ">
<label>Enter Name</label>
<input type="text" class="form-control" name="name" required/>
</div>

<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}

function formSafariStockCreate(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/CreateSafari`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formSafariCreate').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    ViewSafariStock('name',false);
    //LoadSafariStockItemTemplate(data);
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}

function gainButton(dataPass){

//show gainButtons
data=atob(dataPass);
    data=JSON.parse(data);
    console.log(data);
$('.MainbigTitle').html(`
<h5 class="text-center d-none"> <button type="button" class="btn btn-danger" onclick="return FormCloseStockSafari('${data.safariuid}')">Close Safari</button></h5>
`);
$('.MyRequest_table').html("");
var getData=`
<hr>
<h4 class="text-center text-primary">Gaining </h4>
<h6 class="text-center text-danger">${data.name}</h6>
<hr>
<div class="pb-2">
<button type="button" class="btn btn-dark" onclick="return FormCalcItemSafariStock('${dataPass}','gainProduct')">Product</button>

<button type="button" class="btn btn-danger" onclick="return FormAddItemSafariStockSpent('${dataPass}','gainOthers')">Others</button>
</div>
`;




$('.MainForm').html(getData);
}
function spendButton(dataPass){
    data=atob(dataPass);
    data=JSON.parse(data);
//show spendButtons
$('.MainbigTitle').html(`
<h5 class="text-center d-none"> <button type="button" class="btn btn-danger" onclick="return FormCloseStockSafari('${data.safariuid}')">Close Safari</button></h5>
`);
$('.MyRequest_table').html("");
var getData=`
<hr>
<h4 class="text-center text-danger">Spending </h4>
<h6 class="text-center text-danger">${data.name} </h6>

<hr>
<div class="pb-2">
<button type="button" class="btn btn-dark" onclick="return FormCalcItemSafariStock('${dataPass}','spendProduct')">Products</button>

<button type="button" class="btn btn-danger" onclick="return FormAddItemSafariStockSpent('${dataPass}','spendSafari')">Others</button>
</div>
`;




$('.MainForm').html(getData);

}
function FormCalcItemSafariStock(dataPass,status)
{
    data=atob(dataPass);
    data=JSON.parse(data);
    console.log(data);
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item ${data.name}</strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemSafariStock" onsubmit="return SafariStockAddItem()">
<div class="p-2">

<div class="form-group d-none">
<label>Safari Name</label>
<input type="text" class="form-control" name="name" value="${data.name}"/>
<input type="hidden" class="form-control" name="uid" value="${data.safariuid}"/>
</div>
<div class="form-group ">

<input type="hidden" class="form-control" name="safariId" value="${data.safariuid}"/>

<input type="hidden" class="form-control" name="status" value="${status}"/>
<input type="hidden" class="form-control" name="typeData" value="spend"/>

</div>
<div class="form-group right-inner-addon">
<label>Search Product<span class="text-danger">*</span></label>
<input type="text" class="form-control productCodeClass"  autocomplete="off" onkeyup="autoCompleteStock(this)" name="productCode" placeholder="Enter Product Code" required/>
<span class="autocompleteIcon" onclick="hidePopup()"><i class="fas fa-exclamation-triangle text-danger" ></i></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group isProductExist">
<label>Product Name</label>
<input type="text" class="form-control productCodeClass productCodePopup" name="productName"  required/>
</div>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" value="0" />
</div>
<div class="form-group ">
<label>Factory Price</label>
<input type="number" class="form-control" name="fact_price" />
</div>

<div class="form-group isProductNotExist">
<label>Price</label>
<input type="number" class="form-control" name="price" />
</div>


<div class="form-group ComeFromLoader isProductNotExist">

</div>

<div class="form-group isProductNotExist">
<label>Pcs</label>
<input type="text" class="form-control" name="pcs" />
</div>
<div class="form-group isProductNotExist">
<label>tags</label>
<input type="text" class="form-control" name="tags" />
</div>
<div class="form-group d-none">
<label>Active</label>
<input type="text" class="form-control" name="active" value="on"/>
<input type="text" class="form-control" name="CommentStatus" value="Inserting Product"/>
</div>


<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="description" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
LoadSavedComeFrom();
    //

}
function hidePopup(){
    $('.productCodePopup').val("");
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
    $('.autocompleteIcon').html(`<i class="fas fa-check text-success"></i>`);
    $('.isProductExist').show();
    $('.isProductNotExist').show()
}

function FormAddItemSafariStockSpent(dataPass,status)
{
    data=atob(dataPass);
    data=JSON.parse(data);
    console.log(data);
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item ${data.name}</strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemSafariStock" onsubmit="return SafariSpendAddItem()">
<div class="p-2">

<div class="form-group d-none">
<label>Safari Name</label>
<input type="text" class="form-control" name="safariName" value="${data.name}"/>
<input type="text" class="form-control" name="uid" value="${data.safariuid}"/>
</div>
<div class="form-group ">

<input type="hidden" class="form-control" name="safariId" value="${data.safariuid}"/>
<input type="hidden" class="form-control" name="options" value="spendSafari"/>



</div>
<div class="form-group right-inner-addon">
<label>Eter Purpose<span class="text-danger">*</span></label>
<input type="text" class="form-control productCodeClass"  autocomplete="off" onkeyup="autoCompleteSpendPurpose(this)" name="purpose" required/>
<span class="autocompleteIcon" onclick="hidePopup()"><i class="fas fa-exclamation-triangle text-danger" ></i></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>




<div class="form-group ">
<label>Price</label>
<input type="number" class="form-control" name="balance" required/>
</div>








<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="commentData" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)

    //

}
function FormCalcItemSafariStock2(dataPass,status){

$('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item ${atob(safariName)}</strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemSafari" onsubmit="return SafariAddItem()">
<div class="p-2">
<div class="form-group ">


<input type="hidden" class="form-control" name="safariuid" value="${atob(safariuid)}"/>
<input type="hidden" class="form-control" name="name" value="${atob(safariName)}"/>
<input type="hidden" class="form-control" name="typeData" value="product"/>

</div>

<div class="form-group right-inner-addon">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="uid" onkeyup="SafariautoCompleteTopItem(this,'${btoa("product")}')" required/>
<span class="autocompleteIcon"></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" required/>
</div>
<div class="form-group ">
<label>Add Pcs in 1BDS</label>
<input type="text" class="form-control" name="pcs" />
</div>
<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" required/>
</div>


<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" placeholder="Enter Comment" rows="7"></textarea>
</div>


<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}


function EmptyautoCompleteTopItem(){
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
    $('.autocompleteIcon').html("");
}
function SafariautoCompleteTopItem(thisdata,typeData){
//

if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/SafariStockItemSearch`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    ItemName:thisdata.value,
    typeData:atob(typeData)
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemDeclar('${data[i].uid}')">
    ${data[i].uid}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteTopItem').html(getdata);
 $(`.autocompleteIcon`).html(`<i class="fa fa-times-circle text-danger" onclick="return EmptyautoCompleteTopItem()"></i>`);



}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
//
}
function addItemStockDeclar(itemName){
    $('.item_nameAdd').val(itemName);
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
}
function SafariStockAddItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/CreateStockProduct`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formAddItemSafariStock').serialize(),
success:function(data){
if(data.status){//return data as true
    console.log(data);
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
   // console.log(`done $${CalculateDeclClass}`);

    $('.formAddItemSafari .form-control').val("");
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariuid=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafariStock(safariuid,safariName);
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    $('.cover-spin').hide();
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}



function AdminSafariStockCalculate(uid,plaque,transpfees,profit,totClass){
    var totalqty=$(`.${totClass}`).text();
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminSafariStockCalculate`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
    plaque:plaque,
    transpfees:transpfees,
    profit:profit,
    totalqty:totalqty
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    console.log(data.xdata);
    CheckSafari();
 //console.log(hashfunction);


}
else{
    alert("already updated");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}

function ViewSafariStock(name,searchVal){
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/GetSafaris`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
    searchOption:searchVal,
    name:name,
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center"> Safaris</h5>

`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Comment</th>
<th scope="col">Created At</th>
<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Name">${resultData[i].name}</td>
  <td data-label="Comment">${resultData[i].comment}</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>
  <td data-label="Action"><i class="fas fa-eye text-primary mylogout" title="View Safari Items Load" onClick="return ViewItemSafariStock('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}')"></i> <i class="fas fa-edit text-primary mylogout" title="Edit this Safari" onClick="return ViewEditSafari('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}','${btoa(resultData[i].comment)}','${btoa(resultData[i].uidCreator)}','${btoa(resultData[i].subscriber)}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Safari" onClick="return DeleteSafari('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}','${btoa(resultData[i].comment)}','${btoa(resultData[i].uidCreator)}','${btoa(resultData[i].subscriber)}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);



//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
function ViewEditSafariStock(uid,name,comment,uidCreator,subscriber){
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Safari</strong></h5>`)
$('.ModalPassword').html(`
<form class="formSafariEdit" onsubmit="return SafariEdit()">
<div class="p-2">
<div class="form-group ">
<label>Name</label>
<input type="hidden" class="form-control" name="uid" value="${atob(uid)}" required/>
<input type="text" class="form-control" name="name" value="${atob(name)}" required/>
</div>

<div class="form-group ">
<label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7">${atob(comment)}</textarea>

</div>





<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}
function SafariStockEdit(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/EditSafari`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formSafariStockEdit').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    ViewSafariStock('name',false);
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}

function ViewItemSafariStock(uid,name){

    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/displayCalculate`,
type:'get',
data: {
safariId:atob(uid),
name:atob(name),
actionStatus:"calculInterest",
productSearch:"t",
isproductCode:"false"
},
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true

LoadSafariStockItemTemplate(data,name);



}
else{
    LoadSafariStockAddItemBtnTemplate(data);
$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}



/*New SafariStock Code */

//SafariCode Javascript//
function CheckSafari(){

    closeNav();

  /*  $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
$('.MainForm').html("");*/
    SafariForm();
    //$('.viewOrder').modal('show');
    return false;
}
function LoadSafariAddItemBtnTemplate(data){
    $('.MainbigTitle').html(`
<h5 class="text-center d-none"> <button type="button" class="btn btn-danger" onclick="return FormCloseSafari('${data.safariuid}')">Close Safari</button></h5>
`);
$('.MyRequest_table').html("");
var getData=`
<hr>
<h6 class="text-center text-danger">${data.name}</h6>
<hr>
<div class="pb-2">
<button type="button" class="btn btn-dark" onclick="return FormAddItemSafari('${btoa(data.safariuid)}','${btoa(data.name)}')">Add Product Item</button>

<button type="button" class="btn btn-primary" onclick="return FormAddItemSafariSpent('${btoa(data.safariuid)}','${btoa(data.name)}')">Add Spending</button>
</div>
`;




$('.MainForm').html(getData);
}

function LoadSafariItemTemplate(data){
    //

    var resultDataInterest=data.CalculateInterest;
    var resultData=data.ProductResult;
    var resultDataSpend=data.OtherSpend;


$('.MainbigTitle').html(`
<h5 class="text-center d-none"> <button type="button" class="btn btn-danger" onclick="return FormCloseSafari('${data.safariuid}')">Close Safari</button></h5>
`);
$('.MyRequest_table').html("");

getSpending=`
<hr>
<h6 class="text-center text-danger">Spending Table</h6>
<hr>
<table class="viewReqTable mytable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col" title="Price of All Qty Before any other spend">Price A</th>

<th scope="col">Comment</th>
<th scope="col">Created at</th>


</tr>
</thead>
<tbody>
`;
for(var i=0;i<resultDataSpend.length;i++){

getSpending+=`

<tr>
 <td data-label="#">${i+1}</td>
 <td data-label="Name">${resultDataSpend[i].name}</td>
 <td data-label="Price A" title="Price of All Qty Before any other spend">${resultDataSpend[i].price}</td>

 <td data-label="comment" >${resultDataSpend[i].comment}</td>
 <td data-label="created_at" >${resultDataSpend[i].created_at}</td>



</tr>`;

}
getSpending+=`
</tbody>
</table>`;

getData=`
<h6 class="text-center"><span class="text-primary">${data.name}</span></h6>
<h6 class="text-right"><span class="text-primary">Total Product:</span>${resultDataInterest.TotalBuyProduct} $</h6>

<h6 class="text-right"><span class="text-primary">Tot Sold Price:</span><span>${resultDataInterest.TotalSoldProduct} $</span></h6>
<h6 class="text-right"><hr></h6>
<h6 class="text-right"><span class="text-danger">Profit</span>:<span >${resultDataInterest.interest}</span></h6>
<div class="flex-center">


<div class="form-group">
<label>Safari Name:${data.name}</label>

</div>
<div class="form-group">
<label title="Total Qty of product">Total Qty:${data.TotalQtyProduct}</label>

</div>

<div class="form-group">
<label title="Total Of Price of Other Spending">Total Price:<span>${data.TotalPriceOtherSpend} $</span></label>

</div>



</div>

<div class="pb-2">

<button type="button" class="btn btn-primary" onclick="return FormAddItemSafariSpent('${btoa(data.safariuid)}','${btoa(data.name)}')">Add Spending</button>
</div>

${getSpending}

<hr>
<h6 class="text-center text-danger">Product Table</h6>
<hr>
<div class="pb-2">
<button type="button" class="btn btn-dark" onclick="return FormAddItemSafari('${btoa(data.safariuid)}','${btoa(data.name)}')">Add Product Item</button>
</div>
<table class="viewReqTable mytable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Qty</th>
<th scope="col" title="Price of All Qty Before any other spend">Price A</th>
<th scope="col">PCS</th>
<th scope="col" title="Price per 1 pieces after any other spend">Price 1PC</th>
<th scope="col" title="Price per 1 Bds after any other spend">Price 1Bds</th>
<th scope="col" title="Price Per Qty after any other spend">Price SumQty</th>

<th scope="col" title="Price That Will Add After Spend">Price A</th>
<th scope="col" title="Add Margin Interest on Sold">Sold Int</th>
<th scope="col" title="Sold Price Per Piece">Sold Price 1PC</th>
<th scope="col" title="Sold Price Per 1BDS">Sold Price 1BDS</th>
<th scope="col" title="Sold Price Per Qty of BDS">Sold Price Qty</th>
<th scope="col">Comment</th>
<th scope="col">Created at</th>






<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Items">${resultData[i].uid}</td>
  <td data-label="Qty">${resultData[i].qty}</td>
  <td data-label="Price A" title="Price of All Qty Before any other spend">${resultData[i].price}</td>
  <td data-label="PCS">${resultData[i].pcs}</td>
  <td data-label="Price 1PC" title="Price per 1 pieces after any other spend" class="text-primary">${resultData[i].pricePerPiece}</td>
  <td data-label="Price 1Bds" title="Price per 1 Bds after any other spend" class="text-primary">${resultData[i].ProductPriceOneQty}</td>
  <td data-label="Price ${resultData[i].qty}Bds" title="Price per ${resultData[i].qty} Bds after any other spend">${resultData[i].ProductPriceNumberQty}</td>

  <td data-label="Price A" title="Price That Will Add After Spend">${resultData[i].PriceToAdd}</td>
  <td data-label="Sold Int" title="Add Margin Interest on Sold"><span class="Formchange" id="CustomPrice_Add_1" onchange="return  OnChangeSoldInt(this,'${btoa(resultData[i].id)}','${btoa(resultData[i].uid)}','${btoa(resultData[i].safariuid)}','${btoa(resultData[i].qty)}','${btoa(resultData[i].price)}','${btoa(resultData[i].pcs)}','${btoa(resultData[i].comment)}','${btoa(data.name)}','${btoa(resultData[i].SoldInterestOneQty)}')" onkeyup="return OnChangeSoldInt(this,'${btoa(resultData[i].id)}','${btoa(resultData[i].uid)}','${btoa(resultData[i].safariuid)}','${btoa(resultData[i].qty)}','${btoa(resultData[i].price)}','${btoa(resultData[i].pcs)}','${btoa(resultData[i].comment)}','${btoa(data.name)}','${btoa(resultData[i].SoldInterest)}')" contenteditable="true">${resultData[i].SoldInterestOneQty}</span></td>
  <td data-label="Sold Price 1PC" title="Sold Price Per Piece" class="text-danger">${resultData[i].SoldPricePerPiece}</td>
  <td data-label="Sold Price 1BDS" title="Sold Price Per 1BDS" class="text-danger">${resultData[i].SoldPriceOneQty}</td>
  <td data-label="Sold Price${resultData[i].qty} Qty" title="Sold Price Per ${resultData[i].qty} Qty of BDS">${resultData[i].SoldPriceNumberQty}</td>
  <td data-label="comment" >${resultData[i].comment}</td>
  <td data-label="created_at" >${resultData[i].created_at}</td>


  <td data-label="Action"><i class="fas fa-edit text-primary mylogout" title="Edit this Items" onClick="return ViewEditItemSafari('${btoa(resultData[i].id)}','${btoa(resultData[i].uid)}','${btoa(resultData[i].safariuid)}','${btoa(resultData[i].qty)}','${btoa(resultData[i].price)}','${btoa(resultData[i].pcs)}','${btoa(resultData[i].comment)}','${btoa(data.name)}','${btoa(resultData[i].SoldInterestOneQty)}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Item" onClick="return DeleteItemSafari('${resultData[i].id}','${resultData[i].uid}','${resultData[i].name}','${data.profit}','${data.transpfees}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);


    //
}
function ViewEditItemSafari(id,uid,safariuid,qty,price,pcs,comment,name,SoldInterest){


    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Item</strong></h5>`)
$('.ModalPassword').html(`

<form class="formEditItemSafari" onsubmit="return SafariEditItem()">
<div class="p-2">
<div class="form-group ">
<input type="hidden" class="form-control" name="id" value="${atob(id)}"/>
<input type="hidden" class="form-control" name="safariuid" value="${atob(safariuid)}"/>
<input type="hidden" class="form-control" name="name" value="${atob(name)}"/>
<input type="hidden" class="form-control" name="SoldInterest" value="${atob(SoldInterest)}"/>


</div>

<div class="form-group ">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="uid" onkeyup="SafariautoCompleteTopItem(this,'${btoa('product')}')" value="${atob(uid)}" required/>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" value="${atob(qty)}" required/>
</div>

<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" value="${atob(price)}" required/>
</div>

<div class="form-group ">
<label>pcs in 1BDS</label>
<input type="text" class="form-control" name="pcs" value="${atob(pcs)}" required/>
</div>

<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7">${atob(comment)}</textarea>
</div>




<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`);
EmptyautoCompleteTopItem();
}
function OnChangeSoldInt(thisdata,id,uid,safariuid,qty,price,pcs,comment,name,SoldInterest){
   // $('.cover-spin').show();
  //console.log(thisdata.innerHTML);
  var solidData=Number(thisdata.innerHTML);
  if(isNaN(solidData)) {
  console.log("num is a number");
}
else{
    if(solidData=="")
    {
        console.log("empty");
    }
    else{
        //console.log(solidData);
        //
        var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariEditItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
//dataType: "json",
data:{
    id:atob(id),
    uid:atob(uid),
    safariuid:atob(safariuid),
    qty:atob(qty),
    price:atob(price),
    pcs:atob(pcs),
    comment:atob(comment),
    name:atob(name),
    SoldInterest:solidData

},
success:function(data){
if(data.status){//return data as true
   // $('.cover-spin').hide();
    //console.log(`done $${CalculateDeclClass}`);
    $('.viewOrder').modal('hide');
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariId=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafari(safariId,safariName);
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
        //
    }

}
return false;
}
function SafariEditItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariEditItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formEditItemSafari').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    //console.log(`done $${CalculateDeclClass}`);
    $('.viewOrder').modal('hide');
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariuid=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafari(safariuid,safariName);
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}
function DeleteItemSafari(id,uid,name,profit,transpfees){
    if(confirm(`Do you Want Delete ${name} in this Safari?`))
    {
        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeleteItemSafari`,//close Safari
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    id:id,
    uid:uid,
    profit:profit,
    transpfees:transpfees
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();

   alert("Close Query Submitted Successfully")
   CheckSafari();

}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;

    }

}
function FormCloseSafari(uid){
    if(confirm('Do you Want to Close this Safari?'))
    {
        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminCloseSafari`,//close Safari
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();

   alert("Close Query Submitted Successfully")
   AllOpenSaleReport();

}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
    }

}
function SafariForm(){

    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center"> <strong>Create Safari</strong></h5>`)
$('.ModalPassword').html(`
<form class="formSafariCreate" onsubmit="return formSafariCreate()">
<div class="p-2">
<div class="form-group ">
<label>Enter Name</label>
<input type="text" class="form-control" name="name" required/>
</div>

<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}

function formSafariCreate(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariCreate`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formSafariCreate').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    LoadSafariItemTemplate(data);
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}


function FormAddItemSafariSpent(safariuid,safariName)
{

    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item ${atob(safariName)}</strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemSafari" onsubmit="return SafariAddItem()">
<div class="p-2">
<div class="form-group ">

<input type="hidden" class="form-control" name="safariuid" value="${atob(safariuid)}"/>
<input type="hidden" class="form-control" name="name" value="${atob(safariName)}"/>
<input type="hidden" class="form-control" name="typeData" value="spend"/>

</div>

<div class="form-group right-inner-addon">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="uid" onkeyup="SafariautoCompleteTopItem(this,'${btoa('spend')}')" required/>
<span class="autocompleteIcon"></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group d-none">
<label>qty</label>
<input type="number" class="form-control" name="qty" value="0" />
</div>


<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" required/>
</div>


<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7"></textarea>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
    //

}
function FormAddItemSafari(safariuid,safariName){

$('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item ${atob(safariName)}</strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemSafari" onsubmit="return SafariAddItem()">
<div class="p-2">
<div class="form-group ">


<input type="hidden" class="form-control" name="safariuid" value="${atob(safariuid)}"/>
<input type="hidden" class="form-control" name="name" value="${atob(safariName)}"/>
<input type="hidden" class="form-control" name="typeData" value="product"/>

</div>

<div class="form-group right-inner-addon">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="uid" onkeyup="SafariautoCompleteTopItem(this,'${btoa("product")}')" required/>
<span class="autocompleteIcon"></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" required/>
</div>
<div class="form-group ">
<label>Add Pcs in 1BDS</label>
<input type="text" class="form-control" name="pcs" />
</div>
<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" required/>
</div>


<div class="form-group">
  <label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" placeholder="Enter Comment" rows="7"></textarea>
</div>


<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}


function EmptyautoCompleteTopItem(){
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
    $('.autocompleteIcon').html("");
}
function SafariautoCompleteTopItem(thisdata,typeData){
//

if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/SafariItemSearch`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    ItemName:thisdata.value,
    typeData:atob(typeData)
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemDeclar('${data[i].uid}')">
    ${data[i].uid}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteTopItem').html(getdata);
 $(`.autocompleteIcon`).html(`<i class="fa fa-times-circle text-danger" onclick="return EmptyautoCompleteTopItem()"></i>`);



}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
//
}
function addItemDeclar(itemName){
    $('.item_nameAdd').val(itemName);
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
}
function SafariAddItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariAddItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formAddItemSafari').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    console.log(`done $${CalculateDeclClass}`);

    $('.formAddItemSafari .form-control').val("");
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariuid=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafari(safariuid,safariName);
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}

function SafariSpendAddItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/addSpending`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formAddItemSafariStock').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    console.log(`done $${CalculateDeclClass}`);

    $('.formAddItemSafariStock .form-control').val("");
    //var item_nameAdd=$('.item_nameAdd').val();
    var safariuid=btoa(data.safariuid);
    var safariName=btoa(data.safariName);
    ViewItemSafariStock(safariuid,safariName);

    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}



function AdminSafariCalculate(uid,plaque,transpfees,profit,totClass){
    var totalqty=$(`.${totClass}`).text();
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminSafariCalculate`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
    plaque:plaque,
    transpfees:transpfees,
    profit:profit,
    totalqty:totalqty
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    console.log(data.xdata);
    CheckSafari();
 //console.log(hashfunction);


}
else{
    alert("already updated");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}

function ViewSafari(){
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/SafariGetAll`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center"> Safaris</h5>
`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Comment</th>
<th scope="col">Created At</th>
<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Name">${resultData[i].name}</td>
  <td data-label="Comment">${resultData[i].comment}</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>
  <td data-label="Action"><i class="fas fa-eye text-primary mylogout" title="View Safari Items Load" onClick="return ViewItemSafari('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}')"></i> <i class="fas fa-edit text-primary mylogout" title="Edit this Safari" onClick="return ViewEditSafari('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}','${btoa(resultData[i].comment)}','${btoa(resultData[i].uidCreator)}','${btoa(resultData[i].subscriber)}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Safari" onClick="return DeleteSafari('${btoa(resultData[i].uid)}','${btoa(resultData[i].name)}','${btoa(resultData[i].comment)}','${btoa(resultData[i].uidCreator)}','${btoa(resultData[i].subscriber)}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);



//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
function ViewEditSafari(uid,name,comment,uidCreator,subscriber){
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Safari</strong></h5>`)
$('.ModalPassword').html(`
<form class="formSafariStockEdit" onsubmit="return SafariStockEdit()">
<div class="p-2">
<div class="form-group ">
<label>Name</label>
<input type="hidden" class="form-control" name="uid" value="${atob(uid)}" required/>
<input type="text" class="form-control" name="name" value="${atob(name)}" required/>
</div>

<div class="form-group ">
<label for="exampleFormControlTextarea3">Enter Comment</label>
  <textarea class="form-control" name="comment" placeholder="Enter Comment" rows="7">${atob(comment)}</textarea>

</div>





<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}
function SafariEdit(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/SafariEdit`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formSafariEdit').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    ViewSafari();
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}
function DeleteSafari(uid,name,comment,uidCreator,subscriber){
    if(confirm(`Do you Want to Delete this Safari ${atob(name)}`))
    {

        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/DeleteSafariStock`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:atob(uid),
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    ViewSafariStock('name',false);
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong contact Admins ");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
    }
}
function ViewItemSafari(uid,name){

    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/SafariCalculate`,
type:'get',
data: {
safariuid:atob(uid),
name:atob(name)
},
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true

LoadSafariItemTemplate(data);



}
else{
    LoadSafariAddItemBtnTemplate(data);
$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}

//End SafariCode Javascript//


//Declaration


function CheckDeclaration(){
    closeNav();

    var Usertoken=localStorage.getItem("Usertoken");

    $.ajax({

url:`./api/AdminCheckDeclaration`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },

success:function(data){


if(data.status){//return data as true

    LoadDeclarationItemTemplate(data);



}
else{
    $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
$('.MainForm').html("");
    DeclarationForm();

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}
function LoadDeclarationItemTemplate(data){
    //
    var resultData=data.result;

var totClass=data.plaque+'_'+data.uid;
var totAmountDec="amount"+data.plaque+'_'+data.uid;
var totAll="all"+data.plaque+'_'+data.uid;
CalculateDeclClass="calc"+data.plaque+'_'+data.uid;
$('.MainbigTitle').html(`
<h5 class="text-center"> <button type="button" class="btn btn-danger" onclick="return FormCloseDeclaration('${data.uid}')">Close Declaration</button></h5>
`);
$('.MyRequest_table').html("");
getData=`

<h6 class="text-right"><span class="text-primary">Transport:</span>${data.transpfees}</h6>
<h6 class="text-right"><span class="text-primary">Profit:</span>${data.profit}</h6>
<h6 class="text-right"><span class="text-primary">Tot Price:</span><span class="${totAmountDec}"></span></h6>
<h6 class="text-right"><hr></h6>
<h6 class="text-right"><span class="text-danger">Total ALL</span>:<span class="${totAll}"></span></h6>
<div class="flex-center">


<div class="form-group">
<label>Plaque:${data.plaque}</label>

</div>
<div class="form-group">
<label>Exchange:${data.exchangerate}</label>

</div>

<div class="form-group">
<label>TotalQty:<span class="${totClass}"></span></label>

</div>



</div>
<button type="button" class="d-none btn btn-dark  ${CalculateDeclClass} " onclick="return AdminDeclarationCalculate('${data.uid}','${data.plaque}','${data.transpfees}','${data.profit}','${totClass}')">Calculate</button>
<div class="pb-2">
<button type="button" class="btn btn-dark" onclick="return FormAddItemDeclaration('${data.uid}','${data.plaque}','${data.transpfees}','${data.profit}','${totClass}')">Add Item</button>
<button type="button" class="btn btn-primary" onclick="return ResultExcel('${data.uid}','${data.plaque}','${data.exchangerate}')">Result</button>
</div>
<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Name</th>
<th scope="col">Qty</th>
<th scope="col">Price</th>
<th scope="col">Total</th>
<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;
var qtyTotalDec = 0;
var TotalPriceDec=0;
for(var i=0;i<resultData.length;i++){
qtyTotalDec+=parseInt(resultData[i].qty);
TotalPriceDec+=parseFloat(resultData[i].price);
 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Items">${resultData[i].name}</td>
  <td data-label="Qty">${resultData[i].qty}</td>
  <td data-label="Price">${resultData[i].price}</td>
  <td data-label="Total">${resultData[i].total}</td>
  <td data-label="Action"><i class="fas fa-edit text-primary mylogout" title="Edit this Items" onClick="return ViewEditItemDeclaration('${resultData[i].id}','${resultData[i].uid}','${resultData[i].name}','${resultData[i].qty}','${resultData[i].price}','${data.profit}','${data.transpfees}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Item" onClick="return DeleteItemDeclaration('${resultData[i].id}','${resultData[i].uid}','${resultData[i].name}','${data.profit}','${data.transpfees}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);

$(`.${totClass}`).text(qtyTotalDec);
$(`.${totAmountDec}`).text(TotalPriceDec);
$(`.${totAll}`).text(TotalPriceDec+parseFloat(data.profit)+parseFloat(data.transpfees));

//console.log(hashfunction);
//TableDisplayOrderTemplate(data)


    //
}
function ViewEditItemDeclaration(id,uid,name,qty,price,profit,transpfees){


    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Item</strong></h5>`)
$('.ModalPassword').html(`

<form class="formEditItemDeclaration" onsubmit="return AdminDeclarationEditItem()">
<div class="p-2">
<div class="form-group ">
<input type="hidden" class="form-control" name="id" value="${id}"/>
<input type="hidden" class="form-control" name="uid" value="${uid}"/>

<input type="hidden" class="form-control" name="transpfees" value="${transpfees}" />
<input type="hidden" class="form-control" name="profit" value="${profit}" />

</div>

<div class="form-group ">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="name" onkeyup="autoCompleteTopItem(this)" value="${name}" required/>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" value="${qty}" required/>
</div>

<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" value="${price}" required/>
</div>





<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`);
EmptyautoCompleteTopItem();
}
function AdminDeclarationEditItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeclarationEditItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formEditItemDeclaration').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    //console.log(`done $${CalculateDeclClass}`);
    $('.viewOrder').modal('hide');
    //var item_nameAdd=$('.item_nameAdd').val();
    CheckDeclaration();
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}
function DeleteItemDeclaration(id,uid,name,profit,transpfees){
    if(confirm(`Do you Want Delete ${name} in this Declaration?`))
    {
        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeleteItemDeclaration`,//close Declaration
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    id:id,
    uid:uid,
    profit:profit,
    transpfees:transpfees
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();

   alert("Close Query Submitted Successfully")
   CheckDeclaration();

}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;

    }

}
function FormCloseDeclaration(uid){
    if(confirm('Do you Want to Close this Declaration?'))
    {
        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminCloseDeclaration`,//close Declaration
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();

   alert("Close Query Submitted Successfully")
   AllOpenSaleReport();

}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
    }

}
function DeclarationForm(){

    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Create Declaration</strong></h5>`)
$('.ModalPassword').html(`
<form class="formDeclarationCreate" onsubmit="return formDeclarationCreate()">
<div class="p-2">
<div class="form-group ">
<label>Enter Plaque Number</label>
<input type="text" class="form-control" name="plaque" required/>
</div>

<div class="form-group ">
<label>Enter Profit</label>
<input type="number" class="form-control" name="profit" required/>
</div>

<div class="form-group ">
<label>Enter Transport Fees</label>
<input type="text" class="form-control" name="transpfees" required/>
</div>

<div class="form-group ">
<label>Enter Exchange Rate</label>
<input type="num" class="form-control" name="exchangerate" required/>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}

function formDeclarationCreate(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeclarationCreate`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formDeclarationCreate').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    CheckDeclaration();
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}


function ResultExcel(uid,plaque,exchangerate)
{

   //
   $('.cover-spin').show();
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/ResultExcel`,
type:'get',

//dataType: "json",
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data: {
    uid:uid,
    plaque:plaque,
    exchangerate:exchangerate
},
success:function(data){
    console.log(data);

    if(data.status){//return data as true

$('.cover-spin').hide();
//console.log(data);
window.location.href = `./api/ExportCsv?uid=${uid}&uidLink=${data.uidLink}&TokenLink=${data.TokenLink}&plaque=${plaque}&exchangerate=${exchangerate}`;

/*var a = document.createElement('a');
            var url = window.URL.createObjectURL(data);
            a.href = url;
            a.download = 'myfile.pdf';
            document.body.append(a);
            a.click();
            a.remove();
            window.URL.revokeObjectURL(url);*/

//alert("Successfully created");
//var data=data.result[0];
//var data=;
//console.log(hashfunction);



}
else{

    alert("alert something wrong please contact system Admin");
$('.cover-spin').hide();
}




},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;
    //

}
function FormAddItemDeclaration(uid,plaque,transpfees,profit,totClass){

$('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Add Item</strong></h5>`)
$('.ModalPassword').html(`

<form class="formAddItemDeclaration" onsubmit="return AdminDeclarationAddItem()">
<div class="p-2">
<div class="form-group ">

<input type="hidden" class="form-control" name="uid" value="${uid}"/>
<input type="hidden" class="form-control" name="plaque" value="${plaque}" />
<input type="hidden" class="form-control" name="transpfees" value="${transpfees}" />
<input type="hidden" class="form-control" name="profit" value="${profit}" />
<input type="hidden" class="form-control" name="totalqty" value="${totClass}" />
</div>

<div class="form-group right-inner-addon">
<label>Item Name</label>
<input type="text" class="form-control item_nameAdd" autocomplete="off" name="name" onkeyup="autoCompleteTopItem(this)" required/>
<span class="autocompleteIcon"></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group ">
<label>qty</label>
<input type="number" class="form-control" name="qty" required/>
</div>

<div class="form-group ">
<label>price</label>
<input type="text" class="form-control" name="price" required/>
</div>





<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}


function EmptyautoCompleteTopItem(){
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
    $('.autocompleteIcon').html("");
}
function autoCompleteTopItem(thisdata){
//

if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/AdminSearchDeclarationItem`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    ItemName:thisdata.value,
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemDeclar('${data[i].name}')">
    ${data[i].name}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteTopItem').html(getdata);
 $(`.autocompleteIcon`).html(`<i class="fa fa-times-circle text-danger" onclick="return EmptyautoCompleteTopItem()"></i>`);



}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
//
}
function addItemDeclar(itemName){
    $('.item_nameAdd').val(itemName);
    $('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();
}
function AdminDeclarationAddItem(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeclarationAddItem`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formAddItemDeclaration').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    $('.viewOrder').modal('hide');
    console.log(`done $${CalculateDeclClass}`);

    $('.formAddItemDeclaration .form-control').val("");
    //var item_nameAdd=$('.item_nameAdd').val();
    CheckDeclaration();
    //$(`.${CalculateDeclClass}`).click();
    //alert(` Item ${item_nameAdd} added `);
    /*$('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);*/
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}



function AdminDeclarationCalculate(uid,plaque,transpfees,profit,totClass){
    var totalqty=$(`.${totClass}`).text();
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeclarationCalculate`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
    plaque:plaque,
    transpfees:transpfees,
    profit:profit,
    totalqty:totalqty
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    console.log(data.xdata);
    CheckDeclaration();
 //console.log(hashfunction);


}
else{
    alert("already updated");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}

function ViewDeclaration(){
    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/AdminDeclarationLoad`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true


var resultData=data.result;


$('.MainbigTitle').html(`
<h5 class="text-center"> Declarations</h5>
`);
$('.MyRequest_table').html("");
getData=`


<table class="viewReqTable">
<thead>
<tr>
<th scope="col">#</th>
<th scope="col">Plaque</th>
<th scope="col">Profit</th>
<th scope="col">Transport</th>
<th scope="col">Exchange Rate</th>
<th scope="col">Status</th>
<th scope="col">Created At</th>
<th scope="col">Action</th>

</tr>
</thead>
<tbody>
`;

for(var i=0;i<resultData.length;i++){

 getData+=`

 <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Plaque">${resultData[i].plaque}</td>
  <td data-label="Profit">${resultData[i].profit}</td>
  <td data-label="Transport">${resultData[i].transpfees}</td>
  <td data-label="Exchange Rate">${resultData[i].exchangerate}</td>
  <td data-label="Status">${resultData[i].closeallstatus!='open'?'Close':resultData[i].closeallstatus}</td>
  <td data-label="CreatedAt">${resultData[i].created_at}</td>
  <td data-label="Action"><i class="fas fa-eye text-primary mylogout" title="View Declaration Items Load" onClick="return ViewItemDeclaration('${resultData[i].uid}','${resultData[i].plaque}','${resultData[i].exchangerate}','${resultData[i].profit}','${resultData[i].transpfees}')"></i> <i class="fas fa-edit text-primary mylogout" title="Edit this Declaration" onClick="return ViewEditDeclaration('${resultData[i].uid}','${resultData[i].plaque}','${resultData[i].profit}','${resultData[i].transpfees}','${resultData[i].exchangerate}')"></i> <i class="fas fa-trash text-dark mylogout " title="Delete This Declaration" onClick="return DeleteDeclaration('${resultData[i].uid}','${resultData[i].plaque}')"></i></td>


</tr>`;

}
getData+=`
</tbody>
</table>`;

$('.MainForm').html(getData);



//console.log(hashfunction);
//TableDisplayOrderTemplate(data)




}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
function ViewEditDeclaration(uid,plaque,profit,transpfees,exchangerate){
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Edit Declaration</strong></h5>`)
$('.ModalPassword').html(`
<form class="formDeclarationEdit" onsubmit="return AdminEditDeclaration()">
<div class="p-2">
<div class="form-group ">
<label>Plaque Number</label>
<input type="hidden" class="form-control" name="uid" value="${uid}" required/>
<input type="text" class="form-control" name="plaque" value="${plaque}" required/>
</div>

<div class="form-group ">
<label>Profit</label>
<input type="text" class="form-control" name="profit" value="${profit}" required/>
</div>

<div class="form-group ">
<label>Transport Fees</label>
<input type="text" class="form-control" name="transpfees" value="${transpfees}" required />
</div>

<div class="form-group ">
<label>Exchange Rate</label>
<input type="text" class="form-control" name="exchangerate" value="${exchangerate}" required/>
</div>



<div class="form-group">

<input type="submit" class="btn btn-danger"  value="submit" />
</div>
</div>
</form>

`)
}
function AdminEditDeclaration(){
    $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminEditDeclaration`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formDeclarationEdit').serialize(),
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    ViewDeclaration();
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
}
function DeleteDeclaration(uid,plaque){
    if(confirm(`Do you Want to Delete this Declaration that has this Plaque ${plaque}`))
    {

        $('.cover-spin').show();
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminDeleteDeclaration`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:{
    uid:uid,
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    ViewDeclaration();
 //console.log(hashfunction);


}
else{
    alert("something Went Wrong ");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

return false;
    }
}
function ViewItemDeclaration(uid,plaque,exchangerate,profit,transpfees){

    var Usertoken=localStorage.getItem("Usertoken");

$.ajax({

url:`./api/AdminItemDeclarationLoad`,
type:'get',
data: {
uid:uid,
plaque:plaque,
exchangerate:exchangerate,
profit:profit,
transpfees:transpfees
},
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true

LoadDeclarationItemTemplate(data);



}
else{

$('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}
//Declaration
function checkPlatform(platform){
    if(platform==='{{env('PLATFORM3')}}')
   {
    window.location.href ="user";
   }
   else{
       return true;
   }
}
function TableDisplayOrderTemplate(data){

 //console.log(hashfunction);
 getData=`

 <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">OrderId</th>
      <th scope="col">Total</th>
      <th scope="col">status</th>
      <th scope="col">Created_at</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
 `;

 for(var i=0;i<data.length;i++){
     ReceivedBtn=`<button type="button" class="btn btn-dark" onclick="return ReceivedOrder('${data[i].uid}')">Received?</button>`;
     DispatchBtn=`<button type="button" class="btn btn-success" onclick="return ViewDispatchOrder('${data[i].uid}')">Dispatch</button>`;
     ReceivedIcon=`<i class="fas fa-check text-success"></i>`;
     BtnDisplayCheck=data[i].status!='Request'?DispatchBtn:ReceivedBtn;//it means that on receiv show Dispatch else show Received
     getData+=` <tr>
      <td data-label="#">${i+1}</td>
      <td data-label="OrderId">${data[i].uid}</td>
      <td data-label="Total">${data[i].custom_total}</td>
      <td data-label="Status">${data[i].status=='Received'?ReceivedIcon:data[i].status}</td>
      <td data-label="Created_at">${data[i].created_at}</td>
      <td data-label="Action">${BtnDisplayCheck}| <button type="button" class="btn btn-primary" onclick="return View_order('${data[i].uid}')">View</button></td>
    </tr>`;

 }
 $('.MyRequest_table').html(getData);
}
function DisplayOrderData(){
    closeNav();

    $('.MainForm').html(`
    <h5 class="text-center">Order List</h5>
    `);
    $('.Count_table').css("display", "none");
    $('.OrderDspTable').css("display", "block");
    $.ajax({

url:`./api/ViewOrderRequest`,
type:'get',

success:function(data){


if(data.status){//return data as true

    var data=data.result;
 //console.log(hashfunction);
 TableDisplayOrderTemplate(data)




}
else{
    $('.MyRequest_table').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}

function ReceivedOrder(OrderId) {
    if(confirm('Have you received this order?'))
    {
//
var Usertoken=localStorage.getItem("Usertoken");
$('.cover-spin').show();


$.ajax({

url:`./api/AdminReceivedOrder`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
uid:OrderId,
},
success:function(data){
if(data.status){//return data as true

DisplayOrderData();


$('.cover-spin').hide();


}
else{
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
//
    }


    return false;
//
}
function dispatch(myid){


}


function View_order(orderid){
//
var Usertoken=localStorage.getItem("Usertoken");
    $('.viewOrder').modal('show');
    $('.MyTitleModal').html(`<h5 class="text-center">Order ID#:${orderid}</h5>`)
    $('.cover-spin').show();

    $.ajax({

url:`./api/viewOrder`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    uid:orderid,
},
success:function(data){
if(data.status){//return data as true
    $('.cover-spin').hide();
    var data=data.result;
 //console.log(hashfunction);
 getData="";

 for(var i=0;i<data.length;i++){
     getData+=` <tr>
      <td data-label="#">${i+1}</td>
      <td data-label="OrderId">${data[i].productCode}</td>
      <td data-label="Qty">${data[i].qty}</td>
      <td data-label="PCS">${data[i].pcs}</td>
      <td data-label="dz">${(data[i].pcs/12).toFixed(2)}</td>

    </tr>`;

 }
 $('.viewReqTable tbody').html(getData);





}
else{
    $('.cover-spin').hide();

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
}

function ViewDispatchOrder(orderid){
    $('.MainForm').html(``);
    $('.Count_table').css("display", "block");
    //$('.OrderDspTable').css("display","none");
    $('.orderIdDsp').text(`Order ID #:${orderid}`);
    $('.cover-spin').show();
//
var Usertoken=localStorage.getItem("Usertoken");
   // $('.viewOrder').modal('show');


    $.ajax({

url:`./api/viewOrder`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    uid:orderid,
},
success:function(data){
if(data.status){//return data as true

    $('.cover-spin').hide();
    var data=data.result;
 //console.log(hashfunction);
 getData=`
 <thead>
  <tr>
    <th scope="col">#</th>
    <th scope="col">Item</th>
    <th scope="col">pcs</th>
    <th scope="col">qty</th>
    <th scope="col">qty(Count)</th>
    <th scope="col">qty(Left)</th>
    <th scope="col">Action</th>
</tr>
</thead>
 `;

 for(var i=0;i<data.length;i++){
    var trackInput=`Count_${data[i].id}`;
    var qtyCountID=`qty_${trackInput}`;
    var inputQty=` <input type="number" class="form-control ${qtyCountID}" value="${data[i].qty_count}" >`;
    var btnCount=`<button type="button" class="btn btn-dark" onclick="return Approved('${qtyCountID}','${data[i].uid}','${data[i].productCode}','${data[i].price}','${data[i].custom_price}')">Count</button>`;
    var checkIcon=`<i class="fas fa-check text-success"></i>`;
    var checkQtyToQtyCount=data[i].qty==data[i].qty_count?checkIcon:btnCount;
     getData+=` <tr>
      <td data-label="#">${i+1}</td>
      <td data-label="Item">${data[i].productCode}</td>
      <td data-label="pcs">${data[i].pcs}</td>
      <td data-label="qty">${data[i].qty}</td>

      <td data-label="qty(Count)">${data[i].qty_count}
     ${data[i].qty==data[i].qty_count?'':inputQty}
      </td>
      <td data-label="qty(Left)">${data[i].qty-data[i].qty_count==0?'0'+checkIcon:data[i].qty-data[i].qty_count}</td>
      <td data-label="Action">${checkQtyToQtyCount}</td>

    </tr>`;

 }
 $('.MyRequest_table').html(getData);





}
else{
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
}
function Approved(qtyCountID,OrderId,productCode,price,custom_price) {//count


    $('.cover-spin').show();

var qty_countValue=$(`.${qtyCountID}`).val();

var Usertoken=localStorage.getItem("Usertoken");
//console.log(OrderId);
//search products
$.ajax({

url:`./api/AdminApprovedCount`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
uid:OrderId,
productCode:productCode,
price:price,
qty_count:qty_countValue,
custom_price:custom_price,
},
success:function(data){

if(data.status){//return data as true

   ViewDispatchOrder(OrderId);

   $('.cover-spin').hide();

}
else{
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return true;

}

function ViewApprovedOrder() {//count
    closeNav();
    $('.MainForm').html(`
    <h5 class="text-center">Approved Order</h5>
    `);


    $('.cover-spin').show();

var Usertoken=localStorage.getItem("Usertoken");
//console.log(OrderId);
//search products
$.ajax({

url:`./api/ViewOrderApproved`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
success:function(data){


if(data.status){//return data as true
    var data=data.result;
 TableDisplayOrderTemplate(data);


 $('.cover-spin').hide();


}
else{
    $('.MyRequest_table').html("");
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
}

function TrackdOrderForm(){
    closeNav();
    $('.MyRequest_table').html("");

    $('.MainForm').html(`
    <h5 class="text-center">Track Your Order</h5>
<div class="form-inline">
  <input class="form-control mr-sm-2 trackId" type="search" placeholder="Enter OrderID" aria-label="Search">
  <button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="return TrackdOrder()">Search</button>
</div>

    `);

    return false;
}

function TrackdOrder(){

    var OrderId=$('.trackId').val();
var Usertoken=localStorage.getItem("Usertoken");
$('.cover-spin').show();
//console.log(OrderId);
//search products
$.ajax({

url:`./api/TrackOrder`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
uid:OrderId,

},
success:function(data){

if(data.status){//return data as true
    $('.cover-spin').hide();
    var data=data.result;
 //console.log(hashfunction);
 TableDisplayOrderTemplate(data);



}
else{
    $('.MyRequest_table').html(`
    <h5 class="text-center">Order Id Not Found</h5>
    `);

    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return true;
}


function  UserAddInvoice(userid,name){
    //ViewSearchForm();
    MyUserid=userid;
    Myname=name;

    create_order();

    $('.MainbigTitle').html(`
<h5 class="text-center mainTitle">Acc:(<strong>${name}</strong>)</h5>

`);

    $('.useridAccount').val(userid);



}
function AdminClosedSales(){
    if(confirm('Are you Sure you want to Close This Sales?'))
    {
        //

        $('.cover-spin').show();

//
var Usertoken=localStorage.getItem("Usertoken");
//console.log(OrderId);
//search products
$.ajax({

url:`./api/AdminClosedSales`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formData').serialize(),
success:function(data){
if(data.status){//return data as true

//localStorage.setItem('Usertoken',data.token);
//console.log(hashfunction);
$('.cover-spin').hide();
$('.MainbigTitle').html(`
<div class="alert alert-primary" role="alert">
Query Submitted Successfully
</div>
`);


}
else{
    alert("Password is incorrect please try again");
    $('.cover-spin').hide();

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});

        //

    }
    return false;

}
function AdminAddPassword(userid,name) {

    $('.viewOrder').modal('show');

    $('.MyTitleModal').html(`<h5 class="text-center">Close  <strong>${name}</strong></h5>`)
    $('.ModalPassword').html(`
    <form class="formData" >
<div class="p-2">
<div class="form-group ">
<label>Enter Your Password</label>
<input type="password" class="form-control" name="password" />
<input type="hidden" class="form-control" name="userid" value="${userid}"/>
</div>

<div class="form-group">

<input type="submit" class="btn btn-danger" onclick="return AdminClosedSales('${userid}','${name}')" value="submit" />
</div>
</div>
</form>

    `)

    //$('.cover-spin').show();

}
function  ReportChoice(thisdata,userid,name)
{
    if(thisdata.value=='1')
    {
        console.log(thisdata.value);
        UserReport(userid,name);
    }
    else{
        console.log(thisdata.value);
        ViewSecondSalesReport(userid,name);
    }
    return false;
}

function ViewSecondSalesReport(userid,name){

    MyUserid=userid;
    Myname=name;
    $('.MyRequest_table').html("");
//
$('.cover-spin').show();
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/UserSecondSaleReport`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
    data: {
userid:userid,
    },
success:function(data){


if(data.status){//return data as true
    $('.cover-spin').hide();
//var data=data.result[0];
//var data=;
//console.log(hashfunction);
var data=data.result;
var TotalReport=0;
var TotalNo=0;
var TotalQty=0;
console.log(data);
 var getdata=``;

 for(var i=0;i<data.length;i++){
    TotalReport+=parseFloat(data[i].total_order);
    TotalNo=data.length;
    TotalQty+=parseFloat(data[i].qty);
    var datatobrr=data[i].ProductConcat.split(',');
    var getDetail="";
    for(var u=0;u<datatobrr.length;u++)
    {
        getDetail+=`
<li class="list-group-item">${u+1} ${parantesis} ${datatobrr[u]}</li>
`;
   }

   var TrueSubmitIcon=`<i  class="fas fa-pen text-success mylogout" title="Edit Permission Orders" onclick="return EditPermissionOrder('${data[i].uid}','${trueV}','${data[i].qty}','${data[i].total_order}')"></i>`;
   var FalseSubmitIcon=`<i  class="fas fas fa-ban text-danger mylogout" title="Edit Permission Orders" onclick="return EditPermissionOrder('${data[i].uid}','${falseV}','${data[i].qty}','${data[i].total_order}')"></i>`;
   var permissionChange=data[i].permission===trueV?TrueSubmitIcon:FalseSubmitIcon;
    getdata+=`

<ul class="list-group pt-1 ">

  <li class="list-group-item bg-dark text-white">No # ${data[i].uid} ${permissionChange} <span class="float-center"></span><span class=" float-right"><span class="text-success">(${data[i].qty}) Total</span>=$${data[i].total_order}</span></li>
  ${getDetail}
</ul>
<hr/>
    `;

 }
 $('.MainbigTitle').html(`

 <h5 class="text-center mainTitle">
 ${name}
 <div class="pt-1">
<button type="button" class="btn btn-danger" onclick="return AdminAddPassword('${userid}','${name}')">Close Sales</button>
</div>
<div class="pt-1">
<select id="Ultra" onchange="return ReportChoice(this,'${userid}','${name}')" class="form-control-sm">
     <option value="2">Report View 2</option>
     <option value="1">Report View 1</option>

</select>
</div>


 </h5>

<h6 class="text-right"><span class="text-danger">Total</span>:$${TotalReport}</h6>
<h6 class="text-right"><span class="text-primary">Qty</span>:${TotalQty}</h6>
<h6 class="text-right"><span class="text-success">Facture</span>:${TotalNo}</h6>

${@include('components.Search.Search.SearchFactureNo')}
 `);


$('.MainForm').html(getdata);


}
else{
$('.MyRequest_table').html("");
$('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;



}

function EditPermissionOrder(OrderId,permission,qty,totalOrder) {//qty:number of qty in this facture to be edited,totalOrder:is total amount of that facture,this will be saved on history edit
    var permissionValue=permission===trueV?falseV:trueV;

    if(confirm(`Do you want to change permission of ${OrderId} to:${permissionValue}?`))
    {
//
var Usertoken=localStorage.getItem("Usertoken");
$('.cover-spin').show();


$.ajax({

url:`./api/AdminEditPermissionOrder`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
OrderId:OrderId,
permissionValue:permissionValue,
qty:qty,
totalOrder:totalOrder,
PrevQueryData:`"{

    "OrderId":"${OrderId}",
    "PrevPermission":"${permission}"


}"`,

},
success:function(data){
if(data.status){//return data as true

    alert("Permission has been changed");

    ViewSecondSalesReport(MyUserid,Myname);


$('.cover-spin').hide();


}
else{
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
//
    }


    return false;
//
}

function ComeFromallsale(){
    countryComeFrom=$('.catComeFrom option:selected').val();

    AllOpenSaleReport();


}
function  AllOpenSaleReport(){
    closeNav();
    $('.MyRequest_table').html("");


    $('.cover-spin').show();
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminAllOpenReport`,
type:'get',
data:{
countryComeFrom:countryComeFrom
},
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },


success:function(data){

    platform=data.platform;
    userProfileName=data.name;

   // console.log(data);
if(checkPlatform(platform))
{
//
if(data.status){//return data as true
    $('.cover-spin').hide();

//var data=data.result[0];
//var data=;
//console.log(hashfunction);
var data=data.result;
var MyallTotal=0;
var totalColi=0;

var getData=`
<ul class="list-group pt-3 displayViewAll">
<li class="list-group-item bg-dark text-white">LIST YIBYAFASHWE <span class=" float-right"><span class="text-success">Qty:</span><span class="totalqtycoli"></span></span></li>

`;

for(var i=0;i<data.length;i++){
//it means that on receiv show Dispatch else show Received
MyallTotal+=parseFloat(data[i].all_total);
totalColi+=parseFloat(data[i].qty);

 getData+=`
<li class="list-group-item">${i+1} ${parantesis} ${data[i].qty} ${data[i].productCode}= ${data[i].all_total}</li>

`;



}


getData+=`</ul>`;
$('.MainbigTitle').html(`
<h5 class="text-center mainTitle">
Report All Sales
<div class="form-group ">
<h6 class="text-center pt-1">Show From</h6>

<select class="form-control-sm catComeFrom" name="cat" onchange="ComeFromallsale()">

</select>

</div>



</h5>
<div class="text-right UserBtnTotal"><h6 class="text-right">Total:${MyallTotal}</h6></div>



    `);
    selectComeFrom();


$('.MainForm').html(getData);
$('.totalqtycoli').text(totalColi);
//$('.MyRequest_table').html(getData);
//console.log(MyallTotal);
/*$('.UserBtnTotal').html(`

<h6 class="text-right">Total:${MyallTotal}</h6>
`);*/


}
else{
    if(platform==='{{env('PLATFORM1')}}')
    {
$('.MyRequest_table').html("");
$('.MainForm').html("No data Found");
$('.cover-spin').hide();
    }
    else{
        alert("Something Wrong With Your Account Please Contact System Admin");
    logout();
    }


}
//
}



},
error:function(data){

//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;
    //


}

function  UserReport(userid,name){
    $('.MyRequest_table').html("");
   // MyUserid=userid;

   MyUserid=userid;
    Myname=name;
    //$('.MainForm').html("");
    /*$('.mainTitle').html(`${name}

    <div class="pt-1">
<button type="button" class="btn btn-danger" onclick="return AdminAddPassword('${userid}','${name}')">Close Sales</button>
</div>
<div>
<select id="Ultra" onchange="return ReportChoice(this,'${userid}','${name}')">
     <option value="1">Report1</option>
     <option value="2">Report2</option>

</select>
</div>
    `);*/

    //
    $('.cover-spin').show();
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/UserSaleReport`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
    data: {
userid:userid,
countryComeFrom:countryComeFrom
    },

success:function(data){


if(data.status){//return data as true
    $('.cover-spin').hide();
//var data=data.result[0];
//var data=;
//console.log(hashfunction);
var data=data.result;
var MyallTotal=0;
var totalColi=0;

var getData=`
<ul class="list-group pt-3 displayViewAll">
<li class="list-group-item bg-dark text-white">LIST YIBYAFASHWE <span class=" float-right"><span class="text-success">Qty:</span><span class="totalqtycoli"></span></span></li>


`;

for(var i=0;i<data.length;i++){
//it means that on receiv show Dispatch else show Received
MyallTotal+=parseFloat(data[i].all_total);
totalColi+=parseFloat(data[i].qty);
 getData+=`
<li class="list-group-item">${i+1} ${parantesis}  ${data[i].qty} ${data[i].productCode}= ${data[i].all_total}</li>

`;



}
getData+=`</ul>`;
$('.MainbigTitle').html(`
<h5 class="text-center mainTitle">
Acc:(<strong>${name}</strong>)
<div class="pt-1">
<button type="button" class="btn btn-danger" onclick="return AdminAddPassword('${userid}','${name}')">Close Sales</button>
</div>
<div class="pt-1">
<select id="Ultra" class="form-control-sm" onchange="return ReportChoice(this,'${userid}','${name}')">
     <option value="1">Report View 1</option>
     <option value="2">Report View 2</option>

</select>
</div>
<div class="form-group">
<h6>Search From</h6>
<select class="form-control-sm catComeFrom" name="cat" onchange="ComeFromaUserSale()">

</select>
<div>
</h5>
<div class="text-right UserBtnTotal"><h6 class="text-right">Total:${MyallTotal}</h6></div>



    `);

    selectComeFrom();

$('.MainForm').html(getData);
$('.totalqtycoli').text(totalColi);
//$('.MyRequest_table').html(getData);
//console.log(MyallTotal);
/*$('.UserBtnTotal').html(`

<h6 class="text-right">Total:${MyallTotal}</h6>
`);*/


}
else{
$('.MyRequest_table').html("");
$('.MainForm').html(`
<h6 class="text-center">No Sales Found on this Acc:<strong>${name}</trong></h6>
`);
$('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;
    //


}
function ComeFromaUserSale(){
    countryComeFrom=$('.catComeFrom option:selected').val();
    UserReport(MyUserid,Myname);

}
function ViewAllUsers(){

closeNav();
$('.MainbigTitle').html(`
<h5 class="text-center mainTitle">Users</h5>
<div class="text-right UserBtnTotal"></div>
`);
$('.MainForm').html("");

//
$('.cover-spin').show();
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminViewUsers`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){

//active1 ni owner of company
if(data.status){//return data as true
$('.cover-spin').hide();
var myuid=data.myuid;
var myStatus=data.myStatus;
//console.log(data.result);
var checkMystatus=(myStatus.indexOf('2'))!=-1?'d-none':'';
var data=data.result;


getData=`

<thead>
<tr>
  <th scope="col">#</th>
  <th scope="col">Name</th>
  <th scope="col">Company</th>
  <th scope="col" class="${checkMystatus}">Status</th>
  <th scope="col">Created</th>
  <th scope="col" class="${checkMystatus}">Actions</th>
</tr>
</thead>
`;

for(var i=0;i<data.length;i++){
//it means that on receiv show Dispatch else show Received
var banIcon=`  <i class="fas fa-ban text-danger btn" onclick="changePlatform('${data[i].name}','${data[i].uid}','${data[i].status}','${data[i].subscriber}')"></i>`;
var checkIcon=`<i class="fas fa-check text-success btn" onclick="changePlatform('${data[i].name}','${data[i].uid}','${data[i].status}','${data[i].subscriber}')"></i>`;
var myStatusCut=(data[i].status).slice(0,-1);
var platformcheck=myStatusCut==='active'?checkIcon:banIcon;
var checkHide=myuid===data[i].uid?'d-none':'';
var myStatusCut2=((data[i].status).slice(-1))==='1'?'Creator':'Admin';
 getData+=` <tr class="${checkHide}">
  <td data-label="#">${i+1}</td>
  <td data-label="Name">${data[i].name}</td>
  <td data-label="Company">${data[i].CompanyName}</td>
  <td data-label="Status"class="${checkMystatus}">${myStatusCut2}</td>
  <td data-label="Created_at">${data[i].created_at}</td>
  <td data-label="Actions" class="${checkMystatus}">${platformcheck}</td>

</tr>`;

}
$('.MyRequest_table').html(getData);


}
else{
$('.MyRequest_table').html("");
$('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}

function changePlatform(name,ThisUserid,userStatus,subscriber) {
    var indUserStatus=userStatus.slice(-1);
    userStatus=userStatus.slice(0,-1);
    var checkAct=userStatus==='active'?'to be Inactive':'to be Active';
 var checkPlatformSubmit=userStatus==='active'?`inactive${indUserStatus}`:`active${indUserStatus}`;
    if(confirm(`Do you Want ${name}  ${checkAct} `))
    {
//
var Usertoken=localStorage.getItem("Usertoken");
$('.cover-spin').show();


$.ajax({

url:`./api/AdminChangePlatform`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
data:{
userid:ThisUserid,
status:checkPlatformSubmit,
subscriber:subscriber
},
success:function(data){
if(data.status){//return data as true

    ViewAllUsers();


$('.cover-spin').hide();


}
else{
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
//
    }


    return false;
//

}
function EmpytyAdjustDisplay(){
    $('.adjustqtyDisplay').html("");
}
function adjustqty(thisdata,qty){

    if(thisdata.value=="") return EmpytyAdjustDisplay();

if(!isNaN(thisdata.value))
{

        $('.adjustqtyDisplay').html(
        `<strong class="text-success">=>Stock</strong>:<strong class="text-danger">${parseFloat(thisdata.value)+parseFloat(qty)}</strong>`
    );




}
else{
    $('.adjustqtyDisplay').html(
        `<strong class="text-success">=>Please Type numeric value</strong>`
    );
}


}

function AdjustThisProduct() {//Admin
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");
    //console.log(OrderId);
   //search products
   $.ajax({

url:`./api/AdjustProduct`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formData').serialize(),
success:function(data){

if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();
 $('.viewOrder').modal('hide');
    alert("Product Adjusted Successfully");
    ViewAllProductWithEdit();

}
else{
    $('.cover-spin').hide();
    alert(data.result);

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}

function EditThisProduct() {//Admin
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");
    //console.log(OrderId);
   //search products
   $.ajax({

url:`./api/EditProduct`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formData').serialize(),
success:function(data){
if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();

 $('.viewOrder').modal('hide');
    alert("Product Edited Successfully");
    ViewAllProductWithEdit();

}
else{

}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}
function AdminChangeAdjustProduct(id,productCode,price,qty,total,tags,created_at,cat){
    $('.viewOrder').modal('show');
    $('.MyTitleModal').html(`<h5 class="text-center">Adjust <strong>${atob(productCode)}</strong></h5>`);
    $('.ModalPassword').html(`
  <div class="p-2">
    <form class="formData"  enctype="multipart/form-data">
<div class="form-group d-none">
<label>Common Name</label>
<input type="text" class="form-control" name="tags"  value="${atob(tags)}"/>
</div>

<div class="form-group d-none">
<label>Come From</label>
<div class="form-group ComeFromLoader">

</div>
<input type="hidden" class="form-control catName" name="catName" />

</div>
<div class="form-group d-none">
<input type="hidden" class="form-control " name="prevPrice" value="${price}"/>
<input type="hidden" class="form-control " name="prevQty" value="${qty}"/>
<textarea class="form-control" name="PrevQueryData">
{
    "id":"${id}",
    "productCode":"${atob(productCode)}",
    "price":"${price}",
    "qty":"${qty}",
    "tags":"${atob(tags)}",
    "cat":"${cat}",
    "created_at":${created_at},
}

</textarea>
</div>
<div class="form-group d-none">
<label>Product Code</label>
<input type="text" class="form-control" name="productCode" value="${atob(productCode)}"/>
<input type="hidden" class="form-control" name="id" value="${id}" />
</div>
<div class="form-group d-none">
<label>Image</label>
<input type="file" class="form-control" change="imagechange(this)" name="files[]" />
</div>
<div class="form-group d-none">
<label>From</label>
<input type="text" class="form-control"  />
</div>
<div class="form-group">
<label>Price (Current Price:${price})</label>
<input type="text" class="form-control" value="${price}"name="price"/>
</div>
<div class="form-group">
<label>qty (Current Qty:${qty})<span class="adjustqtyDisplay"></span></label>
<input type="text" class="form-control adjustqty" name="qty" placeholder="Enter Adjust Qty" onkeyup="adjustqty(this,'${qty}')"  autocomplete="off"/>

</div>
<div class="form-group d-none">
<label>Pieces</label>
<input type="text" class="form-control" name="pcs" />
</div>
<div class="form-group d-none">
<label>Factories Price</label>
<input type="text" class="form-control" name="fact_price" />
</div>


<div class="form-group d-none">
<label>active</label>
<input type="text" class="form-control" name="active" />
</div>

<div class="form-group d-none">
<label>Description</label>
<input type="text" class="form-control" name="description" />
</div>
<div class="form-group">

<input type="submit" class="btn btn-danger" onclick="return AdjustThisProduct()" value="submit" />
</div>


</form>
</div>
    `);
   // $('.MyRequest_table').html("");
   datacomeFrom(cat);

}
function AdminChangeProduct(id,productCode,price,qty,total,tags,created_at,cat){
    $('.viewOrder').modal('show');
    $('.MyTitleModal').html(`<h5 class="text-center">Edit <strong>${atob(productCode)}</strong></h5>`);
    $('.ModalPassword').html(`
  <div class="p-2">
    <form class="formData"  enctype="multipart/form-data">
<div class="form-group">
<label>Common Name</label>
<input type="text" class="form-control" name="tags"  value="${atob(tags)}"/>
</div>

<div class="form-group">
<label>Come From</label>
<div class="form-group ComeFromLoader">

</div>
<input type="hidden" class="form-control catName" name="catName" />

</div>
<div class="form-group d-none">
<textarea class="form-control" name="PrevQueryData">
{
    "id":"${id}",
    "productCode":"${atob(productCode)}",
    "price":"${price}",
    "qty":"${qty}",
    "tags":"${atob(tags)}",
    "cat":"${cat}",
    "created_at":${created_at},
}

</textarea>
</div>
<div class="form-group d-none">
<label>Product Code</label>
<input type="text" class="form-control" name="productCode" value="${atob(productCode)}"/>
<input type="hidden" class="form-control" name="id" value="${id}" />
</div>
<div class="form-group d-none">
<label>Image</label>
<input type="file" class="form-control" change="imagechange(this)" name="files[]" />
</div>
<div class="form-group d-none">
<label>From</label>
<input type="text" class="form-control"  />
</div>
<div class="form-group">
<label>Price</label>
<input type="text" class="form-control" value="${price}"name="price"/>
</div>
<div class="form-group">
<label>qty</label>
<input type="text" class="form-control"  value="${qty}" name="qty" />
</div>
<div class="form-group d-none">
<label>Pieces</label>
<input type="text" class="form-control" name="pcs" />
</div>
<div class="form-group d-none">
<label>Factories Price</label>
<input type="text" class="form-control" name="fact_price" />
</div>


<div class="form-group d-none">
<label>active</label>
<input type="text" class="form-control" name="active" />
</div>

<div class="form-group d-none">
<label>Description</label>
<input type="text" class="form-control" name="description" />
</div>
<div class="form-group">

<input type="submit" class="btn btn-danger" onclick="return EditThisProduct()" value="submit" />
</div>


</form>
</div>
    `);
   // $('.MyRequest_table').html("");
   datacomeFrom(cat);

}
function SearchDateChange(thisdata)
{
    console.log(thisdata.value);
    //
    var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/searchPreviousRecord`,
type:'get',
data: {
    SearchDate:thisdata.value
},
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true
$('.cover-spin').hide();
//var data=data.result[0];
//var data=;
//console.log(hashfunction);
var data=data.result;


getData=`

<thead>
<tr>
  <th scope="col">#</th>
  <th scope="col">Code</th>
  <th scope="col">Name</th>
  <th scope="col">Price</th>
  <th scope="col">Qty</th>

  <th scope="col">Status</th>
  <th scope="col">From</th>
  <th scope="col">Created</th>
  <th scope="col">Action</th>
</tr>
</thead>
`;

for(var i=0;i<data.length;i++){
//it means that on receiv show Dispatch else show Received
tags=data[i].tags===null?'N/A':data[i].tags;
 getData+=` <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Code">${data[i].productCode}</td>
      <td data-label="Name">${tags}</td>
  <td data-label="Price">${data[i].price}</td>
  <td data-label="qty">${data[i].qty}</td>

  <td data-label="Status">${data[i].actionName}</td>
  <td data-label="From">${data[i].catName}</td>
  <td data-label="Created_at">${data[i].created_at}</td>
  <td data-label="Action">
<div class="d-none d-lg-block">
  <span ><i class="fas fa-adjust text-danger mylogout" title="Adjust Product" onclick="return AdminChangeAdjustProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')"></i></span> | <span><i  class="fas fa-edit text-success mylogout" title="Edit Product" onclick="return AdminChangeProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')"></i></span>
</div>
<div class="d-md-none">
  <span ><button class="btn btn-danger mylogout" title="Adjust Product" onclick="return AdminChangeAdjustProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')">Adjust</button></span> | <span><button class="btn btn-dark mylogout" title="Edit Product" onclick="return AdminChangeProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')">Edit</button></span>
</div>
  </td>

</tr>`;

}
$('.MyRequest_table').html(getData);



}
else{
$('.MyRequest_table').html("");
$('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;


    //
}
async function datacomeFrom(cat){
    let mydata=await LoadSettingComeFrom();
    var data=mydata.result;

    getData=`<select class="form-control catComeFrom" name="cat" id="box1" onchange="CatComeChange()">`;

for(var i=0;i<data.length;i++){
    getData+=`<option value="${data[i].id}">${data[i].comeFrom}</option>`;
}


getData+=`</select>`;


    $('.ComeFromLoader').html(getData);

   $(`.catComeFrom option[value="${cat}"]`).attr("selected",true);
   var sel = document.getElementById("box1");
var catName= sel.options[sel.selectedIndex].text;
    //console.log(text);
   $('.catName').val(catName) ;
}
function CatComeChange(){
   // var catName=$('.catComeFrom option:selected').text();
   var sel = document.getElementById("box1");
var catName= sel.options[sel.selectedIndex].text;
    //console.log(text);
   $('.catName').val(catName) ;
}

function ComeFromProductEdit(){
    countryComeFrom=$('.catComeFrom option:selected').val();
    ViewAllProductWithEdit();
}
function ViewAllProductWithEdit(){
    var chooseSearchBy="1";
    var ClassfieldName="searchProductEditTable";

closeNav();

$('.MainbigTitle').html(`

<h5 class="text-center mainTitle">
Stocks
<div class="form-group ">
<h6 class="text-center pt-1">Show From</h6>

<select class="form-control-sm catComeFrom" name="cat" onchange="ComeFromProductEdit()">


</select>

</div>



</h5>


`);

/*$('.SearchDate').flatpickr(
    {

    dateFormat: "Y-m-d ",
}
);*/

selectComeFrom();

$('.MainForm').html(`


<form class="Form_order">
            <!--My Form-->






<div class="form-group">

    <label for="">Search Your Product<span class="text-danger">*</span></label>
    <div class="input-group mb-3">
  <div class="input-group-prepend">
    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">By</button>
    <div class="dropdown-menu">
      <a class="dropdown-item" href="#SearchByCode" onclick="return chooseSearch('${choose1}','${ClassfieldName}')">Code</a>
      <a class="dropdown-item" href="#SearchByName" onclick="return chooseSearch('${choose2}','${ClassfieldName}')">name</a>
      <a class="dropdown-item" href="#SearchByDate" onclick="return chooseSearchDate('${ClassfieldName}')">Date</a>
    </div>
  </div>

  <input type="text" class="form-control searchProductEditTable" aria-label="Text input with dropdown button" placeholder="Search by Code" onkeyup="return searchProductEditTable(this)">
</div>






</div>
<!--search Form -->
</form>


`);
//
$('.cover-spin').show();



var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/AdminViewAllProduct`,
type:'get',
data: {
    countryComeFrom:countryComeFrom
},
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},

success:function(data){


if(data.status){//return data as true
$('.cover-spin').hide();
//var data=data.result[0];
//var data=;
//console.log(hashfunction);
var data=data.result;


getData=`

<thead>
<tr>
  <th scope="col">#</th>
  <th scope="col">Code</th>
  <th scope="col">Name</th>
  <th scope="col">Price</th>
  <th scope="col">Qty</th>

  <th scope="col">Qty Left</th>
  <th scope="col">From</th>
  <th scope="col">Created</th>
  <th scope="col">Action</th>
</tr>
</thead>
`;

for(var i=0;i<data.length;i++){
//it means that on receiv show Dispatch else show Received
tags=data[i].tags===null?'N/A':data[i].tags;
 getData+=` <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Code">${data[i].productCode}</td>
      <td data-label="Name">${tags}</td>
  <td data-label="Price">${data[i].price}</td>
  <td data-label="qty">${data[i].qty}</td>

  <td data-label="Qty_left">${parseInt(data[i].qty)-parseInt(data[i].qty_sold)}</td>
  <td data-label="From">${data[i].catName}</td>
  <td data-label="Created_at">${data[i].created_at}</td>
  <td data-label="Action">
<div class="d-none d-lg-block">
  <span ><i class="fas fa-adjust text-danger mylogout" title="Adjust Product" onclick="return AdminChangeAdjustProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')"></i></span> | <span><i  class="fas fa-edit text-success mylogout" title="Edit Product" onclick="return AdminChangeProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')"></i></span>
</div>
<div class="d-md-none">
  <span ><button class="btn btn-danger mylogout" title="Adjust Product" onclick="return AdminChangeAdjustProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')">Adjust</button></span> | <span><button class="btn btn-dark mylogout" title="Edit Product" onclick="return AdminChangeProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}','${data[i].cat}')">Edit</button></span>
</div>
  </td>

</tr>`;

}
$('.MyRequest_table').html(getData);



}
else{
$('.MyRequest_table').html("");
$('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
return false;

}

function searchProductEditTable(thisdata){
//
if(thisdata.value=="") return $('.search_append').html("");
//


searchProd=chooseSearchBy==='1'?'SearchByProduct':'SearchByTags';//first is search by code second by tags
console.log(chooseSearchBy);
var Usertoken=localStorage.getItem("Usertoken");
$.ajax({

url:`./api/${searchProd}`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    productCode:thisdata.value,
},
success:function(data){
    if(data.status){//return data as true
$('.cover-spin').hide();
//var data=data.result[0];
//var data=;
//console.log(hashfunction);
var data=data.result;


getData=`

<thead>
<tr>
  <th scope="col">#</th>
  <th scope="col">Code</th>
  <th scope="col">Name</th>
  <th scope="col">Price</th>
  <th scope="col">Qty</th>
  <th scope="col">Total</th>
  <th scope="col">Qty Left</th>
  <th scope="col">Created</th>
  <th scope="col">Action</th>
</tr>
</thead>
`;

for(var i=0;i<data.length;i++){
//it means that on receiv show Dispatch else show Received
tags=data[i].tags===null?'N/A':data[i].tags;
 getData+=` <tr>
  <td data-label="#">${i+1}</td>
  <td data-label="Code">${data[i].productCode}</td>
      <td data-label="Name">${tags}</td>
  <td data-label="Price">${data[i].price}</td>
  <td data-label="qty">${data[i].qty}</td>
  <td data-label="Total">${data[i].total}</td>
  <td data-label="Qty_left">${parseInt(data[i].qty)-parseInt(data[i].qty_sold)}</td>
  <td data-label="Created_at">${data[i].created_at}</td>
  <td data-label="Action"><span class="d-none d-md-block"><i class="fas fa-adjust text-danger mylogout" title="Adjust Product" onclick="return AdminChangeAdjustProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}')"></i></span> | <span><i  class="fas fa-edit text-success mylogout" title="Edit Product" onclick="return AdminChangeProduct('${data[i].id}','${btoa(data[i].productCode)}','${data[i].price}','${data[i].qty}','${data[i].total}','${btoa(data[i].tags)}','${data[i].created_at}')"></i></span></td>

</tr>`;

}
$('.MyRequest_table').html(getData);



}
else{
$('.MyRequest_table').html("");
$('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
//
}


function autoCompleteTopProductName(thisdata)
{
    //
    if(thisdata.value=="") return EmptyautoCompleteTopItem();
//

var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/SearchByProduct`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    productCode:thisdata.value,
},
success:function(data){
if(data.status){//return data as true

    $('.autoCompleteTopItem').show();

var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){

    getdata+=`
    <li class="list-group-item d-flex justify-content-between align-items-center mylogout myhover" onclick="return addItemDeclar('${data[i].name}')">
    ${data[i].productCode}=>${data[i].tags}
    <span class="badge "></span>
  </li>
    `;

 }

 $('.autoCompleteTopItem').html(getdata);
 $(`.autocompleteIcon`).html(`<i class="fa fa-times-circle text-danger" onclick="return EmptyautoCompleteTopItem()"></i>`);



}
else{
    /*$('.autoCompleteTopItem').html("");
    $('.autoCompleteTopItem').hide();*/
    EmptyautoCompleteTopItem();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;
    //

}


function CreateProductMenu(){
    $('.MainbigTitle').html("");
$('.MyRequest_table').html("");
    closeNav();
    $('.MainForm').html(`
    <h5 class="text-center">ONGERAMO IBISHYA</h5>
    <form class="formDataCreate" onsubmit="return CreateProduct()">
<div class="form-group right-inner-addon">
<label>Product Code <span class="text-danger">*</span></label>
<input type="text" class="form-control" name="productCode" autocomplete="off" onkeyup="autoCompleteTopProductName(this)" required/>
<span class="autocompleteIcon"></span>
</div>
<ul class="list-group  autoCompleteTopItem">

</ul>
<div class="form-group">
<label>Common Name</label>
<input type="text" class="form-control" name="tags" />
</div>
<div class="form-group d-none">
<label>Image</label>
<input type="file" class="form-control" change="imagechange(this)" name="files[]" />
</div>
<div class="form-group ComeFromLoader">

</div>
<div class="form-group">
<label>Price <span class="text-danger">*</span></label>
<input type="text" class="form-control" name="price" required/>
</div>
<div class="form-group">
<label>qty <span class="text-danger">*</span></label>
<input type="text" class="form-control" name="qty" required/>
</div>
<div class="form-group d-none">
<label>Pieces</label>
<input type="text" class="form-control" name="pcs" />
</div>
<div class="form-group d-none">
<label>Factories Price</label>
<input type="text" class="form-control" name="fact_price" />
</div>


<div class="form-group d-none">
<label>active</label>
<input type="text" class="form-control" name="active" />
</div>

<div class="form-group d-none">
<label>Description</label>
<input type="text" class="form-control" name="description" />
</div>
<div class="form-group">

<button  class="btn btn-danger mycreateProduct" >Submit</button>
</div>


</form>
    `);


    LoadSavedComeFrom();

}
function ResetSettingComeFrom(){

    //var catComeFrom=$('.catComeFrom').val();
    //console.log(catComeFrom);
    localStorage.removeItem("comeFromSaved");
    LoadSavedComeFrom();
}
function SaveSettingComeFrom(){
var catComeFrom=$('.catComeFrom').val();
var catComeFromText=$('.catComeFrom option:selected').text();
localStorage.setItem('comeFromSaved',catComeFrom);
alert(`${catComeFromText} Saved as Default`);
//LoadSavedComeFrom();

$(`.catComeFrom option[value="${catComeFrom}"]`).attr("selected",true);

}
async function LoadSavedComeFrom(){
    var comeFromSaved=localStorage.getItem("comeFromSaved");

    if(comeFromSaved)
    {
       /* $('.ComeFromLoader').html(`
    <label>From</label>
<span><i class="fas fa-undo text-danger mylogout"  title="Reset this Setting" onClick="return ResetSettingComeFrom()"></i> <i class="fas fa-cog text-dark mylogout" title="Setting" onClick="return SettingComeFrom()"></i></span>
<select class="form-control catComeFrom" name="cat" >
<option value="${comeFromSaved}">${comeFromSaved}</option>
</select>

    `);*/

    await LoadComeFrom();

    $(`.catComeFrom option[value="${comeFromSaved}"]`).attr("selected",true);
    }
    else{
        LoadComeFrom();
    }

    var sel = document.getElementById("box1");
var catName= sel.options[sel.selectedIndex].text;
    //console.log(text);
   $('.catName').val(catName) ;
}
function SettingComeFrom(){
    $('.viewOrder').modal('show');

$('.MyTitleModal').html(`<h5 class="text-center">  <strong>Settings</strong></h5>`)
$('.ModalPassword').html(`
<div class="pl-1 pr-1 pt-1">
<div class="input-group mb-3">
  <input type="text" class="form-control settingComeFromAddClass" placeholder="Enter From Country" aria-label="Recipient's username" aria-describedby="basic-addon2">
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button">Add</button>
  </div>
</div>

<ul class="list-group SettingComeFromLoad">



</ul>
</div>

`);
DispSettingComeFrom();
}
function DispSettingComeFrom(){
    //
    var Usertoken=localStorage.getItem("Usertoken");
$('.cover-spin').show();


$.ajax({

url:`./api/AdminProductComeFrom`,
type:'get',
headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Authorization": `Bearer ${Usertoken}`
},
success:function(data){
if(data.status){//return data as true
    var data=data.result;
    getData=``;

for(var i=0;i<data.length;i++){
    getData+=`
    <li class="list-group-item d-flex justify-content-between align-items-center">
    ${data[i].comeFrom}
    <span class="badge "><i class="fas fa-check text-success"></i>|<i class="fas fa-check text-success"></i></span>
  </li>
    `;
}



    $('.SettingComeFromLoad').html(getData);


$('.cover-spin').hide();


}
else{
    $('.cover-spin').hide();
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    //
}
function AdminAddComeFrom(){
    //settingComeFromAddClass
}


async function LoadComeFrom(){
    let mydata=await LoadSettingComeFrom();
    var data=mydata.result;

    getData=`<label>From</label>
<span><i class="fas fa-save text-success mylogout" title="Save this Setting" onClick="return SaveSettingComeFrom()"></i> <i class="fas fa-cog text-dark mylogout d-none" title="Setting" onClick="return SettingComeFrom()"></i></span>
<input type="hidden" class="form-control catName" name="catName" />
<select class="form-control catComeFrom" name="cat"  id="box1" onchange="CatComeChange()">`;

for(var i=0;i<data.length;i++){
    getData+=`<option value="${data[i].id}">${data[i].comeFrom}</option>`;
}


getData+=`</select>`;


    $('.ComeFromLoader').html(getData);
    //

   // data=comeFromTableArr;
    //

}
function SearchUserByName(thisdata) {

   //
if(thisdata.value=="") return $('.searchUser_Append').html("");

//
var Usertoken=localStorage.getItem("Usertoken");
   //search products
   $.ajax({

url:`./api/SearchUserByName`,
type:'get',
headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": `Bearer ${Usertoken}`
    },
data:{
    name:thisdata.value,
},
success:function(data){
if(data.status){//return data as true



var data=data.result;
 var getdata="";
 for(var i=0;i<data.length;i++){

    getdata+=`
    <li class="list-group-item" onclick="return ViewUserName('${data[i].userid}','${data[i].name}','${data[i].tel}','${data[i].email}','${data[i].country}')">${data[i].name}</li>
    `;

 }

 $('.searchUser_Append').html(getdata);



}
else{
    $('.searchUser_Append').html("");
}



},
error:function(data){
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

//
}

function ViewUserName(userid,name,tel,email,country){
    $('.SearchUserByName').val(name);
    $('.searchUser_Append').html("");

    $('.formContactAppend').html(`
    <div class="form-group">
<label>Image</label>
<input type="hidden" value="${userid}" class="form-control" name="ContactID" />
</div>
<div class="form-group">
<label>Phone</label>
<input type="text" value="${tel}" class="form-control" name="tel" />
</div>
<div class="form-group">
<label>Email</label>
<input type="text" class="form-control" value="${email}" name="email" />
<input type="hidden" class="form-control" value="1" name="password" />

</div>
<div class="form-group">
<label>Other Phone</label>
<input type="text" class="form-control" name="otherPhone" placeholder="Enter another phone number" />
</div>
<div class="form-group">
<label>address</label>
<input type="text" class="form-control" value="${country}" name="address" />
</div>
<div class="form-group">
<label>comment</label>
<input type="text" class="form-control" name="comment" />
</div>
    `);
}

function CreateContactMenu(){
    closeNav();

$('.MainForm').html(`
<h5 class="text-center">Create Contact</h5>
<form class="formData">
<div class="form-group">
<label>Enter Name</label>
<input type="text" class="form-control SearchUserByName"  name="name"  onkeyup="return SearchUserByName(this)"/>
</div>
<ul class="list-group searchUser_Append">

</ul>
<div class="formContactAppend">

<div class="form-group">
<label>Image</label>
<input type="hidden"  class="form-control" name="ContactID" />
</div>
<div class="form-group">
<label>Phone</label>
<input type="text"  class="form-control" name="tel" />
</div>
<div class="form-group">
<label>Email</label>
<input type="text" class="form-control"  name="email" />
<input type="hidden" class="form-control"  name="password" value="1" />
</div>
<div class="form-group">
<label>Other Phone</label>
<input type="text" class="form-control" name="otherPhone" placeholder="Enter another phone number" />
</div>
<div class="form-group">
<label>address</label>
<input type="text" class="form-control"  name="address" />
</div>
<div class="form-group">
<label>comment</label>
<input type="text" class="form-control" name="comment" />
</div>

</div>

<div class="form-group">

<input type="submit" class="btn btn-danger" onclick="return CreateContact()" value="submit" />
</div>


</form>
`);

}
function imagechange(event){
/*for(let i=0;i<this.$refs.files.files.length;i++)
{
  this.images.push(this.$refs.files.files[i]);
  console.log(this.images);
}*/

//

 var input = event.target;
      var count = input.files.length;
     // var count = 1;
      var index = 0;
      if (input.files) {
        while(count --) {
          var reader = new FileReader();
          reader.onload = (e) => {
            this.preview_list.push(e.target.result);

          }
          this.image_list.push(input.files[index]);

          reader.readAsDataURL(input.files[index]);
          index ++;
        }
	}
//
console.log(image_list);
      }



function CreateProduct() {//Admin
    $('.cover-spin').show();

       //
       var Usertoken=localStorage.getItem("Usertoken");
    //console.log(OrderId);
   //search products
   $.ajax({

url:`./api/CreateProduct`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
    dataType: "json",
data:$('.formDataCreate').serialize(),
success:function(data){
if(data.status){//return data as true

    //localStorage.setItem('Usertoken',data.token);
 //console.log(hashfunction);
 $('.cover-spin').hide();

 //ViewAllProducts();

    alert("Product Created Successfully");
    $('.formDataCreate :input').val("");
    $('.mycreateProduct').val("Submit");

    LoadSavedComeFrom();

}
else{
alert("Product Code exists already,Please add New Product Code");
$('.cover-spin').hide();

}



},
error:function(data){
    console.log(data);
//alert("errors occured please retry this process again or contact system Admin");
//window.location.href = "./login";
}
});
    return false;

}

function CreateContact() {//Admin
    $('.cover-spin').show();
//
var Usertoken=localStorage.getItem("Usertoken");
//console.log(OrderId);
//search products
$.ajax({

url:`./api/CreateContact`,
type:'post',
beforeSend: function (xhr) {
xhr.setRequestHeader('Authorization', `Bearer ${Usertoken}`);
},
dataType: "json",
data:$('.formData').serialize(),
success:function(data){
if(data.status){//return data as true

//localStorage.setItem('Usertoken',data.token);
//console.log(hashfunction);
$('.cover-spin').hide();
    $('.MainForm').html(`
    <div class="alert alert-primary" role="alert">
  Contact Created Successfully
</div>
    `);

}
else{

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
