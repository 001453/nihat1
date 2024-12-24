<!--#include virtual="conn.asp"-->
<script>
    var settings={};
</script>
<%
if request.querystring("action")="logout" then
    session("username")=""
    session("login")=0
    response.redirect("login.asp")
end if

if session("login")<>1 then
    response.redirect("login.asp")
end if

if request.querystring("action")="savesettings" then
    for each item in request.form 
       
        conn.execute ("UPDATE botsettings SET settingValue='" & request.form(item) & "' WHERE settingName='" & item & "' ")
    next
    response.redirect("/")
    
end if 

sql = "SELECT * FROM botsettings "
set rs=Server.CreateObject("ADODB.recordset")
rs.open sql,conn
if not rs.eof then %>
<script>
<% do while not rs.eof %>

    settings.<%=rs("settingName")%>= '<%=rs("settingValue")%>';
    localStorage.setItem("<%=rs("settingName")%>", "<%=rs("settingValue")%>");

<% rs.movenext
loop %>
</script> <% end if
  rs.close
%>
<!DOCTYPE html>
<html lang="tr" data-bs-theme="dark">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Tuncay Beşikçi">
    <title>AGRO MEXC BOT</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"  rel="stylesheet">
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">

 <script src="js/jquery-3.6.3.min.js" crossorigin="anonymous"></script>
  <script src="js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
 <script src="js/ccxt.browser.min.js"  crossorigin="anonymous" referrerpolicy="no-referrer"></script>  
 <script src="js/bignumber.min.js"  crossorigin="anonymous" referrerpolicy="no-referrer"></script>  
 <script type="text/javascript" src="js/klinecharts.min.js"></script>
   
   <script src="js/main.js" ></script>
</head>
<body id="page-top">
<nav class="navbar navbar-dark bg-dark" id="navTop">
<div class="container-fluid">
   <a class="navbar-brand"><img src="img/agro.png" /> <b class="success">AGROBOT</b></a>
   
        <ul class="nav nav-pills" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active btn-success" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true"><i class="fas fa-fw fa-tachometer-alt"></i></button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link btn-success" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link btn-success" onclick="window.location.assign('/?action=logout');" type="button"><i class="fa fa-sign-out" aria-hidden="true"></i></button>
        </li>
        </ul>
   
</div>
</nav>


