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

  strSql = " select * from company_info where o_code='"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)

  o_com_name	= objRs("o_com_name")
  %>   
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function sms_send(frm_name)
	{
		var frm=eval("document.all."+frm_name);
		ans=confirm(" SMS를 충전 신청 하시겠습니까?");
		if(ans==true)
		{
			frm.submit();
		}
	}
-->
</script>
<body topmargin=0 leftmargin=0 bgcolor="#FFFFFF" text="#000000">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<div class="outerContainer_pop">
<!------------------ 내용 시작  ------------------>
<div class="sub_title"><img src="/images/common/sub12_t04_2.gif"></div>

<form name="frm_sms" method="post" action="http://entersoft.kr/sms/sms_pay_ok.asp">
<input type="hidden" name="s_m_id"		value="<%=Session_m_id%>">
<input type="hidden" name="s_o_code"	value="<%=o_code%>">

<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3">
<tr height="50">
	<th width="100"> 업체명 </th>
	<td>&nbsp;<%=o_com_name%> </td>
</tr>
<tr height="50">
	<th width="100"> 신청자<br>입금자명 </th>
	<td>&nbsp;<%=session("m_name")%></td>
</tr>
<tr height="50">
	<th>결제 건수<br>(건당 20원)</th>
	<Td>
		&nbsp; <input type="radio" name="sms_cnt" style="border-style:none;" value="1000" checked> 1,000 건(22,000원 VAT포함) &nbsp;&nbsp;&nbsp;
		<input type="radio" name="sms_cnt"style="border-style:none;" value="2000"> 2,000 건(44,000원 VAT포함) <br>
		&nbsp; <input type="radio" name="sms_cnt" style="border-style:none;" value="3000"> 3,000 건(66,000원 VAT포함) &nbsp;&nbsp;&nbsp;
		<input type="radio" name="sms_cnt" style="border-style:none;" value="5000"> 5,000 건(110,000원 VAT포함)
	</td>
</tr>
<tr height="50">
	<th width="100"> 결제 계좌번호 </th>
	<td>&nbsp; <span class='blue'>(신협) 132-055-917955 </span></td>
</tr>
<tr height="50">
	<th width="100"> 예금주 </th>
	<td>&nbsp; <span class='blue'> 최안규(엔터소프트) </span></td>
</tr>
<tr height="50">
	<td colspan='2'>
		&nbsp;&nbsp;&nbsp;* 계좌번호를 적어 놓으신 후 <span class='red'>무통장 입금</span>해 주시면 엔터소프트 에서 확인 후
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;즉시 충전해 드립니다.&nbsp;&nbsp;<span class='blue'>부가세는 별도 입니다.</span>
	</td>
</tr>
</table>
</form>

<div class="button">
	<a href="javascript:self.close()""><img src="/images/button/btn_close.gif" border=0 align="absmiddle"></a> 
	<a href="javascript:sms_send('frm_sms');"><img src="/images/button/btn_regist.gif" border=0 align="absmiddle"></a>
</div>				
<!------------------ 내용 종료  ------------------>
</div> 