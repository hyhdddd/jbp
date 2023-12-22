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
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  group_idx			= WORD_CHANGE(Request("group_idx"),20)
  Search_key		= WORD_CHANGE(Request("search_key"),20)
  Search_txt		= WORD_CHANGE(Request("search_txt"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
  
  If group_idx="" Then
	Alert "잘못된 접근입니다."
	Response.end
  End if
  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/mail_emp_info_all.asp"></SCRIPT>
<script language="javascript">
<!--
function sel_ok(m_name)
{
	opener.document.all.frm_sms.send_name.value=m_name;
	self.close();
}
function Search_emp(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.search_txt.value=="")
	{
		alert("내용을 입력해주세요!");
		frm.search_txt.focus();
		return;
	}

	frm.action="sms_group_emp_add.asp";
	frm.submit();
}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<table width="100%" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		<table width="100%" border=0 cellspacing="0" cellpadding="0">
		<tr> 
            
            <td width=100% valign="top" align='center'>
				<!------------------ 내용 시작  ------------------>
				<form name="frm_sms"  method="post" action="sms_group_emp_add.asp">
				<input type="hidden" name="group_idx" value="<%=group_idx%>">

				<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
				<tr height=30> 
					<td style="padding-left:5px; text-align:left;" colspan='7'>
						<select name="search_key" valign='absmiddle' class="txtbox">
							<option value="m_name"> 사원명 </option>				
							<option value="m_id"> 아이디 </option>
						</select>
						<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><img src="/images/button/btn_search01.gif" align='absmiddle' border=0 onClick="Search_emp('frm_sms');">
						&nbsp;&nbsp;
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
				</tr>
				<tr height=30>             
					<td class="head" width=30>No</td>
					<td class="head" width=80>사원명</td>
					<td class="head" width=110>소속</td>
					<td class="head" width=70>직급</td>
					<td class="head" width=100>정산그룹</td>
					<td class="head" width=50>퇴사</td>
					<td class="head" width=50>그룹등록</td>
				</tr>
				
<% 
  strSql = " select A.m_idx, A.m_name, A.m_id, A.m_jumin1, A.m_jumin2, A.m_tel1,A.m_tel2, E.group_name, "
  strSql = strSql & " A.m_passwd, A.m_dealer_code, A.m_status, B.duty_name, C.position_name, D.bank_name, G.dealer_name "
  strSql = strSql & " from emp_list A left outer "
  strSql = stRSql & "		 join code_duty B on A.m_duty=B.duty_code "
  strSql = strSql & "		left Join code_position C ON A.m_position=C.position_code "
  strSql = strSql & "		left Join code_bank D ON A.m_bank_cd=D.board_idx "
  strSql = strSql & "		left join dealer_info G On G.dealer_code=A.m_dealer_code	"
 strSql = strSql & "		left join code_group E On E.group_code=G.dealer_group_code	"
  strSql = strSql & "			where 1=1 "

  If s_dealer_code<>"" then
  strSql = strSql & "				and  A.m_dealer_code='"& s_dealer_code &"' "
  End If

  If search_key<>"" then
	strSql = strsql & "				and A."&search_key&" like '%"&search_txt&"%'"
  End If
  
  strSql = strSql & "					order by A.m_name Asc"
 
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
				<tr height=30>
					<td align="center" class="con5" colspan='7'> 글이 존재하지 않습니다.</td>	
				</tr>		
  <%
  Else 
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
	
		m_idx			= objRs("m_idx")			'사원 일련번호
		m_name			= objRs("m_name")			'사원 이름
		m_id			= objRs("m_id")				'사원 아이디
		m_passwd		= objRs("m_passwd")			'사원 비밀번호
		bank_name		= objRs("bank_name")		'은행 명
		duty_name		= objRs("duty_name")		'회사 부서
		position_name	= objRs("position_name")	'회사 직책
		dealer_name		= objRs("dealer_name")		'거래처 명
		m_dealer_code	= objRs("m_dealer_code")
		m_tel2			= objRs("m_tel2")			'휴대폰
		m_status		= objRs("m_status")			'종사자/퇴사자
		group_name		= objRs("group_name")
		
		if m_status="X" then
		   status_text="<span class='red'>퇴직자</span>"
		else
		   status_text="종사자"
		end if		
  %>			  
				<tr height=30>
					<td class="con5"><%=i%>	
					<td class="con4"><%=m_name%>&nbsp;</td>	
					<td class="con4"><%=dealer_name%>&nbsp;</td>
					<td class="con4"><%=position_name%>&nbsp;</td>
					<td class="con4"><%=group_name%></td>
					<td class="con4"><%=status_text%></td>
					<td class="con4"><a href="/sms/sms_group_emp_add_ok.asp?group_idx=<%=group_idx%>&emp_idx=<%=m_idx%>&page=<%=page%>&s_dealer_code=<%=s_dealer_code%>"><img src="/images/button/btn_add1.gif" align="absmiddle">&nbsp;등록</a></td>
				</tr>	
          
<% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
    objRs.close
%>		  

				</table>
				</form>

				<div class="pagelist">
					<%
					' Request mychoice						
					' Request totalpage
					' Request page
					' Request nowblock
					' Request link_url
					' Request link_tail :마지막 Request 값
					mychoice=10
					link_url = "sms_group_emp_add.asp?group_idx="&group_idx&"&s_dealer_code="&s_dealer_code&"&search_key="&search_key&"&search_txt="&search_txt&"&"
					%>
					<!--#include virtual="/include/asp/list_paging.asp"-->
				</div>
				<!------------------ 내용 종료  ------------------>

				
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</body>