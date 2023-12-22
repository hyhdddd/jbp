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
 	Alert_back session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	 
    
  g_charge_idx		= WORD_CHANGE(request("g_charge_idx"),0)
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script type="text/javascript">
function submit_ok(form_name)
{
	var frm	 = document.getElementById(form_name);

	ans = confirm("정산 내역을 저장하시겠습니까?")
	if(ans==true)
	{
		frm.submit();
	}
}
</script>


<div class="outerContainer">


	<form id="frm_custom" name="frm_custom" action="a_charge_batch_ok.asp" METHOD="POST"> 
	<input type="hidden" name="g_charge_idx" value="<%=g_charge_idx%>">

	<table width=98% border=0 cellspacing="0" cellpadding="0" class="table_css" style="margin:0 auto;">
	<tr height='30'>
		<td colspan='2' style='text-align:left;'>&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;<b>일괄 정산 </b></td>
	</tr>
	<tr height="30"> 
		<th width="20%" class="head_Gray_TLB">약정금액(+) </th>
		<td width="80%" class="list_TLBR_left"><input type="text" class="txtbox" name="g_charge_promise" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>	
	<tr height="30"> 
		<th class="head_Gray_LB">본사 사은품(-) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_sp_top" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>	
	<tr height="30"> 
		<th class="head_Gray_LB">사은품(-) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_sp" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>	
	<tr height="30"> 
		<th class="head_Gray_LB">할인탭(-) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_sale" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>	
	<tr height="30"> 
		<th class="head_Gray_LB">기타차감(-) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_gita" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB">번들수수료(+) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_bundle" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB">부가서비스(+) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_buga" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>		
	<tr height="30"> 
		<th class="head_Gray_LB">결합수수료(+) </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_combine" size="9" maxlength="9" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">원</td>
	</tr>	
	<tr height="30"> 
		<th class="head_Gray_LB">정산 메모 </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" name="g_charge_bigo" size=30 maxlength=30></td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB">정산 예정</th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date1" class="txtbox" size='10' readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date1&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			<input type="checkbox" name="date1_chk" value="Y"></font>&nbsp;&nbsp;<span class='red'>날짜 삭제</span>
		</td>
	</tr>
	<tr>
		<th class="head_Gray_LB">정산 완료</th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date2" class="txtbox" size='10' readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date2&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			<input type="checkbox" name="date2_chk" value="Y"></font>&nbsp;&nbsp;<span class='red'>날짜 삭제</span>
		</td>
	</tr>
	<tr height="30">
		<td colspan='2' align='center'>
			<span class="btn_m_white01" onclick="submit_ok('frm_custom');">저장하기</span>
		</td>
	</tr>			
	</table>
</div>