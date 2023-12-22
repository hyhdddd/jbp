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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	 

  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)
  g_charge_idx			= WORD_CHANGE(request("g_charge_idx"),20)

  If g_charge_idx<>"" Then 
	strSql = " select * from customer_goods_charge where g_charge_idx="&g_charge_idx
	Set objRs=objCnn.Execute(strSql)

	g_charge_idx		= objRs("g_charge_idx")
	g_charge_type		= objRs("g_charge_type")
	g_goods_idx			= objRs("g_goods_idx")
	
	g_charge_promise	= money_chk(objRs("g_charge_promise"))
	g_charge_sp_top		= money_chk(objRs("g_charge_sp_top"))
	g_charge_sp			= money_chk(objRs("g_charge_sp"))
	g_charge_sale		= money_chk(objRs("g_charge_sale"))
	g_charge_gita		= money_chk(objRs("g_charge_gita"))
	g_charge_bundle		= money_chk(objRs("g_charge_bundle"))
	g_charge_document	= money_chk(objRs("g_charge_document"))
	g_charge_buga		= money_chk(objRs("g_charge_buga"))
	g_charge_combine	= money_chk(objRs("g_charge_combine"))

	g_charge_bigo		= objRs("g_charge_bigo")
	g_charge_bigo_doc	= objRs("g_charge_bigo_doc")
	g_charge_date1		= objRs("g_charge_date1")				'정산 예정일
	g_charge_date2		= objRs("g_charge_date2")				'정산 완료일
  Else
	g_charge_type="A"
  End If 
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script type="text/javascript">
function fnc_exact_del(g_charge_idx,g_goods_idx)
{
	ans=confirm("고객 추가정산을 삭제하시겠습니까? ");
	if(ans==true)
	{
		url="a_charge_del_ok.asp?g_charge_idx="+g_charge_idx+"&g_goods_idx="+g_goods_idx;
		location.replace(url);
	}
}


function fnc_exact_regist(form_name)
{
	var frm	 = document.getElementById(form_name);
	
	frm.submit();
}
    

</script>

<div class="outerContainer">

	<form id="frm_custom" name="frm_custom" action="a_charge_regist_ok.asp" METHOD="POST"> 
	<input type="hidden" name="g_charge_idx" value="<%=g_charge_idx%>">
	<input type="hidden" name="g_goods_idx" value="<%=g_goods_idx%>">

	<table width=100% border=0 cellspacing="0" cellpadding="0" class="table_css">
	<tr height='30'>
		<td class='con9' colspan='2' style='text-align:left;'>&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;<b>고객 입력 내역 </b></td>
	</tr>

	<tr height="30"> 
		<th width='15%' class="head_Gray_TLB"> 약정수수료  </th> 
		<td width='85%' class="list_TLBR_left">
			<input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_promise" value="<%=g_charge_promise%>">원 
			&nbsp;&nbsp;&nbsp;&nbsp;
			<% If g_charge_type="G" Then %>
				<input type="hidden" name="g_charge_type" value="G">
			<% Else %>
				<input type="radio" name="g_charge_type" value="A" <% If g_charge_type="A" Then %> checked <% End If %>>추가
				<input type="radio" name="g_charge_type" value="B" <% If g_charge_type="B" Then %> checked <% End If %>>환수
				<input type="radio" name="g_charge_type" value="C" <% If g_charge_type="C" Then %> checked <% End If %>>VOC 환수
			<% End If %>
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 본사 사은품차감  </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_sp_top" value="<%=g_charge_sp_top%>">원 </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 사은품차감  </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_sp" value="<%=g_charge_sp%>">원</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 할인탭 차감 </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_sale" value="<%=g_charge_sale%>">원 </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 미비서류  </th>
		<td class="list_LBR_left"> 
			<% If g_charge_idx="" Or g_charge_type<>"G" Then %>
				<input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_document" value="<%=g_charge_document%>">원 &nbsp;&nbsp;&nbsp;<span class='red'>일반정산일 경우만 자동계산 됩니다.</span>
			<% Else %>
				<%=money_change(g_charge_document)%> 원 &nbsp;&nbsp;&nbsp;<span class='red'> (자동계산)</span>
			<% End If %>
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 기타차감  </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_gita" value="<%=g_charge_gita%>">원</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 번들 수수료 </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_bundle" value="<%=g_charge_bundle%>">원 </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 부가서비스 </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_buga" value="<%=g_charge_buga%>">원 </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 결합수수료 </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_combine" value="<%=g_charge_combine%>">원 </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 정산 예정  </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date1" class="txtbox" size='10' value="<%=g_charge_date1%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date1&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 정산 완료  </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date2" class="txtbox" size='10' value="<%=g_charge_date2%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date2&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"> 
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 정산 비고  </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_bigo" class="txtbox" size='40' value="<%=g_charge_bigo%>" >
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> 미비서류 비고  </th>
		<td class="list_LBR_left">
			<% If g_charge_idx="" Or g_charge_type<>"G" Then %>
			<input type="text" name="g_charge_bigo_doc" class="txtbox" size='40' value="<%=g_charge_bigo_doc%>" >&nbsp;&nbsp;<span class='red'> 일반정산일 경우만 자동 입력 됩니다. </span>
			<% Else %>
				<%=g_charge_bigo_doc%> &nbsp;&nbsp;<span class='red'>(자동 입력) </span>
			<% End If %>
		</td>
	</tr>
	</table>

	<div class="alignRight">
		<a href="a_charge_list.asp?g_goods_idx=<%=g_goods_idx%>"><span class="btn_m_white01"> 목록으로</span></a>

		<% if ad_r_a_exact="E" or ad_r_a_exact="A" then %>
			<span onClick="fnc_exact_regist('frm_custom');" class="btn_m_white01">저장하기</span>
			<% If g_charge_idx<>""Then %>
			<span onClick="fnc_exact_del('<%=g_charge_idx%>','<%=g_goods_idx%>');" class="btn_m_white01">삭제하기</span>
			<% End If %>
		<% Else %>
			<a href ='javascript:alert("<%=session_m_name%> 님은 권한이 없습니다. 관리자에 문의하세요!");'><span class="btn_m_white01">저장하기</span></a>
		<% End If %>

	</div>
	</form>
</div>