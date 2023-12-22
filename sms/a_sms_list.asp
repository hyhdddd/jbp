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
  
  if ad_c_sms="N" then
 	Alert_URL session_m_name &" 님은 SMS 관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select * from sms_message_cnt where s_o_code='"&o_code &"' "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then		
		strSql = " SELECT ISNULL(MAX(s_board_idx)+1,1) from SMS_MESSAGE_CNT "
		Set objRs=objCnn.Execute(strSql)

		s_board_idx	= objRs(0)

		strSql = " INSERT INTO SMS_MESSAGE_CNT (s_board_idx, s_o_code, s_message1, s_message2, "
		strSql = strSql & " s_writeday)"
		strSql = strSql & " values ("
		strSql = strSql & "  "& s_board_idx &" "
		strSql = strSql & ", '"& o_code &"'"
		strSql = strSql & ", 400, 0 "
		strSql = strSql & ", Getdate()) "	
		Set objRs=objCnn.Execute(strSql)

		strSql = " select * from sms_message_cnt where s_o_code='"&o_code &"'"
		Set objRs=objCnn.Execute(strSql)
  End If

  s_message1	 = objRs("s_message1")		' 남은 갯수
  s_message2	 = objRs("s_message2")		' 사용 갯수.

  objRs.close
  %>  
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
<tr height="400"> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub12_t03.gif"></div>
	
		<form name='frm_emp' method='post' action='a_emp_list.asp'>

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr height='30'>
			<td colspan='4' class="description"> 
				* 업체에서 사용가능한 SMS 문자 내역 입니다. <br>
			</td>
		</tr>				
		<tr height=30> 
			<th width="150">잔여 SMS 건수 </th>
			<td width="250"> &nbsp;&nbsp;<%=s_message1%>건 
			<th width="150">SMS 발송 건수 </th>
			<td width="250"> &nbsp;&nbsp;<%=s_message2%>건
		</tr>					
		</table>

		
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">
			<div style="margin-top:50px;">
				<span onclick="NewWindow('http://entersoft.kr/sms/sms_send_list.asp?o_code=<%=o_code%>','sms_add','1000','700','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/sms_A.gif"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span onclick="NewWindow('/sms/a_sms_pay.asp','sms_add','500','500','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/sms_C.gif"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span onclick="NewWindow('http://entersoft.kr/sms/sms_pay_list.asp?o_code=<%=o_code%>','sms_payment','500','500','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/sms_D.gif"></span>
			</div>
			</td>
		</tr>				
		</table>
		<!------------------ 내용 시작  ------------------>

	</td>
</tr>  
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
  </tr>
</table>
</div>
