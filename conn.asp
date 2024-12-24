<% 
set conn=server.createobject("ADODB.CONNECTION")
connstr = "Provider=MSDASQL;Driver={MySQL ODBC 8.0 ANSI Driver};Server=localhost;Database=agrobot;User=agrobot;Password=AgroGlobal2024!!!;Option=3;"

conn.Open connstr




function checkUser(u,p)
    set rs=Server.CreateObject("ADODB.recordset")
    sql = "SELECT * FROM botusers WHERE username='" & u & "' AND password='"& p &"'"
    rs.open sql,conn
    
    if not rs.eof then
        session("username") = rs("username")
        checkUser = 1
    else
        session("username") =""
        checkUser = 0
    end if
    
end function

function getDeviceid()
    set rs=Server.CreateObject("ADODB.recordset")
   sql = "SELECT * FROM agrobot.devices where iddevices=1 "
   rs.open sql,conn
   
   if not rs.eof then 
    getDeviceid = rs("deviceid")
   end if
  rs.close   
end function


%>