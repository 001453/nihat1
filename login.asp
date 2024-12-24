<!--#include file="conn.asp"-->
<!DOCTYPE html>
<html lang="tr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>AGRO MEXC BOT</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">


</head>

<body class="bg-gradient-primary">
<%
email = request.form("email")
password = request.form("password")
remember = request.form("remember")
msg = ""

if remember="on" then
    Response.Cookies("email") = email
    Response.Cookies("remember") = "on" 
end if

if len(email)>1 and len(password)>1 then  

    if checkUser(email,password)=1 then
        session("login")=1
        response.Cookies("logintime") = now()
        response.redirect("/")
    else
        msg = "<p class'down' style='color:red;'><i class='fa fa-exclamation' aria-hidden='true'></i> "
        msg = msg & "Invalid username or password</p>"
    end if
end if

%>
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-5 col-lg-6 col-md-6">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                           
                            <div class="col-lg-12">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">AGRO MEXC BOT</h1>
                                    </div>
                                    <form class="user" method="post" action="login.asp">
                                        <div class="form-group">
                                            <input type="email" name="email" class="form-control form-control-user"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="Enter Email Address..."
                                                <% if request.Cookies("remember")="on" then %>
                                                 value="<%=request.Cookies("email")%>"
                                                <%end if%>
                                                >
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="password" class="form-control form-control-user"
                                                id="exampleInputPassword" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" name="remember" class="custom-control-input" id="customCheck"
                                                <% if request.Cookies("remember")="on" then %>
                                                    checked
                                                <%end if%>>
                                                <label class="custom-control-label" for="customCheck">Remember
                                                    Me</label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </button>
                                       
                                       
                                    </form>
                                    <hr>
                                    <div class="form-group">
                                        <% if msg <>"" then
                                              response.write( msg)

                                         end if %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>
<script>

    getMachineId();
    
    function getMachineId() {
        
        let machineId = localStorage.getItem('MachineId');
        
        if (!machineId) {
            machineId = crypto.randomUUID();
            localStorage.setItem('MachineId', machineId);
        }
    
        return machineId;
    }
    
    </script>
</html>