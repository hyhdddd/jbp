<%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/Config.asp"-->
  <% 
 '회사 주소, 연락처 , 팩스번호
  strSql = " select * from company_info where o_code='"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)
  
  o_com_name	= objRs("o_com_name")
  o_zipcode1	= objRs("o_zipcode1")
  o_zipcode2	= objRs("o_zipcode2")
  o_address		= objRs("o_address")

  o_tel1		= objRs("o_tel1")
  o_tel2		= objRs("o_tel2")
  o_tel3		= objRs("o_tel3")

  o_fax1		= objRs("o_fax1")
  o_fax2		= objRs("o_fax2")
  o_fax3		= objRs("o_fax3")

  o_address		= "(우"&o_zipcode1&"-"&o_zipcode2&")&nbsp;"&o_address
  
  If o_tel1="0" Or o_tel1="00" Then 
	o_tel	= o_tel2&"-"&o_tel3
  Else
	o_tel	= o_tel1&"-"&o_tel2&"-"&o_tel3
  End if

  If o_fax1="0" Or o_fax1="00" Then 
	o_fax	= o_tel2&"-"&o_tel3
  Else
	o_fax	= o_fax1&"-"&o_fax2&"-"&o_fax3
  End if

  '주소 : o_address
  '전화 : o_tel
  'fax  : o_fax

  m_id			= WORD_CHANGE(Request("m_id"),20)
  m_passwd		= WORD_CHANGE(Request("m_passwd"),20)
  idchk			= WORD_CHANGE(Request("idchk"),20)
  pwchk			= WORD_CHANGE(Request("pwchk"),20)
  
  userid		= request.Cookies("userid")("userid")
  idchk			= request.Cookies("userid")("idchk")
  userpasswd	= request.Cookies("userpasswd")("userpasswd")
  pwchk			= request.Cookies("userpasswd")("pwchk")
  
  If idchk="Y" Then
  else
	userid=""
  End If
  
  If pwchk="Y" Then
  Else 
	userpasswd=""
  End If 

  %>



<!DOCTYPE HTML>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="/include/css/style.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>


<style>
body, div, dl, dt, dd, h1, h2, h3, h4, form, fieldset, p, th, table, tr, td, p, br, input, button, textarea, select, .c1 { font-family:tahoma,verdana,돋움,굴림;font-size:12px;color:#666666; }

body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,form,fieldset,p,button,input { margin:auto;padding:0px;vertical-align:middle; }

html, body { width:100%;height:100%;padding:0px;text-align:center; }

img { border:0px;}
.img_middle{border:0;vertical-align:middle;}
li{list-style:none;float:left;line-height:30px;}

/*.bg {background:url(/images/freezonekorea/bg.gif) left center repeat-x; }*/
		.input { border:solid 1px #d9d9d9;width:100px; }
		.white { color:#FFF; }
		.black { color:#000; }
		.red1 { color:#ff6600; }
		.blue1 { color:#5e71fd; }
		.green1 { color:#1c7e45; }


 #box_center{width:900px;height:200px;position:absolute;left:50%;top:50%;margin:-100px 0 0 -450px;}

</style>


<head>




<body>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
<tr height="400">	
	<td align="center">
		
		<div style="width:800px;height:400px;border:0px solid #29abe2;border-radius:3px;margin-top:5%;">
		<table cellspacing="0" cellpadding="0" border="0" width="800" height="349">
		<tr>
			<td width="412" align="right" valign="top">
				
				<div style="width:412px;padding-right:26px;">
				<form name="frm_login" action="/include/asp/login_ok.asp" method="post">
				<table cellspacing="0" cellpadding="0" border="0" width="327" height="349">
				<tr height="71">
					<td colspan="2" valign="bottom" align="left">
					<!--
					<p style="padding-left:30px;font-size:24px;color:#29abe2;font-weight:bold;font-family:Malgun Gothic;">
						다은넷
					</p>-->
					</td>
				</tr>
				<tr height="116"><td colspan="2"><img src="/images/internet/admin_title.jpg" align="absmiddle"></td></tr>
				<tr height="18"><td colspan="2">&nbsp;</td></tr>
				<tr height="26">
					<td align="right">아이디&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Text" name="m_id" maxlength="14" size="20" class="txtbox"  style="ime-mode:disabled;" onKeyUp="EnterNextFocus('frm_login','m_passwd');" value="<%=userid%>" />&nbsp;</td>
					<td rowspan="2" width="100" align="right"><img src="/images/internet/btn_login.jpg" align="absmiddle" onClick="send_login('frm_login');" onMouseOver="this.style.cursor='hand'" /></td>
				</tr>
				<tr height="26">
					<td align="right">비밀번호&nbsp;&nbsp;<input type="password" name="m_passwd" maxlength="14" size="20" class="txtbox" style="ime-mode:disabled;" onKeyUp="enter_submit_chk('frm_login','send_login');" value="" />&nbsp;</td>
				</tr>
				<tr height="39">
					<td colspan="2" align="right">
					<div style="padding-top:14px;">
					<input type="checkbox" name="idchk" value="Y"  <% If idchk="Y" Then %> checked <% End If %>>&nbsp;아이디저장&nbsp;&nbsp;&nbsp;
					<a href="#" onfocus='this.blur()' onClick="NewWindow('/insa/y_partner_regist.asp?o_code=<%=o_code%>','partner_write','620','700','no');"><img src="/images/internet/btn_partner.jpg" align="absmiddle"></a>&nbsp;
					</div>
					</td>
				</tr>
				<tr><td colspan="2" align="right"><span class="red1">현재 IP. <%=Request.ServerVariables("REMOTE_HOST")%> 접속 중 입니다.</span></td></tr>
				</table>
				</form>
				</div>

			</td>
			
			
			
			
			
			
			<td width="388" valign="bottom"><img src="/images/login/logo_jb.jpg" align="absmiddle" width="350"></td>
		</tr>
		</table>
		</div>

	</td>
</tr>
<tr height="80">
	<td align="center">
	<%=o_address%>   &nbsp;&nbsp;&nbsp;
	대표번호. <%=o_tel%>&nbsp;&nbsp;&nbsp;
	팩스번호. <%=o_fax%><br>
	<a href="http://entersoft.kr" target="_blank">Copyright 2014. <span class="red1">EnterSoft</span> All Rights Reseved.</a>
	</td>
</tr>
</table>


</body>


<%
objRs.Close
objCnn.Close
Set objRs = Nothing 
Set objCnn = Nothing
%>