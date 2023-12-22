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

  if ad_i_a_emp="N" then
	Alert_url session_m_name &" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  search_key		= WORD_CHANGE(request("search_key"),20)
  search_txt		= WORD_CHANGE(request("search_txt"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
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
<tr bgcolor="#FFFFFF"  align='center' height='400'> 
	<td valign='top' align='center'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub03_t02.gif"></div>

		<form name='frm_emp' method='post' action='a_emp_list.asp'>

		<table width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">
		<tr height=30> 
			<td style="padding-left:5" style="border-style:none">
				<select name="search_key" valign='absmiddle' class="txtbox">
				<option value="m_name"> 사원명 </option>				
				<option value="m_id"> 아이디 </option>
				</select>
				<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><img src="/images/button/btn_search01.gif" align='absmiddle' border=0 onClick="Search('frm_emp');">
			</td>
			<td style="border-style:none">
				<select name="s_dealer_code" style="width:130px;" onchange="submit();">
				<option value="">:: 회사 선택::</option>     			
				<% 
				strSql = " select dealer_code, dealer_name from dealer_info order by dealer_name ASC"
				set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF
					dealer_code=objRs(0)
					dealer_name=objRs(1)
				%>                      	
				<option value="<%=dealer_code%>" <% if UCase(dealer_code)=UCase(s_dealer_code) then %> selected <% end if %>><%=dealer_name%></option>
				<%
					objRs.movenext
				Loop
				objRs.close
				%>
				</select>
			</td>
			<td align='right' style="border-style:none">			
				<select name="list_cnt" onchange="submit();">
				<option value="15" <% If list_cnt="15" Then %> selected <% End If %>>15개 출력</option>
				<option value="30" <% If list_cnt="30" Then %> selected <% End If %>>30개 출력</option>
				<option value="50" <% If list_cnt="50" Then %> selected <% End If %>>50개 출력</option>
				<option value="70" <% If list_cnt="70" Then %> selected <% End If %>>70개 출력</option>
				</select>

				<span onclick="NewWindow('/sms/sms_group_regist.asp','sms_group_add','700','500','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_sms.gif" align="absmiddle"></span>

				<% If ad_i_a_emp="A" Then %>
					<a href="a_emp_list_excel.asp?search_key=<%=search_key%>&search_txt=<%=search_txt%>&s_dealer_code=<%=s_dealer_code%>"><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
				<% End If %>

				<% if ad_i_a_emp="W" OR ad_i_a_emp="E" OR ad_i_a_emp="A" then %>
					<a href="a_emp_regist.asp"><img src="/images/button/btn_new.gif" border="0" align="absmiddle"></a>
				<% else %>
					<a href='javascript:alert("<%=session_m_name%> 님은 사원등록 권한이 없습니다. 관리자에 문의하세요!");'>
					<img src="/images/button/btn_new.gif" border="0"  align="absmiddle"></a>
				<% end if %>   
			</td>
		</tr>      			
		</table>
		</form>					

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=25>
			<td class="head">No</td>
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
  strSql = " select A.m_idx, A.m_name, A.m_id, A.m_jumin1, A.m_jumin2, A.m_tel1, a.m_tel2, A.m_step, "
  strSql = strSql & " A.m_passwd, A.m_dealer_code, A.m_status, B.duty_name, C.position_name, D.bank_name, G.dealer_name "
  strSql = strSql & " from emp_list A left outer "
  strSql = stRSql & "		 join code_duty B on  A.m_duty=B.duty_code "
  strSql = strSql & "		left Join code_position C ON A.m_position=C.position_code "
  strSql = strSql & "		left Join code_bank D ON A.m_bank_cd=D.board_idx "
  strSql = strSql & "		left join dealer_info G On A.m_dealer_code=G.dealer_code "
  strSql = strSql & "			where 1=1 "

  If session_m_step="M" Then

  Else
		strSql = strSql & "		and (m_step is null or m_step='S' ) "
  End If
  
  If search_key<>"" then
	strSql = strsql & "			and A."&search_key&" like '%"&search_txt&"%'"
  End If
  
  If s_dealer_code<>"" Then
	strSql = strSql & "			and A.m_dealer_code='"& s_dealer_code &"'"
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
	m_step			= objRs("m_step")
	

	If session_m_step="M" Then
			m_passwd = "<span class='red'>******</span>"
	Else
			m_passwd = "<span class='red'>******</span>"
	End If
	
	If m_step="M" Then
		m_passwd = "<span class='red'>******</span>"
	End if
	
   	if m_status="X" then
   	   status_text="<span class='red'>퇴직자</span>"
   	else
   	   status_text="종사자"
   	end if
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con4"><a href="a_emp_regist.asp?m_id=<%=m_id%>&page=<%=page%>&search_txt=<%=search_txt%>&search_key=<%=search_key%>&s_dealer_code=<%=s_dealer_code%>"><%=m_name%></a></td>
			<td class="con4"><%=m_id%></td>
			<td class="con4"><%=m_passwd%></td>
			<td class="con4"><%=dealer_name%></td>
			<td class="con4"><%=duty_name%>&nbsp;</td>
			<td class="con4"><%=position_name%>&nbsp;</td>
			<td class="con4"><%=m_tel2%>&nbsp;</td>
			<td class="con4"> <%=status_text%></td>     
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
			link_url = "a_emp_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&s_dealer_code="&s_dealer_code&"&list_cnt="&list_cnt&"&"
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