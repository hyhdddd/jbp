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
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  filename="전체가망고객(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  Login_chk(Session_m_id)

  if ad_g_a_gamang<>"A" then
 	Alert_URL session_m_name &" 님은 고객 엑셀다운 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
	Response.end
  end if	
  
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20) 

  s_search_key		= WORD_CHANGE(Request("s_search_key"),20)
  s_option_idx		= WORD_CHANGE(Request("s_option_idx"),20)
 
  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">

<style type="text/css">
<!--  
	A:link    {color:#000000;text-decoration:none;}
	A:visited {color:#000000;text-decoration:none;}
	A:active  {color:#000000;text-decoration:none;}
	A:hover  {color:#8CC84B;text-decoration:none}

	body 
	{
		scrollbar-face-color: #ffffff; scrollbar-shadow-color: #666666; 
		scrollbar-highlight-color: #666666; scrollbar-3dlight-color: #ffffff; 
		scrollbar-darkshadow-color: #ffffff; scrollbar-track-color: #ffffff;
		scrollbar-arrow-color: #666666
	}
	td	{font: 9pt 돋움,GulimChe,Gulim;color: black;}	
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

<!------------------ 내용 시작  ------------------>

<table width="1300" cellspacing=1 cellpadding=0 border=1>  
<tr height='30'>
	<td bgcolor='gray' width="20">NO</td>
	<td bgcolor='gray' width="60">접수자</td>
	<td bgcolor='gray' width="100">고객명</td>
	<td bgcolor='gray' width="100">주민번호</td>
	<td bgcolor='gray' width="100">연락처</td>
	<td bgcolor='gray' width="100">휴대폰</td>
	<td bgcolor='gray' width="200">주소</td>
	<td bgcolor='gray' width="150">사은품</td>

	<td bgcolor='gray' width="150">상품1</td>
	<td bgcolor='gray' width="150">상품1_내용</td>

	<td bgcolor='gray' width="150">상품2</td>
	<td bgcolor='gray' width="150">상품2_내용</td>

	<td bgcolor='gray' width="150">상품3</td>
	<td bgcolor='gray' width="150">상품3_내용</td>

	<td bgcolor='gray'>최종상담</td>
	<td bgcolor='gray' width="250">비고</td>

	<td bgcolor='gray' width="120">접수일</td>
</tr>
<%
 
  strSql =  " select A.c_m_gamang_idx, A.c_m_name, A.c_m_course_idx, A.c_m_m_id, A.c_m_address, A.c_m_consult_type, "
  strSql = strSql & " A.c_m_consult_bigo, A.c_m_htel1, A.c_m_mtel1, A.c_m_writeday, B.m_name, A.c_m_jumin1, A.c_m_jumin2, "
  strSql = strSql & " A.c_m_content, A.c_m_goods, A.c_m_use_goods1, A.c_m_use_goods2, A.c_m_use_goods3, "
  strSql = strSql & " A.c_m_use_goods1_gita, A.c_m_use_goods2_gita, A.c_m_use_goods3_gita "

  strSql = strSql & " 		from customer_gamang A left outer  "
  strSql = strSql & " 			join emp_list B on  A.c_m_m_id=B.m_id "
  strSql = strSql &  "				WHERE 1=1 "

  If search_txt<>"" Then
	If search_key="m_name" Then
		strSql = strSql & "		and A.c_m_m_id in (select m_id from emp_list where m_name like '%"&search_txt&"%') "
	else
		strSql = strSql & "		and A."&search_key&" like '%"&search_txt&"%'"
	End If
  End If

  If s_search_key<>"" Then
	'접수일 검색
	strSql = strSql & "			and (A."&s_search_key&">='"&s_date_start&" 00:00:00') "
	strSql = strsql & "			and (A."&s_search_key&"<='"&s_date_end&" 23:59:59') "
  End If
  
  strSql = strSql & "					order by A.c_m_gamang_idx desc "
  
  'Response.write strsql
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15

  recordcount	= objRs.recordcount

  if objRs.BOF or objRs.EOF Then
  paging_chk="X"
%>
<tr>
	<td colspan='21'> 고객 등록상품이 없습니다. </td>
</td>
<%
  else
  i=1
  Do until objRs.EOF
 		c_m_gamang_idx		= objRs("c_m_gamang_idx")
  		c_m_m_id			= objRs("c_m_m_id")
		c_m_name			= Left(objRs("c_m_name"),6)
		c_m_address			= Left(objRs("c_m_address"),15)
		c_m_htel1			= objRs("c_m_htel1")
		c_m_mtel1			= objRs("c_m_mtel1")
		c_m_writeday		= fnc_date_change(objRs("c_m_writeday"))
		m_name				= objRs("m_name")
		c_m_consult_bigo	= objRs("c_m_consult_bigo")
		c_m_jumin1			= objRs("c_m_jumin1")
		c_m_jumin2			= objRs("c_m_jumin2")
		c_m_goods			= objRs("c_m_goods")
		c_m_content			= objRs("c_m_content")

  		c_m_use_goods1		= objRs("c_m_use_goods1")
  		c_m_use_goods2		= objRs("c_m_use_goods2")
  		c_m_use_goods3		= objRs("c_m_use_goods3")
  		c_m_use_goods1_gita	= objRs("c_m_use_goods1_gita")
  		c_m_use_goods2_gita	= objRs("c_m_use_goods2_gita")
  		c_m_use_goods3_gita	= objRs("c_m_use_goods3_gita")


%>
<tr height='30'>
	<td><%=i%></td>
	<td style="mso-number-format:\@"><%=m_name%></td>
	<td style="mso-number-format:\@"><%=c_m_name%></td>
	<td style="mso-number-format:\@"><%=c_m_jumin1%>-<%=c_m_jumin2%></td>
	<td style="mso-number-format:\@"><%=c_m_mtel1%></td>
	<td style="mso-number-format:\@"><%=c_m_htel1%></td>
	<td style="mso-number-format:\@"><%=c_m_address%></td>
	<td style="mso-number-format:\@"><%=c_m_goods%></td>

	<td style="mso-number-format:\@"><%=c_m_use_goods1%></td>
	<td style="mso-number-format:\@"><%=c_m_use_goods1_gita%></td>
	<td style="mso-number-format:\@"><%=c_m_use_goods2%></td>
	<td style="mso-number-format:\@"><%=c_m_use_goods2_gita%></td>
	<td style="mso-number-format:\@"><%=c_m_use_goods3%></td>
	<td style="mso-number-format:\@"><%=c_m_use_goods3_gita%></td>

	<td style="mso-number-format:\@"><%=c_m_consult_bigo%></td>
	<td style="mso-number-format:\@"><%=c_m_content%></td>
	<td style="mso-number-format:\@"><%=c_m_writeday%></td>
</tr>
<%
i=i+1
objRs.movenext
Loop
End If

%>		  
</div>
</table>


  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>