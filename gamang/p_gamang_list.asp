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

  if ad_g_p_gamang="N" then
 	Alert_URL session_m_name &" 님은 가망고객관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
	
  search_key			= WORD_CHANGE(request("search_key"),20)
  search_txt			= WORD_CHANGE(request("search_txt"),20)
  consult_status		= WORD_CHANGE(Request("consult_status"),20)
  %>  
<!DOCTYPE html>  
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
<tr bgcolor="#FFFFFF"  align='center'  height='400'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub02_t01.gif"></div>

		<form name='frm_gamang' method='post' action='p_gamang_list.asp'>

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height=30> 
			<td align="left"  class="table_header2" style="padding-left:5"  style="border-style:none;">
				<select name="search_key">
				<option value="c_m_name" <% if search_key="c_m_name" then %> selected <% end if %>> 고객명 </option>
				<option value="m_name" <% if search_key="m_name" then %> selected <% end if %>> 접수자 </option>	
				<option value="c_m_address" <% if search_key="c_m_address" then %> selected <% end if %>>주소</option>
				<option value="c_m_htel1" <% if search_key="c_m_htel1" then %> selected <% end if %>> 연락처 </option>
				<option value="c_m_mtel1" <% if search_key="c_m_mtel1" then %> selected <% end if %>> 휴대폰 </option>
				</select><input type="text" name="search_txt" class="txtbox" size='20' align='absmiddle' value="<%=search_txt%>"><a href="#" onClick="Search('frm_gamang');"><img src="/images/button/btn_search01.gif" align='absmiddle' border=0></a>
			</td>					
			<td align="right" valign='middle'  style="border-style:none;">		
				<% if ad_g_p_gamang="W" OR ad_g_p_gamang="E" OR ad_g_p_gamang="A" then %>
				<a href="p_gamang_regist.asp"><img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a>
				<% else %>
				<a href='javascript:alert("<%=session_m_name%> 님은 쓰기권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a>
				<% end if %>
				
					
			</td>
		</tr>
		</table>

		</form>	

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width="20">NO</td>
			<td class="head" width="60">접수자</td>
			<td class="head" width="100">고객명</td>
			<td class="head" width="100">연락처</td>
			<td class="head" width="100">휴대폰</td>
			<td class="head" width="150">주소</td>
			<td class="head">최종상담</td>
			<td class="head" width="120">접수일</td>
		</tr>
  <% 
  If search_txt<>"" Then
	If search_key="m_name" Then
		strSql_txt1 = " and A.c_m_m_id in (select m_id from emp_list where m_name like '%"&search_txt&"%') "
	else
		strSql_txt1 = " and A."&search_key&" like '%"&search_txt&"%'"
	End If
  End If
  
  strSql =  " select A.c_m_gamang_idx, A.c_m_name, A.c_m_course_idx, A.c_m_m_id, A.c_m_address, A.c_m_consult_type, "
  strSql = strSql & " A.c_m_consult_bigo, A.c_m_htel1, A.c_m_mtel1, A.c_m_writeday, B.m_name "
  strSql = strSql & " 		from customer_gamang A left outer  "
  strSql = strSql & " 			join emp_list B on A.c_m_m_id=B.m_id "
  strSql = strSql &  "				WHERE A.c_m_m_id='"&session_m_id&"'"
  strSql = strSql & strSql_txt1 
  strSql = strSql & "					order by A.c_m_gamang_idx desc "


  'response.write "<br>"&strSql&"<br>"
  objRs.Open strSql, objCnn, 3 
  objRs.PageSize = 15
  Recordcount=objRs.Recordcount	

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
				<tr height=25>             
					<td class='con5' colspan='8'> 고객정보가 존재하지 않습니다.</td>
				</tr>
  <%	
  else
    
	totalpage = objRs.pagecount
	objRs.absolutepage = page
	recordcount	= objRs.recordcount 
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
  		c_m_gamang_idx		= objRs("c_m_gamang_idx")
  		c_m_m_id			= objRs("c_m_m_id")
		c_m_name			= Left(objRs("c_m_name"),6)
		c_m_address			= Left(objRs("c_m_address"),15)
		c_m_htel1			= objRs("c_m_htel1")
		c_m_mtel1			= objRs("c_m_mtel1")
		c_m_writeday		= objRs("c_m_writeday")
		m_name				= objRs("m_name")
		c_m_consult_type	= objRs("c_m_consult_type")
		c_m_consult_bigo	= objRs("c_m_consult_bigo")

		c_m_consult_type	= fnc_consult_list(c_m_consult_type)

%>			  
		<tr height=28>
			<td class='con5'><%=i%></td>
			<td class='con4'>
				<a href="p_gamang_regist.asp?c_m_gamang_idx=<%=c_m_gamang_idx%>&search_key=<%=search_key%>&search_txt=<%=search_txt%>&page=<%=page%>"><%=m_name%></a></td>
			<td class='con4'><%=c_m_name%></td>
			<td class='con4'><%=c_m_htel1%>&nbsp;</td>
			<td class='con4'><%=c_m_mtel1%>&nbsp;</td>
			<td class='con2'><%=c_m_address%>&nbsp;</td>
			<td class="con2"><span title="<%=c_m_consult_bigo%>"><%=c_m_consult_type%>&nbsp; <%=Left(c_m_consult_bigo,20)%></span></td>
			<td class='con4'><%=left(c_m_writeday,10)%></td>
		</tr>
          
<% 
    	objrs.MoveNext
    	i=i+1 
    loop
	End If 
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
			link_url = "p_gamang_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> 건 ] </span></b>
		</div>
		<!------------------ 내용 종료  ------------------>        	
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