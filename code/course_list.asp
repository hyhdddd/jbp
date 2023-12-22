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
  if ad_c_code="N" then
	Alert_back session_m_name &" 님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if
  
  course_code		= WORD_CHANGE(request("course_code"),20)
  
  if course_code<>"" then
  	strSql = " select course_idx,course_code, course_name,course_writeday from code_course "
	strSql = strSql & " where course_code='"&course_code&"'"
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		course_code	= ""
	else
	course_idx			= objRs("course_idx")
  	course_code			= objRs("course_code")
  	course_name			= objRs("course_name")
  	course_writeday		= objRs("course_writeday")
	End If
	
	objRs.close
  end if	
  
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function code_course_del(code)
	{
		ans=confirm("코드 지우시기 위해서는 고객정보, 가망고객정보에 현재 접수경로코드가 없어야 합니다. \n\n 접수경로 코드를 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="course_del_ok.asp?course_code="+code
		}
	}
	   
	// 코드관리 - 접수경로 코드 등록    
	function send_course1() 
	{
		frm=document.all.frm_course;

		if(frm.course_name.value.length==0)
		{
			alert("접수경로명을 입력해 주세요!");
			frm.course_name.focus();
			return false;
		}	
		frm.submit();
	}
-->
</script>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
	</td>
</tr>
<tr bgcolor="#FFFFFF"  height='400'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>    				

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">코드관리 </li>
		</ul>
		</div>

		<!--#include virtual="/include/asp/code_menu_list.asp"-->

		<form name="frm_course" Method="POST" action="course_regist_ok.asp">
		<input type="hidden" name="course_idx" value="<%=course_idx%>">
		<input type="hidden" name="course_code" value="<%=course_code%>">	
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
			<td colspan='2' class="description"><br> 
				* 접수경로코드를 등록/수정 할 수 있는 메뉴 입니다.   <br>
				* 접수경로정보코드는 고객관리시 고객의 접수경로정보를 확인할수 있는 목록에 나타납니다.
			</td>
		</tr>
		<tr height=30> 
			<th width='130'>접수경로 명</th>
			<td width='870'>
				<input type="Text" class="txtbox" name="course_name" size="30"  value="<%=course_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);"></td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="course_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
				<% else %>
					<a href ='javascript:alert("<%=session_name%> 님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_course1();">
				<% else %>
					<a href ='javascript:alert("<%=session_name%>님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>       	
	
				<% If course_code<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_course_del('<%=course_code%>');">
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
			<td class="head" width=550>접수경로 명</td>
			<td class="head" width=100>출력순서</td>
			<td class="head" width=100>개설일</td>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select * from code_course order by course_order asc"
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
  
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
  		course_idx			= objRs("course_idx")
  		course_code			= objRs("course_code")
  		course_name			= objRs("course_name")
  		course_order		= objRs("course_order")
  		course_writeday		= Left(objRs("course_writeday"),10)
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con2">
				<a href="course_list.asp?course_code=<%=course_code%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=course_name%></a></td>
			<td class="con4">
				<a href="course_order_ok.asp?course_idx=<%=course_idx%>&course_order=<%=course_order%>&chk=U&page=<%=page%>"><img src='/images/button/btn_up.gif' border=0 align='absmiddle'></a>
				&nbsp;|&nbsp;
				<a href="course_order_ok.asp?course_idx=<%=course_idx%>&course_order=<%=course_order%>&chk=D&page=<%=page%>"><img src='/images/button/btn_down.gif' border=0 align='absmiddle'></a>
			</td>
			<td class="con4"><%=course_writeday%></td>
		</tr>
  <% 
		objRs.MoveNext
   		i=i+1 
    loop
  %>							
  <%
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
			link_url = "course_list.asp?"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>