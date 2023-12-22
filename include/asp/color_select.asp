
<%
	code1		= Request("code1")
	form_name	= Request("form_name")
%>
<html>
<head>
<title>Html Color Codes</title>
<META NAME="description" CONTENT="Get HTML color codes for your website.">
<META NAME="keywords" content="html, color, codes, hex, chart">
<meta http-equiv="PICS-Label" content='(PICS-1.1 "http://www.classify.org/safesurf/" L gen true for "http://html-color-codes.info" r (SS~~000 1))'>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="html_color_codes2.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="favicon.ico" >
<script language="javascript">
	function send_color()
	{
		opener.document.all.<%=form_name%>.<%=code1%>.value=document.hcc.barva.value;
		self.close();
	}
	function Barva(koda)
	{
		document.getElementById("vzorec").bgColor=koda;
		document.hcc.barva.value=koda.toUpperCase();
		document.hcc.barva.select();
	}
</script>
</head>
<body topmargin=0 leftmargin=0>
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<form name="hcc" id="hcc">	
<table width="375" border="0" cellspacing="1" cellpadding="0" align="center">
	<tr height="24">
		<td bgColor="#190707" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2a0a0a" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#3b0b0b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#610b0b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#8a0808" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#b40404" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#df0101" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#ff0000" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#fe2e2e" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#fa5858" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f78181" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f5a9a9" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f6cece" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f8e0e0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#fbefef" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#191007" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2a1b0a" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#3b240b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#61380b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#8a4b08" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#b45f04" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#df7401" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#ff8000" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#fe9a2e" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#faac58" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f7be81" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f5d0a9" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f6e3ce" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f8ece0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#fbf5ef" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#181907" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#292A0A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#393B0B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#5e610b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#868A08" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#AEB404" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#D7DF01" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FFFF00" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F7FE2E" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F4FA58" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F3F781" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F2F5A9" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F5F6CE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F7F8E0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FBFBEF" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#101907" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#1B2A0A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#243b0b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#38610B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#4B8A08" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#5FB404" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#74DF00" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#80FF00" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#9AFE2E" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#ACFA58" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#BEF781" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#D0F5A9" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E3F6CE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#ECF8E0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F5FBEF" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#071907" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0A2A0A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B3B0B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B610B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#088A08" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#04B404" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#01DF01" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#00FF00" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2EFE2E" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#58FA58" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#81F781" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#A9F5A9" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#CEF6CE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E0F8E0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#EFFBEF" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#071910" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0A2A1B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B3B24" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B6138" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#088A4B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#04B45F" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#01DF74" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#00FF80" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2EFE9A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#58FAAC" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#81F7BE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#A9F5D0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#CEF6E3" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E0F8EC" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#EFFBF5" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#071918" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0A2A29" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B3B39" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B615E" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#088A85" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#04B4AE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#01DFD7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#00FFFF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2EFEF7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#58FAF4" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#81F7F3" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#A9F5F2" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#CEF6F5" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E0F8F7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#EFFBFB" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#071019" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0A1B2A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B243B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B3861" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#084B8A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#045FB4" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0174DF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0080FF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2E9AFE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#58ACFA" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#81BEF7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#A9D0F5" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#CEE3F6" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E0ECF8" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#EFF5FB" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#070719" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0A0A2A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B0B3B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0B0B61" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#08088A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0404B4" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0101DF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0000FF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2E2EFE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#5858FA" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#8181F7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#A9A9F5" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#CECEF6" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E0E0F8" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#EFEFFB" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#100719" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#1B0A2A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#240B3B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#380B61" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#4B088A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#5F04B4" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#7401DF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#8000FF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#9A2EFE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#AC58FA" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#BE81F7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#D0A9F5" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#E3CEF6" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#ECE0F8" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F5EFFB" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#190718" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2A0A29" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#3B0B39" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#610B5E" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#8A0886" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#B404AE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#DF01D7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FF00FF" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FE2EF7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FA58F4" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F781F3" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F5A9F2" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F6CEF5" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F8E0F7" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FBEFFB" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	<tr height="24">
		<td bgColor="#190710" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2A0A1B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#3B0B24" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#610B38" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#8A084B" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#B4045F" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#DF0174" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FF0080" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FE2E9A" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FA58AC" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F781BE" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F5A9D0" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F6CEE3" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#F8E0EC" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FBEFF5" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>	
	<tr height="24">
		<td bgColor="#000000" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#0b0b0b" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#151515" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#1c1c1c" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#2e2e2e" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#424242" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#585858" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#6e6e6e" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#848484" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#a4a4a4" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#bdbdbd" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#d8d8d8" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#e6e6e6" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#f2f2f2" onClick="Barva(this.bgColor)">&nbsp;</td>
		<td bgColor="#FFFFFF" onClick="Barva(this.bgColor)">&nbsp;</td>
	</tr>
	</table>
	</td>
</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr height="20">
	<td width="10"></td>
	<td id="vzorec" width="180"></td>
	<td width="200" valign="bottom"><input type="text" name="barva" id="barva" style="font-family:Verdana;height:20px; width:115px; font-size:12px" maxlength="7" size="9" /><img src="/images/button/btn_color.gif" name="2" value="1" align='absmiddle' onclick="send_color();"></td>
	<td></td>
</tr>
</table>
</form>
<script language="javascript">
<!--
	document.getElementById("vzorec").bgColor='#0101DF';
	document.hcc.barva.value='#0101DF';
-->
</script>