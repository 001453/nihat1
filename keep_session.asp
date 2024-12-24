<!--#include file="conn.asp"-->

<%

id = request.querystring("id")

currentid = getDeviceid()

if (id<>"") then  
    sql = "UPDATE devices SET deviceid='" & id & "', updatetime=CURRENT_TIMESTAMP() "
    conn.execute(sql)
end if

response.write getDeviceid()
%>