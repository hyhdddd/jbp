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
  <%
  Login_chk(Session_m_id)

  %>

<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<Script language="javaScript">
<!--
	function frm_submit(form_name)
	{
		var frm			= document.getElementById(form_name);

		if(frm.c_name.checked==false && frm.c_tel1.checked==false && frm.c_tel2.checked==false && frm.c_address.checked==false && frm.g_address.checked==false && frm.c_jumin2.checked==false && frm.c_email.checked==false && frm.g_bank_no.checked==false && frm.g_bank_jumin2.checked==false && frm.g_card_no.checked==false && frm.g_card_gigan.checked==false && frm.g_sp_bank_acount.checked==false && frm.g_sp_bank_jumin2.checked==false && frm.g_move_jumin2.checked==false && frm.g_move_tel1.checked==false && frm.g_move_tel2.checked==false && frm.g_card_jumin2.checked==false)
		{
			alert(" 하나 이상의 선택해주세요!"); 
			return;
		}


		ans=confirm("한번 처리한 데이터는 복구가 불가능합니다. 신중하게 처리해 주시기 바랍니다. \n\n 마킹처리 하시겠습니까?");

		if (ans==true)
		{
			frm.submit();
		}

	} 
-->
</Script>

<style>

/*버튼*/

.button_orange{
border:1px solid #ff7000;
-webkit-border-radius: 3px;
-moz-border-radius: 3px;
border-radius: 3px;
font-size:11px;
color:#fff;
padding: 4px 12px 0 12px;
text-decoration:none;
display:inline-block;
background-color: #ff7000;
}

.button_orange:hover{
border:1px solid #6c6c6c;
color: #fff;
background-color: #6c6c6c;
}
</style>
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
				
		<div class="sub_title"><img src="/images/common/sub08_t08.gif"></div>

		<form id="frm_password" name="frm_password" Method="POST" action="password_regist_ok.asp">

		<table width="100%" border="1" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>&nbsp;&nbsp;
			  	<!--#include virtual="/include/asp/code_menu_list.asp"-->
			</td>
		</tr>
		</table>

		<!------------------ 내용 시작  ------------------>			
		
		<TABLE width="1000" cellspacing=1 cellpadding=0 border=0 id="board_table3">  
		<tr height="40">
			<th align="center" colspan="8">데이터 일괄 (*) 처리</th>
		</tr>
		<tr height="30">
			<!-------- 고객명 --------->
			<td width="150" class='con5'>고객명(3번째) : <input type="checkbox" name="c_name" value="Y" checked></td>

			<!-------- 전화번호 --------->
			<td width="150" class='con5'>전화번호 : <input type="checkbox" name="c_tel1" value="Y" checked></td>

			<!-------- 핸드폰 --------->
			<td width="150" class='con5'>핸드폰 : <input type="checkbox" name="c_tel2" value="Y" checked></td>

			<!-------- 주소 --------->
			<td width="150" class='con5'>주소 : <input type="checkbox" name="c_address" value="Y" checked></td>

			<!-------- 설치장소 --------->
			<td width="150" class='con5'>설치장소 : <input type="checkbox" name="g_address" value="Y" checked></td>

			<!-------- 주민번호 --------->
			<td width="150" class='con5'>주민번호 : <input type="checkbox" name="c_jumin2" value="Y" checked></td>

			<!-------- 이메일 --------->
			<td width="150"  class='con5'>이메일 : <input type="checkbox" name="c_email" value="Y" checked></td>
		</tr>
		<tr height="30">
			<!-------- 납부계좌 --------->
			<td width="150" class='con5'>납부계좌  : <input type="checkbox" name="g_bank_no" value="Y" checked></td>

			<!-------- 납부주민번호 --------->
			<td width="150" class='con5'>납부주민번호 : <input type="checkbox" name="g_bank_jumin2" value="Y" checked></td>

			<!-------- 카드번호 --------->
			<td width="150" class='con5'>카드번호 : <input type="checkbox" name="g_card_no" value="Y" checked></td>

			<!-------- 유효기간 --------->
			<td width="150"  class='con5'>유효기간 : <input type="checkbox" name="g_card_gigan" value="Y" checked></td>

			<!-------- 사은품계좌 --------->
			<td width="150"  class='con5'>사은품계좌  : <input type="checkbox" name="g_sp_bank_acount" value="Y" checked></td>

			<!-------- 사은품 주민번호 --------->
			<td width="150"  class='con5'>사은품 주민번호 : <input type="checkbox" name="g_sp_bank_jumin2" value="Y" checked></td>

			<!-------- 번호이동 주민번호 --------->
			<td width="150"  class='con5'>번호이동 주민번호 : <input type="checkbox" name="g_move_jumin2" value="Y" checked></td>
		</tr>
		<tr height="30">
			<!-------- 번호이동 연락처 --------->
			<td width="150"  class='con5'>번호이동 연락처 : <input type="checkbox" name="g_move_tel1" value="Y" checked></td>

			<!-------- 번호이동 휴대폰 --------->
			<td width="150"  class='con5'>번호이동 휴대폰: <input type="checkbox" name="g_move_tel2" value="Y" checked></td>

			<!-------- 카드 주민번호 --------->
			<td width="150"  class='con5'>카드 주민번호 : <input type="checkbox" name="g_card_jumin2" value="Y" checked></td>

			<td width="150"  class='con5'></td>
			<td width="150"  class='con5'></td>
			<td width="150"  class='con5'></td>
			<td width="150"  class='con5'></td>

			
		</tr>
		<tr height="30">
			<td colspan="8" class='con2' >&nbsp;&nbsp;&nbsp;
				<span style='color:red;'>* 한번 마킹처리된 데이터는 복구가 불가능 하니 신중하게 처리해 주시기 바랍니다.</span></td>
		</tr>
		<tr height='30'>
			<td width="150" class='con5'>적용기간</td>
			<td colspan="26" class='con5'>접수일 : 
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_password','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~<input type="text" name="s_date_end" size='9' class="txtbox"  value="<%=s_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_password','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr height="30" >
			<td colspan="26" class='con5' align="center" class="etcmenu">
				<a href="javaScript:frm_submit('frm_password');" class="etc_txt"><b class='button_orange'> 적용하기</b></a>
			</td>
		</tr>
		</table>

		</form>
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
<tr>
	<td>
		<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
