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
	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  article_step1			= WORD_CHANGE(request("article_step1"),20)
  article_step2			= WORD_CHANGE(request("article_step2"),20)
    
  if article_step1<>"" Then
	If article_step2<>"" then
		strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
		strSql = strSql & "	from code_article "
		strsql = strsql & "		where article_step1="& article_step1&" "
		strSql = strsql & "			and article_step2="& article_step2
		Set objRs=objCnn.Execute(strSql)
		
		If objRs.eof Or objRs.bof Then
			article_step1		= ""
			article_step2		= ""
		else
			article_idx			= objRs("article_idx")
			article_name		= objRs("article_name")
			article_view		= objRs("article_view")
		End if
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
		

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">						
		<tr height=30>
			<Td colspan='2' class='con3'  style='border-style:none'> 
				<A href="article_order.asp"><img src="/images/button/btn_order1.gif" align="absmiddle"></a> 
				<a href="article_order1.asp"><img src="/images/button/btn_order2.gif" align="absmiddle"></a> 
				<a href="article_order2.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
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
  strSql = " select * from code_article where article_step2=0 "
  strSql = strSql & " order by article_order asc"
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
  		article_idx			= objRs("article_idx")
  		article_name		= objRs("article_name")
		article_step1		= objRs("article_step1")
		article_step2		= objRs("article_step2")
		article_view		= objRs("article_view")
		article_order		= objRs("article_order")


		If article_view="Y" Then 
			article_view="<span class='red'>보임</span>"
		Else
			article_view="<span class='blue'>숨김</span>"
		End If
%>
		<tr height=30>
			<td class="con5"><%=article_idx%></td>
			<td class="con2">
				&nbsp;<span style="color=#1604fe;">
				(회사)</span> <a href="article_list.asp?article_step1=<%=article_step1%>&article_step2=<%=article_step2%>"><span style="color=#1604fe;"><%=article_name%></span></a> 
			</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">
				<a href="article_order_ok.asp?article_idx=<%=article_idx%>&article_order=<%=article_order%>&chk=U&page=<%=page%>"><img src='/images/button/btn_up.gif' border=0 align='absmiddle'></a>
				&nbsp;|&nbsp;
				<a href="article_order_ok.asp?article_idx=<%=article_idx%>&article_order=<%=article_order%>&chk=D&page=<%=page%>"><img src='/images/button/btn_down.gif' border=0 align='absmiddle'></a>
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