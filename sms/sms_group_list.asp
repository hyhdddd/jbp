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

  group_idx		= WORD_CHANGE(request("group_idx"),20)
  
  if group_idx<>"" then
  	strSql = " select group_idx, group_name from sms_group "
	strSql = strSql & " where group_idx='"&group_idx&"'"
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		group_idx	= ""
	else
	group_idx			= objRs("group_idx")
  	group_name			= objRs("group_name")
	End If
	
	objRs.close
  end if	
  
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function code_group_del(code)
	{
		ans=confirm("코드 지우시기 위해서는 선택된 그룹에 사원이 없어야 합니다. \n\n 코드를 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="sms_group_del_ok.asp?group_idx="+code
		}
	}

	//  그룹코드 등록    
	function send_sms_group() 
	{
		frm=document.all.frm_group;
		if(frm.group_name.value.length==0)
		{
			alert("그룹명을 입력해 주세요!");
			frm.group_name.focus();
			return false;
		}	
		frm.submit();
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellpadding="0" cellspacing="0">
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		
		<!------------------ 내용 시작  ------------------>    								
		
		<div class="sub_title"><img src="/images/common/sub12_t04_3.gif" width='680'></div>

		<form name="frm_group" Method="POST" action="sms_group_list_regist_ok.asp">
		<input type="hidden" name="group_idx" value="<%=group_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>&nbsp;&nbsp;
			  	<a href="/sms/sms_group_regist.asp"> SMS 그룹전송 </a>&nbsp;&nbsp;|&nbsp;&nbsp;
			  	<a href="/sms/sms_group_list.asp"> SMS 그룹관리 </a>&nbsp;&nbsp;|&nbsp;&nbsp;

			</td>
		</tr>
		<tr height=30> 
			<th width='100'>그룹 코드명</th>
			<td>
				<input type="Text" class="txtbox" name="group_name" size="30"  value="<%=group_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);"></td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_b_a_custom="W" or ad_b_a_custom="E" or ad_b_a_custom="A" then %>
					<a href="sms_group_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_b_a_custom="W" or ad_b_a_custom="E" or ad_b_a_custom="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_sms_group();">
				<% else %>
					<a href ='javascript:alert("<%=session_name%> 님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>   
				
				<% If group_idx<>"" Then %>
					<% if ad_b_a_custom="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_group_del('<%=group_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> 님은 코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
			</td>	
		</tr>
		</table>				
	
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>번  호</td>
			<td class="head" width=500>그룹 코드 명</td>
			<td class="head" width=150>사원 편집</td>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select * from sms_group order by group_name asc"

  strSql = " select A.group_idx , A.group_name , A.group_writeday , isnull(B.group_cnt,0) as group_cnt  from sms_group A  "
  strSql = strsql & " Left outer join "
  strSql = strSql & " (SELECT group_idx, count(group_idx) as group_cnt FROM sms_group_emp  GROUP BY group_idx ) B "
  strSql = strSql & "		ON A.Group_idx=B.group_idx "
  strSql = strSql & "     	ORDER BY A.group_name ASC "


  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 9
  
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td colspan='4' align='center' class="table_list3">
				코드가 존재하지 않습니다.
			</td>
		</tr>
  <%
  else      		 
    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount

  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
  		group_idx			= objRs("group_idx")
  		group_name			= objRs("group_name")
		group_writeday		= objRs("group_writeday")
		group_cnt			= objRs("group_cnt")
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con2">
				<a href="/sms/sms_group_list.asp?group_idx=<%=group_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=group_name%> (&nbsp;<%=group_cnt%>명)</a></td>
			<td class="con4">
				<span onclick="NewWindow('/sms/sms_group_emp_add.asp?group_idx=<%=group_idx%>','sms_emp_add','580','600','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_add.gif" align="absmiddle">&nbsp;추가</a></span> | 
				<span onclick="NewWindow('/sms/sms_group_emp_sub.asp?group_idx=<%=group_idx%>','sms_emp_add','580','600','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_sub.gif" align="absmiddle">&nbsp;편집</span></td>
		</tr>
  <% 
		objRs.MoveNext
   		i=i+1 
    loop
  %>							
  <%
   objRs.close
   end if					
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
			link_url = "sms_group_list.asp?"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>
		</form>
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
</table>
