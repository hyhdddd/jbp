  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" ���� ��ü ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	

  timerStartTimer = Timer()
  s_group_code			= WORD_CHANGE(Request("s_group_code"),20)
  s_policy_date			= WORD_CHANGE(Request("s_policy_date"),20)
  s_policy_date_hour	= WORD_CHANGE(Request("s_policy_date_hour"),20)
  s_policy_date_minute	= WORD_CHANGE(Request("s_policy_date_minute"),20)

  e_policy_date			= WORD_CHANGE(Request("e_policy_date"),20)
  e_policy_date_hour	= WORD_CHANGE(Request("e_policy_date_hour"),20)
  e_policy_date_minute	= WORD_CHANGE(Request("e_policy_date_minute"),20)

  If s_policy_date<>"" Then
	s_policy_date1	= s_policy_date & " "&s_policy_date_hour&":"&s_policy_date_minute&":00"
  End if

  If e_policy_date<>"" Then
	e_policy_date1	= e_policy_date & " "&e_policy_date_hour&":"&e_policy_date_minute&":00"
  End if
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/css/style_button.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function send_batch(url)
	{
		ans=confirm("�� �Ⱓ�� ������ ���� ������ �����Ͻðڽ��ϱ�? �̵̹� �Ϲ������� ��� �ʱ�ȭ �Ǿ� �ٽ� ����˴ϴ�.");
		if(ans==true)
		{
			location.replace(url);
		}
	}
	function send_policy(url)
	{
		ans=confirm("����׷쿡 �ִ� ��Ʈ�ʿ��� ��åǥ�� �߼��Ͻðڽ��ϱ�? ");
		if(ans==true)
		{
			location.replace(url);
		}
	}
-->
</script>

