  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  page				= WORD_CHANGE(Request("page"),20)
  policy_idx		= WORD_CHANGE(Request("policy_idx"),20)

  If policy_idx<>"" Then
	strsql = " select * from charge_policy where policy_idx="&policy_idx
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		policy_idx =""
	Else
		group_code			= objRs("group_code")
		policy_date			= objRs("policy_date")	
		policy_date_hour	= Hour(policy_date)
		policy_date_minute	= minute(policy_date)
	End if
  End if

  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function send_policy_write(form_name)
	{
		var frm=eval("document.all."+form_name);
		if(frm.policy_date.value=="")
		{
			alert(" 정책일자를 입력해 주세요! ");
			return;
		}

		if(frm.group_code.value=="")
		{
			alert(" 정산그룹을 선택해 주세요! ");
			return;
		}

		
		frm.submit();
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF" height='400'> 
	<td valign='top' align='center'>
		
		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub06_t05.gif"></div>

		<form name="frm_group" action="policy_regist_ok.asp"  METHOD="POST">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		<input type="hidden" name="page" value="<%=page%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		</table>	

		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height=30> 
			<th>정책일자 </th>
			<td> 
				<input type="text" name="policy_date" class="txtbox" size='10' value="<%=Left(policy_date,10)%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=policy_date&code2=&code3=&form_name=frm_group','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">

				<select name="policy_date_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>
						
					<option value="<%=ii%>" <% If policy_date_hour=i Then %> selected <% End If %>><%=ii%>시 </option>
					<% Next %>
				</select>  &nbsp;&nbsp;
				<select name="policy_date_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>
						
					<option value="<%=ii%>" <% If policy_date_minute=i Then %> selected <% End If %>><%=ii%>분 </option>
					<% Next %>
				</select>
			</td>
		</tr>	
		<tr height=30> 
			<th> 정산그룹 </th>
			<td> 
				<select name="group_code" style="width:150px;font-size:12px;">
				<option value="">정산그룹</option>
				<% 			
				
				strSql = " select group_code,group_name from code_group order by group_name ASC"
				set objRs1=objCnn.Execute(strSql)

				Do until objRs1.EOF
					group_code1		= objRs1(0)
					group_name1		= objRs1(1)
				%>                      							
				<option value="<%=group_code1%>" <% If group_code=group_code1 Then %> selected <% End If %>><%=group_name1%></option>
				<%
				objRs1.movenext
				Loop
				%>

				</select>
			</td>
		</tr>
		<tr height=30>            
			<td align='center' colspan="2"> 
				<a href="policy_list.asp?tname=<%=tname%>&page=<%=page%>"><img src="/images/button/btn_list.gif"  border="0" align="absmiddle"></a> 
				<img src="/images/button/btn_regist.gif" align="absmiddle" onclick="send_policy_write('frm_group');" onmouseover="this.style.cursor='hand';"> </td>
		</tr>
		</form>	
		</table>
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>