<div class="tab-content" id="pills-tabContent">
  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
  
  <div class="container-fluid" data-bs-theme="dark">
    <div class="row" data-bs-theme="dark">
                               <div class="col-xl-3 col-md-6 mb-4" data-bs-theme="dark">
                                    <div class="card border-left-success shadow h-100 py-2" style="background-color:black;border-top:1px solid #1cc88a;border-bottom:1px solid #1cc88a;border-right:1px solid #1cc88a; ">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                        AGRO/USDT</div>
                                                    <div class="h5 mb-0 font-weight-bolder text-white" id="priceAGRO"></div>
                                                </div>
                                                <div class="col-auto" >
                                                    <span id="percentAGRO" class="font-weight-bolder text-white"></span>
                                                   
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-md-6 mb-4" >
                                    <div class="card border-left-success shadow h-100 py-2" style="background-color:black; border-top:1px solid #1cc88a;border-bottom:1px solid #1cc88a;border-right:1px solid #1cc88a;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                        AGRO Volume</div>
                                                    <div class="h5 mb-0 font-weight-bold  text-white" id="volumeAGRO"></div>
                                                </div>
                                                <div class="col-auto" >
                                                  
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card border-left-success shadow h-100 py-2" style="background-color:black; border-top:1px solid #1cc88a;border-bottom:1px solid #1cc88a;border-right:1px solid #1cc88a; ">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1" id="takipText">
                                                        </div>
                                                    <div class="h5 mb-0 font-weight-bold text-white" id="priceTakip"></div>
                                                </div>
                                                <div class="col-auto" >
                                                    <span id="percentTakip" class="font-weight-bold text-white"></span>
                                      
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                 <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card border-left-success shadow h-100 py-2" style="background-color:black;  border-top:1px solid #1cc88a;border-bottom:1px solid #1cc88a;border-right:1px solid #1cc88a;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                        BALANCE</div>
                                                    <div class="h5 mb-0 font-weight-bold text-white-800" id="balanceUSDT"></div>
                                                </div>
                                                <div class="col-auto">
                                                   
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
    </div>
    
    <div class="row" data-bs-theme="dark">
        
        <div class="col-xl-3 col-md-4 mb-4" style="height:100%;">
            <div class="obContainer">      
        
                <div class="topDiv">
                    <div id="asks">

                    </div>
                </div>
                <div class="middleDiv">
                    <div id="obPrice">
                        <span id="obAGRO"></span>
                    </div>
                </div>
                <div class="bottomDiv">
                    <div id="bids">

                    </div>
                </div>
        
        
        
            </div>
        </div>

      <div class="col-xl-9 col-md-9 mb-9" style="height:100%;">
        <div class="row" data-bs-theme="dark">

            <div class="col-xl-4 col-md-4 mb-4">
                <div class="card-body">
                    
            
                    <table class="takipTable" cellspan="2">
                    <tr><td colspan="2"><span class="font-weight-bold" id="nameTakip"></span></td></tr>
                        <tr><td>Time</td><td><span id="timeTakip"></span></td></tr>
                        <tr><td>Open</td><td><span id="openTakip"></span></td></tr>
                        <tr><td>Change</td><td><span id="changeTakip"></span></td></tr>

                    </table>
                </div>
            </div>
            <div class="col-xl-4 col-md-4 mb-4">
                    <div class="card-body">
                        <table class="tableAGRO" cellspan="2">
                            <tr><td colspan="2"><span class="font-weight-bold">AGRO/USDT</span></td></tr>
                            <tr><td>Next Order in</td><td><span id="remainingTime"></span> sn</td></tr>
                            <tr><td>Next Order Price</td><td><span id="orderAGRO"></span></td></tr>

                        </table>
                    </div>
            </div>
            <div class="col-xl-4 col-md-4 mb-4">
            
                <div class="card-body">
                    <button onclick="toggleFB()" id="fbot" class="btn btn-success btn-sm btn-block"><i class="fa fa-play" aria-hidden="true"></i> START Bot</button>
               
                </div>
            </div>

        </div>

        <div class="row" data-bs-theme="dark">
      
            <div class="col-xl-12 col-md-4 mb-4" id="chartContainer">
         
                
            </div>
           
        </div>
        
        <div class="row" data-bs-theme="dark">
            <div class="col-xl-12 col-md-4 mb-4">
                <div id="myLog">
                   <div id="logTop"></div>
                </div>
            </div>
        </div>
       </div>
    </div>
     
    
</div>
  
  </div>
  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
  <div class="container-fluid"><form>
    <div class="row">

        <div class="col-6">
        
            <div class="form-group row">
                <label for="takipToken" class="col-sm-6 col-form-label">Token to be followed</label>
                <div class="col-sm-6">
                    <select class="form-control"  id="takipToken" name="takipToken">
                    </select>
                 </div>
            </div>
        
            <div class="form-group row">
                <label for="minAGRO" class="col-sm-6 col-form-label">Minimum Order (AGRO)</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="minOrder" name="minOrder" placeholder="Minimum Order (AGRO)">
                </div>
            </div>
             <div class="form-group row">
                <label for="maxAGRO" class="col-sm-6 col-form-label">Maximum Order (AGRO)</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="maxOrder" name="maxOrder" placeholder="Maximum Order (AGRO)">
                </div>
            </div>
            <div class="form-group row">
                <label for="minDuration" class="col-sm-6 col-form-label">Minimum Order Duration (sn)</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="minDuration" name="minDuration">
                </div>
            </div>
            <div class="form-group row">
                <label for="maxDuration" class="col-sm-6 col-form-label">Maximum Order Duration (sn)</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="maxDuration" name="maxDuration">
                </div>
            </div>
            <div class="form-group row">
                <label for="maxFillOrder" class="col-sm-6 col-form-label">Maximum Order Lines</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="maxFillOrder" name="maxFillOrder">
                </div>
            </div>
        </div>


        <div class="col-6">
        
            <div class="form-group row">
                <label for="apikey" class="col-sm-6 col-form-label">MEXC API Key</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="apikey" name="apikey" placeholder="API Key">
                </div>
            </div>
            <div class="form-group row">
                <label for="apisecret" class="col-sm-6 col-form-label">MEXC API Secret</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="apisecret" name="apisecret" placeholder="API Secret">
                </div>
            </div>
            <div class="form-group row">
                <label for="prx" class="col-sm-6 col-form-label">Proxy Url</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="prx" name="prx" placeholder="Proxy Url">
                </div>
            </div>      
        </div>


    </div>
     <div class="row">
            <button id="saveButton" onclick="saveSettings()" type="button" class="btn btn-success">Save</button>
     </div>
</form>
</div>
  </div>
 </div>
</body>

