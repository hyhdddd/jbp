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
  
  position_code		= WORD_CHANGE(request("position_code"),20)
  
  if position_code<>"" then
  	strSql = " select position_idx, position_code, position_name,position_writeday from code_position "
	strSql = strSql & " where position_code='"&position_code&"'"
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		position_code	= ""
	else
	position_idx			= objRs("position_idx")
  	position_code			= objRs("position_code")
  	position_name			= objRs("position_name")
  	position_writeday		= objRs("position_writeday")
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
	function code_position_del(code)
	{
		ans=confirm("코드 지우시기 위해서는 사원정보에 선택된 직책코드가 없어야 합니다. \n\n 코드를 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="position_del_ok.asp?position_code="+code
		}
	}


	// 코드관리 - 직책코드 등록    
	function send_position1() 
	{
		frm=document.all.frm_position;

		if(frm.position_name.value=="")
		{
			alert("직책명을 입력해 주세요!");
			frm.position_name.focus();
			return;
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

		<form name="frm_position" Method="POST" action="position_regist_ok.asp">
		<input type="hidden" name="position_idx" value="<%=position_idx%>">
		<input type="hidden" name="position_code" value="<%=position_code%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="board_table3">
		<Tr>
			<td colspan='2' class="description"><br> 
				* 직책코드를 등록/수정 할 수 있는 메뉴 입니다. <br>
				* 직책코드는 인사관리 - 사원 등록/수정시에 직책 목록에 나타납니다.
			</td>
		</tr>
		<tr height=30> 
			<th width='130'>직책 명</th>
			<td width='870'>
				<input type="Text" class="txtbox" name="position_name" size="30"  value="<%=position_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);"></td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="position_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>						
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_position1();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>      

				
				<% If position_code<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_position_del('<%=position_code%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%>님은 코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
				</td>	
		</tr>
		</table>				
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=100>번  호</td>
			<td class="head" width=550>직 책 명</td>
			<td class="head" width=100>개설일</td>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select * from code_position order by position_code desc"
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
  		position_idx		= objRs("position_idx")
  		position_code		= objRs("position_code")
  		position_name		= objRs("position_name")
  		position_writeday	= Left(objRs("position_writeday"),10)
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con2">&nbsp;&nbsp;
				<a href="position_list.asp?position_code=<%=position_code%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=position_name%></a></td>
			<td class="con4"><%=position_writeday%></td>
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
			link_url = "position_list.asp?"
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
</div>