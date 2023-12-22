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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)
  
  if ad_b_a_custom="N" And ad_b_m_custom="N" then
 	Alert session_m_name &" 님은 고객 상품 관리 권한이 없습니다. 관리자에게 문의하세요!"
	win_close()
  end if	  

  g_goods_idx		=WORD_CHANGE(request("g_goods_idx"),0)

  %>
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function submit_ok(form_name)
	{
		var frm=eval("document.all."+form_name);

		if(frm.g_date_yuchi.value=="" && frm.g_trans_out_dealer.value=="" && frm.g_code_gaetong.value=="" && frm.g_service_no.value=="" && frm.g_date_gaetong.value=="" && frm.g_sp_give_type.value=="" && frm.g_sp_date_start.value=="" && frm.g_sp_date_end.value=="" && frm.date1_chk.checked==false && frm.date2_chk.checked==false && frm.date3_chk.checked==false && frm.date3_chk.checked==false && frm.g_cancel_date.value=="")
		{
			alert(" 하나 이상의 항목을 입력하시거나, 선택해 주세요!");
			return;
		}
		ans=confirm("일괄처리 내역을 저장하시겠습니까?")
		if(ans==true)
		{
			frm.submit();
		}
	}
-->
</script>

<div class="sub_title"><img src="/images/common/sub01_t05.gif"></div>

<form id="frm_custom_regist" name="frm_custom_regist" action="a_custom_goods_batch_ok.asp" METHOD="POST"> 
<input type="hidden" name="g_goods_idx" value="<%=g_goods_idx%>">

<table width=400 border=0 cellspacing="0" cellpadding="0" id="board_table3">
<tr height="30">
	<th width="100"> 상 부 점 </th>
	<td width="300">
		<select name="g_trans_out_dealer" style="width:130px;">
		<option value="">:: 회사 선택::</option> 
			<% 
			strSql = " select dealer_code, dealer_name from dealer_info "
			strSql = strSql & " where (dealer_ingea='Y' and dealer_view='Y') order by dealer_name ASC"
			set objRs=objCnn.Execute(strSql)

			Do until objRs.EOF
				dealer_code=objRs(0)
				dealer_name=objRs(1)
			%>                      	
			<option value="<%=dealer_code%>" <% if dealer_code=g_trans_out_dealer then %> selected <% end if %>><%=dealer_name%></option>
			<%
				objRs.movenext
			Loop
			%>
		</select>
	</td>
</tr>
<tr height="30"> 
	<th width="100"> 개통상태 </th>
	<td width="300">
		<select name="g_code_gaetong" style="width:130px;">
			<option value=""> 개통상태
			<% 
			strSql = " select gaetong_code, gaetong_name from code_gaetong order by gaetong_order Asc"
			Set objRs=objCnn.Execute(strSql)

			if objRs.BOF or objRs.EOF then
			else
				 
			i = 1
				Do until objRs.EOF   	
					gaetong_code		= objRs("gaetong_code")
					gaetong_name		= objRs("gaetong_name")
			%>	
				<option value="<%=gaetong_code%>"><%=gaetong_name%></option>
			<% 
					objrs.MoveNext
					i=i+1 
				Loop
			End if
			%>	
		</select>
	</td>
</tr>
<tr height="30"> 
	<th width="100"> 유치일	</th>
	<td width="300">
		<input type="text" name="g_date_yuchi" class="txtbox" size='10' value="<%=g_date_yuchi%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_date_yuchi&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';" align='absmiddle'>	
		
				<select name="g_date_yuchi_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>
						
					<option value="<%=ii%>" <% If g_date_yuchi_hour=i Then %> selected <% End If %>><%=ii%>시 </option>
					<% Next %>
				</select>
				<select name="g_date_yuchi_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>
						
					<option value="<%=ii%>" <% If g_date_yuchi_minute=i Then %> selected <% End If %>><%=ii%>분 </option>
					<% Next %>
	</td>
</tr>
<tr height="30"> 
	<th width="100"> 개통일	</th>
	<td width="300">
		<input type="text" name="g_date_gaetong" class="txtbox" size='10' value="<%=g_date_gaetong%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_date_gaetong&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		<input type="checkbox" name="date1_chk" value="Y"></font>&nbsp;&nbsp;<span class='red'>날짜 삭제</span>
	</td>
</tr>
<tr height="30"> 
	<th width="100"> 해지일	</th>
	<td width="300">
		<input type="text" name="g_cancel_date" class="txtbox" size='10' value="<%=g_cancel_date%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_cancel_date&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		<input type="checkbox" name="date4_chk" value="Y"></font>&nbsp;&nbsp;<span class='red'>날짜 삭제</span>
	</td>
</tr>
<tr height="30"> 
	<th width="100">
		가입서비스번호
	</th>
	<td width="300">
		<input type="text" name="g_service_no" size="15" class="txtbox" value="<%=g_service_no%>" onFocus="FocusColor(this);" onblur="BlurColor(this);">
	</td>
</tr>
<tr height="30">
	<th> 사은품 지급처 </th>
	<td>
		<select name="g_sp_give_type" style="background-color:#849ca5;">
		<option value="" <% If g_sp_give_type="" Then %> selected <% End If %>> 지급자 선택 </option>
		<option value="A" <% If g_sp_give_type="A" Then %> selected <% End If %>> 유치자 지급 </option>
		<option value="B" <% If g_sp_give_type="B" Then %> selected <% End If %>> 고객센터 (자체) </option>
		<option value="C" <% If g_sp_give_type="C" Then %> selected <% End If %>> 고객센터 (상부) </option>
		<option value="E" <% If g_sp_give_type="E" Then %> selected <% End If %>> 사은품 없음 </option>
		<option value="F" <% If g_sp_give_type="F" Then %> selected <% End If %>> 본사상품권 + 현금 </option>
		</select>
	</td>
</tr>
<tr height="30"> 
	<th width="100"> 사은품 지급 예정 </th>
	<td width="300">
		<input type="text" name="g_sp_date_start" class="txtbox" size='10' value="<%=g_sp_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		<input type="checkbox" name="date2_chk" value="Y"></font>&nbsp;&nbsp;<span class='red'>날짜 삭제</span>
	</td>
</tr>
<tr height="30">
	<th width="100"> 사은품 지급 완료 </th>
	<td width="300">
		<input type="text" name="g_sp_date_end" class="txtbox" size='10' value="<%=g_sp_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_end&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		<input type="checkbox" name="date3_chk" value="Y"></font>&nbsp;&nbsp;<span class='red'>날짜 삭제</span>
	</td>
</tr>
<tr height="30">
	<td colspan='2' align='center'>
		<img src="/images/button/btn_save.gif" border=0 onclick="submit_ok('frm_custom_regist');">
	</td>
</tr>
</tr>				
</table>
