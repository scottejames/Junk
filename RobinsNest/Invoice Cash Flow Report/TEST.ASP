
 <!--  #include file = "common.asp" -->
 <HTML>      
 <HEAD>
 </HEAD>
 <BODY>

 <%
    localDebug = True
    Dim lngRowsAffected
    lngRowsAffected = 0 
    lngRowsAffected = SQLQuery("accounts","EXECUTE test 'QUERY'")

 %>

 </BODY>
 </HTML>

