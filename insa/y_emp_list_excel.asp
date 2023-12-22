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
  Login_chk(Session_m_id)

  filename="직영사원관리(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename
  
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  m_dealer_code		= WORD_CHANGE(Request("m_dealer_code"),20)  

  If m_dealer_code="" Then
	Alert_back " 잘못된 접근입니다."
	Response.end
  End if
  %>

<meta http-equiv=Content-Type content='text/html; charset=ks_c_5601-1987'> 
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

<TABLE width="1500" cellspacing=1 cellpadding=0 border=1>
<tr height=25>             
	<td bgcolor='gray'>사원명</td>
	<td bgcolor='gray'>주민번호</td>
	<td bgcolor='gray'>사원 아이디</td>
	<td bgcolor='gray'>소 속</td>
	<td bgcolor='gray'>부 서</td>
	<td bgcolor='gray'>직 급</td>
	<td bgcolor='gray'>연락처</td>
	<td bgcolor='gray'>우편번호</td>
	<td bgcolor='gray'>주소</td>
	<td bgcolor='gray'>이메일</td>
	<td bgcolor='gray'>은행명</td>
	<td bgcolor='gray'>계좌번호</td>
	<td bgcolor='gray'>퇴직여부</td>
</tr>

  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  strSql = " select A.m_idx, A.m_name, A.m_id, A.m_jumin1, A.m_jumin2, A.m_htel1+'-'+A.m_htel2+'-'+A.m_htel3 as m_tel, "
  strSql = strSql & " A.m_passwd, A.m_jumin1, A.m_jumin2, A.m_dealer_code, A.m_status, B.duty_name, C.position_name,"
  strSql = strSql & " D.bank_name, G.dealer_name, A.m_email, A.m_bank_no, "
  strSql = strSql & " A.m_zipcode1 , A.m_zipcode2, A.m_address  "
  strSql = strSql & " from emp_list A left outer "
  strSql = stRSql & "		 join code_duty B on A.m_duty=B.duty_code "
  strSql = strSql & "	left Join code_position C ON A.m_position=C.position_code "
  strSql = strSql & "	left Join code_bank D ON A.m_bank_cd=D.board_idx "
  strSql = strSql & "	   left join  from dealer_info G ON G.dealer_code=A.m_dealer_code	"
  strSql = strSql & "		where  1=1 "

  If search_key<>"" then
	strSql = strsql & "			and (A."&search_key&" like '%"&search_txt&"%') "
  End If
  
  If m_dealer_code<>"" Then
	strSql = strSql & "			and (A.m_dealer_code='"& m_dealer_code &"') "
  End if
  strSql = strSql & "				order by A.m_idx desc"
  'Response.write stRSql
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
	
  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page  	
  		 
  i = 1
  Do until objRs.EOF 
  	m_idx			= objRs("m_idx")			'사원 일련번호
  	m_name			= objRs("m_name")			'사원 이름
	m_id			= objRs("m_id")				'사원 아이디
	m_passwd		= objRs("m_passwd")			'사원 비밀번호
	m_tel			= objRs("m_tel")			'사원 연락처
	bank_name		= objRs("bank_name")		'은행 명
	duty_name		= objRs("duty_name")		'회사 부서
	position_name	= objRs("position_name")	'회사 직책
	dealer_name		= objRs("dealer_name")		'거래처 명
    m_dealer_code1	= objRs("m_dealer_code")
	m_status		= objRs("m_status")			'종사자/퇴사자

	m_zipcode1		= objRs("m_zipcode1")
	m_zipcode2		= objRs("m_zipcode2")
	m_address		= objRs("m_address")

	m_jumin1		= objRs("m_jumin1")
	m_jumin2		= objRs("m_jumin2")
	m_email			= objRs("m_email")
	m_bank_no		= objRs("m_bank_no")
	m_bank_name		= objRs("bank_name")		
   	if m_status="X" then
   	   status_text="<span class='red'>퇴직자</span>"
   	else
   	   status_text="종사자"
   	end if
  %>	
<tr height=25>
	<td><%=m_name%></td>
	<td><%=m_jumin1%>-<%=m_jumin2%></td>
	<td><%=m_id%></td>
	<td><%=dealer_name%></td>
	<td><%=duty_name%>&nbsp;</td>
	<td><%=position_name%>&nbsp;</td>
	<td><%=m_tel%>&nbsp;</td>
	<td><%=m_zipcode1%>-<%=m_zipcode2%>&nbsp;</td>
	<td><%=m_address%>&nbsp;</td>
	<td><%=m_email%>&nbsp;</td>
	<td><%=m_bank_name%>&nbsp;</td>
	<td><%=m_bank_no%>&nbsp;</td>
	<td><%=status_text%></td>     
</tr>

  <% 
  	objrs.MoveNext
  	i=i+1 
  Loop
  End if
  objRs.close
  %>	
</table>
	