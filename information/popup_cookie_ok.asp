<%
	Response.Cookies("cookie").expires=date+1
	popup=request("popup")
	cookie_var = "cookie"&popup
	Response.Cookies("cookie")(cookie_var)=popup
%>

<script>
	window.close();
</script>