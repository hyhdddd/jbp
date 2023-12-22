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
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
  end if	 

  s_article_idx1		= WORD_CHANGE(money_chk(Request("ss_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("ss_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("ss_option_idx")),20)
  s_gaetong_code		= WORD_CHANGE(Request("ss_gaetong_code"),20)
  s_date_start			= WORD_CHANGE(Request("ss_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("ss_date_end"),20)
  date_chk				= WORD_CHANGE(Request("ss_date_chk"),20)
  g_yuchi_m_id			= WORD_CHANGE(request("g_yuchi_m_id"),0)
  %>
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script type="text/javascript">

function fnc_exact_regist(form_name)
{
	var frm = document.getElementById(form_name);

	if(frm.g_charge_date2.value=="" && frm.g_charge_date1.value=="")
	{
		alert(" 항목을 하나 이상 선택해 주세요!");
		return;
	}
	ans=confirm("일괄처리 내역을 저장하시겠습니까?")

	if(ans==true)
	{
		frm.submit();
	}
}

</script>

<div class="outerContainer">

	<form id="frm_exact" name="frm_exact"  action="a_exact_personal_batch_ok.asp" METHOD="POST"> 
	<input type="hidden" name="g_yuchi_m_id" value="<%=g_yuchi_m_id%>">
	<input type="hidden" name="s_gaetong_code" value="<%=s_gaetong_code%>">
	<input type="hidden" name="s_date_start" value="<%=s_date_start%>">
	<input type="hidden" name="s_date_end" value="<%=s_date_end%>">
	<input type="hidden" name="date_chk" value="<%=date_chk%>">

	<input type="hidden" name="s_article_idx1" value="<%=s_article_idx1%>">
	<input type="hidden" name="s_article_idx2" value="<%=s_article_idx2%>">
	<input type="hidden" name="s_option_idx" value="<%=s_option_idx%>">

	<table width="100%" border=0 cellspacing="0" cellpadding="0" class="table_css">
	<tr height='30'>
		<td colspan='2' style='text-align:left;'>&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;<b>일괄 처리 </b></td>
	</tr>
	<tr>
		<th width='20%' class="head_Gray_TLB"> 정산 예정일 </th>
		<td width='80%' class="list_TLBR_left">
			<input type="text" name="g_charge_date1" class="txtbox" size='10' readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date1&code2=&code3=&form_name=frm_exact','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		</td>
	</tr>
	<tr>
		<th class="head_Gray_LB"> 정산 완료일 </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date2" class="txtbox" size='10' readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date2&code2=&code3=&form_name=frm_exact','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		</td>
	</tr>
	</table>

	<div class="alignCenter">
		<span class="btn_m_white01" onclick="fnc_exact_regist('frm_exact');">저장하기</span>
	</div>		

	</form>
</div>