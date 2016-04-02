
 <!--  #include file = "common.asp" -->
 <HTML>      
 <HEAD>
 </HEAD>
 <BODY>

 <%
    localDebug = True
    Dim lngRowsAffected
    lngRowsAffected = 0 
    lngRowsAffected = SQLUpdate("accounts","EXECUTE test 'ERK'")

 %>

 </BODY>
 </HTML>

