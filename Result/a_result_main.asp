  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"--> 
  <!--#include virtual="/include/asp/admin_chk.asp"-->   
  <%
  Login_chk(Session_m_id)
 
  if ad_k_a_result="N" then
	Alert_url session_m_name &" ���� �������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
  
  yea = year(date)
  mon = month(date)
  dayy = day(date)

  if Cint(mon) < 10 then	mon = "0" & mon		end if
  if Cint(dayy) < 10 then	dayy = "0" & dayy	end if 

  start_date	= yea &"-"& mon &"-01"
  end_date		= yea &"-"& mon &"-"& dayy

  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		<table width="100%" border=0 cellspacing="0" cellpadding="0">
		<tr> 
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub05_t03.gif"></div>

		<form method="post" name="frm_a_result"> 
		<table width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">				
		<tr height="30"> 
			<th width=150>��ȸ �Ⱓ</th>
			<td>   			
				<input type="text" class="txtbox" name="start_date" size='10' value="<%=start_date%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=start_date&code2=&code3=&form_name=frm_a_result','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~
				<input type="text" class="txtbox" name="end_date" size='10' value="<%=end_date%>" readonly	onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=end_date&code2=&code3=&form_name=frm_a_result','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>		          
		</tr>
		<tr height=30> 
			<th> ȸ��� </td>
			<td>
				<select name="g_article_idx1" style="width:120px;" onblur="BlurColor(this);" onFocus="FocusColor(this);">
				<option value="0"> ȸ�� ����           
					<% 
					strSql = " select * from code_article where article_step2=0 order by article_order Asc"
					Set objRs=objCnn.Execute(strSql)

					if objRs.BOF or objRs.EOF then
					else
				 
					i = 1
					Do until objRs.EOF   	
						article_idx		= objRs("article_idx")
						article_name	= objRs("article_name")
					%>	
						<option value="<%=article_idx%>"><%=article_name%></option>
					<% 
						objRs.MoveNext
						i=i+1 
					Loop
					End if
				%>	
				</select>
			</td>
		</tr>
		<tr height=30> 
			<th> ��ȸ ����	</th>
			<td>
				<select name="result" class="txtbox" size=15 style="width:650px;">
					<option value="1"> �˻� ���ں� ��ġ��Ȳ </option>
					<option value="2"> �˻� ���ں� ������Ȳ </option>
					<option value="3"> �������� ��ġ��Ȳ </option>
					<option value="4"> �������� ������Ȳ </option>
					<option value="5"> ��������� ��ġ��Ȳ </option>
					<option value="6"> ��������� ������Ȳ </option>
					<option value="7"> ������� ��ġ��Ȳ </option>
					<option value="8"> ������� ������Ȳ </option>
				</select> 
			</td>		          
		</tr>
		<tr height=30>
			<td colspan='2' align='center'> 
				<span onClick="result_search02('frm_a_result');"><img src="/images/button/btn_search.gif" align='absmiddle' border=0></span>
			</td>  
		</tr>
		</table>									
		</form>	
		<!------------------ ���� ����  ------------------>        	
	</td>
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>	