<body>
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr height='400' valign='top'> 
	<td>
		<!------------------ ���� ����  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">������ ��å</li>
		</ul>
		</div>


		<form name="frm_group" Method="POST" action="policy_list.asp">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		</table>				


		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height='30'>
			<td colspan='5' style="style-border:none;text-align:left;">
				<b>��å�˻�:</b>&nbsp;
				<input type="text" name="s_policy_date" class="txtbox" size='10' value="<%=Left(s_policy_date,10)%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_policy_date&code2=&code3=&form_name=frm_group','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">

				<select name="s_policy_date_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>						
				<option value="<%=ii%>" <% If s_policy_date_hour=CStr(i) Then %> selected <% End If %>><%=ii%>�� </option>
				<% Next %>
				</select>
				<select name="s_policy_date_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>						
					<option value="<%=ii%>" <% If s_policy_date_minute=CStr(i) Then %> selected <% End If %>><%=ii%>�� </option>
					<% Next %>
				</select>		
				~				
				<input type="text" name="e_policy_date" class="txtbox" size='10' value="<%=Left(e_policy_date,10)%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=e_policy_date&code2=&code3=&form_name=frm_group','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="e_policy_date_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>						
				<option value="<%=ii%>" <% If e_policy_date_hour=CStr(i) Then %> selected <% End If %>><%=ii%>�� </option>
				<% Next %>
				</select>
				<select name="e_policy_date_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>						
					<option value="<%=ii%>" <% If e_policy_date_minute=CStr(i) Then %> selected <% End If %>><%=ii%>�� </option>
					<% Next %>
				</select>
				
				&nbsp;&nbsp;&nbsp;

				<select name="s_group_code" style="width:150px;font-size:12px;">
				<option value="">����׷�</option>
				<% 			
				
				strSql = " select group_code,group_name from code_group order by group_name ASC"
				set objRs1=objCnn.Execute(strSql)

				Do until objRs1.EOF
					group_code1		= objRs1(0)
					group_name1		= objRs1(1)
				%>                      							
				<option value="<%=group_code1%>" <% If s_group_code=group_code1 Then %> selected <% End If %>><%=group_name1%></option>
				<%
				objRs1.movenext
				Loop
				%>
				</select>
				<img src="/images/button/btn_search01.gif" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="submit();">

			</td>
			<td  style="style-border:none;text-align:right;"><a href="policy_regist.asp?page=<%=page%>"><img src="/images/button/btn_policy_new.gif"></a></td>
		</tr>
		<tr height=30>             
			<td class="head" width=50>��ȣ</td>
			<td class="head" width=200>��å����</td>
			<td class="head" width=200>����׷�</td>
			<td class="head" width=100>��å����</td>
			<td class="head" width=150>�ۼ�����</td>
			<td class="head" width=200>�۾�</td>
		</tr>
  <%

  strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
  strSql = strSql & "	from charge_policy  A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code "
  strSql = strSql & "		where 1=1 "

  If s_group_code<>"" Then
	strSql = strSql &		" and  A.group_code='"& s_group_code &"' "
  End if

  If s_policy_date<>"" Then
	strSql = strSql &		" and  A.policy_date>='"& s_policy_date1 &"' "
  End if

  If e_policy_date<>"" Then
	strSql = strSql &		" and  A.policy_date<='"& e_policy_date1 &"' "
  End if

  strSql = strSql & "			order by policy_date Desc, writeday desc "
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  If objRs.eof Or objRs.bof Then
  paging_chk="X"
  %>
		<tr height=30>
			<td colspan='6' class="con5">
				��å�� �������� �ʽ��ϴ�.
			</td>
		</tr>
  <%
  Else
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  i=1
  Do Until objRs.eof Or i>objRs.PageSize 
	  policy_idx		= objRs("policy_idx")
	  policy_date		= fnc_date_change(objRs("policy_date"))
	  group_code		= objRs("group_code")
	  group_name		= objRs("group_name")
	  writeday			= fnc_date_change(objRs("writeday"))
	  %>
		<tr height=30>
			<td class='con5'><%=i%></td>
			<td class='con4'> <a href="policy_regist.asp?policy_idx=<%=policy_idx%>&page=<%=page%>"><%=policy_date%></a></td>
			<td class="con2">&nbsp;<b>
				<a href="group_list.asp?policy_idx=<%=policy_idx%>" onmouseover="toggle_calendar(document.all.<%="HideShow1"&i%>);" onmouseout="toggle_calendar(document.all.<%="HideShow1"&i%>);"><%=group_name%></a></b>
				<div id="<%= "HideShow1"&i%>" style="with:200px;visibility:hidden;position:absolute; z-index:1" class="pop"> 
					<table width='200' style="background:#f9f9f9;border:1px solid black;font-size:12px;">
					<tr height='30'>
						<td style="text-align:left;background:gray;">&nbsp;<b><span style="color:white;"> �ŷ�ó �� </span></b></td>
					</tr>
					<% 
					strSql = "select dealer_name from dealer_info where dealer_group_code='"&group_code&"' and dealer_view='Y'"
					Set objRs1=objCnn.Execute(strSql)
					k=1
					Do Until objRs1.eof
						dealer_name = objRs1("dealer_name")
					%>
					<tr height='30'>
						<td style="text-align:left;">&nbsp;<b> <%=k%>. <%=dealer_name%> </b></td>
					</tr>
					<%
						k=k+1
						objRs1.movenext
					loop
					%>
					</tr>
					</table>	
				</div>			
			</td>
			<td class="con4"><a href="/charge/charge_copy.asp?policy_idx=<%=policy_idx%>&s_group_code=<%=s_group_code%>&e_policy_date=<%=e_policy_date1%>&s_policy_date=<%=s_policy_date1%>"><img src="/images/button/btn_pay_gicho.gif"></a></td>
			<td class="con4"><%=writeday%></td>
			<td class="con4">
				<a href="javascript:send_batch('charge_batch.asp?policy_idx=<%=policy_idx%>&group_code=<%=group_code%>&s_group_code=<%=s_group_code%>&page=<%=page%>')"><img src="/images/button/btn_accounts_application.gif" align='absmiddle'></a>
				<!--| 
				<a href="javascript:send_policy('/policy/a_policy_regist.asp?charge_idx=<%=policy_idx%>&group_code=<%=group_code%>&chk=new')"><img src="/images/button/btn_policy_send.gif" align='absmiddle'></a>
				-->
				</td>

		</tr>		
  <%
	i=i+1
	objRs.movenext
  loop
  End if
  %>
		</table>

		<div class="pagelist">
			<%
			mychoice=10

			link_url = "policy_list.asp?s_policy_date="& s_policy_date &"&s_policy_date_hour="& s_policy_date_hour &"&s_policy_date_minute="&s_policy_date_minute&"&e_policy_date="& e_policy_date&"&e_policy_date_hour="& e_policy_date_hour&"&e_policy_date_minute="& e_policy_date_minute &"&e_group_code="&e_group_code&"&s_group_code="&s_group_code &"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>
		</form>
		<!------------------ ���� ����  ------------------>
	</td>
</tr>
<tr>
	<td>
		<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
