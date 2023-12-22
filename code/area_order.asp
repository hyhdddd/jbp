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

  if ad_c_code="N" then
	Alert_url session_m_name &" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if

  article_idx			= WORD_CHANGE(request("article_idx"),20)
    
  if article_idx="" Then
	strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
	strSql = strSql & "	from code_article where article_step2=0 order by article_order asc "
	Set objRs=objCnn.Execute(strSql)
		
	If objRs.eof Or objRs.bof Then
		article_step1		= ""
		article_step2		= ""
	else
		article_idx			= CStr(objRs("article_idx"))
	End if
  end if	
  
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function article_del(article_idx)
	{
		ans=confirm("상품을 지우시기 위해서는 옵션을 모두 삭제한 후 지워 주시기 바랍니다. \n\n 상품을 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="article_del_ok.asp?article_idx="+article_idx
		}
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
		
		<form name="frm" method="post" action="area_order.asp">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">								
		<tr height=30 >
			<td class='con1' style='border-style:none'>
				&nbsp;
				<select name="article_idx" onchange="submit();">
				<% 
				strSql = "Select * from code_article where article_step2=0 order by  article_order asc"
				Set objRs=objCnn.Execute(strSql)

				Do Until objRs.eof
					article_idx1		= objRs("article_idx")
					article_name1		= objRs("article_name")
				%>
				<option value="<%=article_idx1%>" <% If CStr(article_idx1)=article_idx Then %> selected <% End If %>>
				<%=article_name1%> </option>
				<%
					objRs.movenext
				loop
				%>
				</select>
			</td>
		</tr>
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">

		<tr height=30>             
			<td class="head" width=50>번  호</td> 
			<td class="head" width=500>회사명</td> 
			<td class="head" width=100>표시</td> 
			<td class="head" width=100>순서</td> 
		</tr>
  <%
  strSql = " select * from code_area where "
  strSql = strSql & " article_idx="&article_idx&" order by area_order Asc"
  Set objRs=objCnn.Execute(strSql)
	
  if objRs.BOF or objRs.EOF Then
  %>
				<tr height=25>
					<td colspan='4' align='center' class="table_list3">
						코드가 존재하지 않습니다.
					</td>
				</tr>
  <%
  else  		 
  	i = 1
  	Do until objRs.EOF   	
  		area_idx			= objRs("area_idx")
  		area_name			= objRs("area_name")
		area_view			= objRs("area_view")
		area_order			= objRs("area_order")


		If area_view="Y" Then 
			area_view="<span class='red'>보임</span>"
		Else
			area_view="<span class='blue'>숨김</span>"
		End If
%>
		<tr height=30>
			<td class="con5"><%=area_idx%></td>
			<td class="con2">&nbsp;<span style="color=#1604fe;"><%=area_name%></span></td>
			<td class="con4"><%=area_view %></td>
			<td class="con4">
				<a href="area_order_ok.asp?article_idx=<%=article_idx%>&area_idx=<%=area_idx%>&area_order=<%=area_order%>&chk=U&page=<%=page%>"><img src='/images/button/btn_up.gif' border=0 align='absmiddle'></a>
				&nbsp;|&nbsp;
				<a href="area_order_ok.asp?article_idx=<%=article_idx%>&area_idx=<%=area_idx%>&area_order=<%=area_order%>&chk=D&page=<%=page%>"><img src='/images/button/btn_down.gif' border=0 align='absmiddle'></a>
			</td>
		</tr>
<%

   	objRs.MoveNext   		
   	loop
   end if					
   objRs.close
  %>   
		</table>
		</form>
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