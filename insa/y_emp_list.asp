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

  if ad_i_y_emp="N" then
	Alert_url session_m_name &" 님은 거래처 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  search_key		= WORD_CHANGE(request("search_key"),20)
  search_txt		= WORD_CHANGE(request("search_txt"),20)
  list_cnt			= WORD_CHANGE(Request("list_cnt"),20)			'출력 갯수

  If list_cnt="" Then	list_cnt="15"  End If

  %> 
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>  
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
<tr bgcolor="#FFFFFF" height='400'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub03_t01.gif"></div>

		<table width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">
		<form name='frm_emp' method='post' action='y_emp_list.asp'>
		<tr height='30'>
			<td colspan='2' class="description">* 내가 속한 회사의 사원 리스트가 나타 납니다.</td>
		</tr>
		<tr height=30> 
			<td style="padding-left:5" style="border-style:none;">
				<select name="search_key" valign='absmiddle' class="txtbox">
					<option value="m_name"> 사원명 </option>				
					<option value="m_id"> 아이디 </option>
				</select>
				<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><img src="/images/button/btn_search01.gif" align='absmiddle' border=0 onClick="Search('frm_emp');">
			</td>
			<td align='right' style="border-style:none;">
				<select name="list_cnt" onchange="submit();">
				<option value="15" <% If list_cnt="15" Then %> selected <% End If %>>15개 출력</option>
				<option value="30" <% If list_cnt="30" Then %> selected <% End If %>>30개 출력</option>
				<option value="50" <% If list_cnt="50" Then %> selected <% End If %>>50개 출력</option>
				<option value="70" <% If list_cnt="70" Then %> selected <% End If %>>70개 출력</option>
				</select>

				<% if ad_i_y_emp="W" OR ad_i_y_emp="E" OR ad_i_y_emp="A" then %>
				<a href="y_emp_regist.asp"><img src="/images/button/btn_new.gif" border="0"></a>
				<% else %>
				<a href='javascript:alert("<%=session_m_name%> 님은 거래처 사원등록 권한이 없습니다. 관리자에 문의하세요!");'>
				<img src="/images/button/btn_new.gif" border="0"></a>
				<% end if %>   
			</td>      					
		</tr>
		</form>	
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head">사원명</td>
			<td class="head">사원 아이디</td>
			<td class="head">사원 비밀번호</td>
			<td class="head">소 속</td>
			<td class="head">부 서</td>
			<td class="head">직 급</td>
			<td class="head">연락처</td>
			<td class="head">퇴직여부</td>
		</tr>

  <%

  strSql = " Select m_dealer_code from emp_list where m_id='"&Session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code		= objRs(0)
  objRs.close

  strSql = " select A.m_idx, A.m_name, A.m_id, A.m_jumin1, A.m_jumin2, A.m_tel1,A.m_tel2, A.m_status, "
  strSql = strSql & " A.m_passwd, A.m_dealer_code, B.duty_name, C.position_name, D.bank_name, E.dealer_name "
  strSql = strSql & " from emp_list A left outer "
  strSql = stRSql & "		 join code_duty B on A.m_duty=B.duty_code "
  strSql = strSql & "	left Join code_position C ON A.m_position=C.position_code "
  strSql = strSql & "	left Join code_bank D ON A.m_bank_cd=D.board_idx " 
  strSql = strSql & "	left join dealer_info E ON  A.m_dealer_code=E.dealer_code "
  strSql = strSql & "		WHERE (A.m_dealer_code='"&m_dealer_code&"') "

  If search_key<>"" then
	strSql = strsql & "			and A."&search_key&" like '%"&search_txt&"%'"
  End if
  strSql = strSql & "				order by A.m_idx desc"
  'Response.write stRSql
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = list_Cnt
	
  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page  	
  recordcount	= objRs.recordcount  		 
  i = 1
  Do until objRs.EOF Or i>objRs.PageSize 
  	m_idx			= objRs("m_idx")			'사원 일련번호
  	m_name			= objRs("m_name")			'사원 이름
	m_id			= objRs("m_id")				'사원 아이디
	m_passwd		= objRs("m_passwd")			'사원 비밀번호
	m_tel1			= objRs("m_tel1")			'사원 연락처
	m_tel2			= objRs("m_tel2")			'사원 연락처
	bank_name		= objRs("bank_name")		'은행 명
	duty_name		= objRs("duty_name")		'회사 부서
	position_name	= objRs("position_name")	'회사 직책
	dealer_name		= objRs("dealer_name")		'거래처 명
    m_dealer_code	= objRs("m_dealer_code")
	m_status		= objRs("m_status")			'종사자/퇴사자		
	

	If m_step="M" Then
		m_passwd = "<span class='red'>******</span>"
	Else
		m_passwd = "<span class='red'>******</span>"
	End if

	
   	if m_status="X" then
   	   status_text="<span class='red'>퇴직자</span>"
   	else
   	   status_text="종사자"
   	end if
  %>	
		<tr height=30>
			<td class="con5"><a href="y_emp_regist.asp?m_id=<%=m_id%>&page=<%=page%>"><%=m_name%></a></td>
			<td class="con4"><%=m_id%></td>
			<td class="con4"><%=m_passwd%></td>
			<td class="con4"><%=dealer_name%></td>
			<td class="con4"><%=duty_name%></td>
			<td class="con4"><%=position_name%></td>
			<td class="con4"><%=m_tel1%></td>
			<td class="con4"><%=status_text%></td>     
		</tr>

  <% 
  	objrs.MoveNext
  	i=i+1 
  Loop
  End if
  %>	
		</table>
		<div class="pagelist">		
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "y_emp_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&list_cnt="&list_cnt&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> 건 ] </span></b>
		</div>						
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>