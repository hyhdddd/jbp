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

  article_step1		= WORD_CHANGE(request("article_step1"),20)
  article_step2		= WORD_CHANGE(request("article_step2"),20)
  service_idx		= WORD_CHANGE(Request("service_idx"),20)
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  
  if article_idx<>"" then
  	strSql = " select article_idx,article_name, article_step1 from code_article where article_idx='"&article_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	article_name2		= objRs("article_name")
	article_step1		= objRs("article_step1")

	strSql = " select article_name from code_article where article_idx="&article_step1
	Set objRs=objCnn.Execute(strSql)

	article_name1		= objRs("article_name")
  end if	
  

  If service_idx<>"" Then
	strSql = " select service_idx, service_name,service_view from code_service where service_idx='"&service_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	service_name		= objRs("service_name")  
	service_view		= objRs("service_view")
  End if
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script language="Javascript">
<!--
	function code_service_del(service_idx)
	{
		ans=confirm(" 코드를 삭제하시겠습니까? \n\n 삭제하는 코드가 고객정보에 사용되지 않아야 삭제가 가능합니다.");
		if(ans==true)
		{
			location.href="service_del_ok.asp?service_idx="+service_idx
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

		<form name="frm_service" Method="POST" action="service_regist_ok.asp">
		<input type="hidden" name="article_idx" value="<%=article_idx%>">
		<input type="hidden" name="article_step1" value="<%=article_step1%>">
		<input type="hidden" name="article_step2" value="<%=article_step2%>">
		<input type="hidden" name="service_idx" value="<%=service_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">						
		<% If article_idx<>"" Then %>
		<tr height=30> 
			<th width="130">대분류</th>
			<td width="870"><%=article_name1%></td>	
		</tr>
		<tr height=30> 
			<th>중분류</th>
			<td><%=article_name2%>	
		</tr>
		<tr height=30> 
			<th>부가서비스 이름</th>
			<td>
				<input type="text" name="service_name" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=service_name%>" size=40>	
				&nbsp;&nbsp;
				<input type="radio" name="service_view" value="Y" <% If service_view="Y" Or service_view="" Then %> checked <% End If %>>보임&nbsp;&nbsp;&nbsp;
				<input type="radio" name="service_view" value="N" <% If service_view="N" Then %> checked <% End If %>>숨김&nbsp;&nbsp;&nbsp;
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<a href="service_list.asp?article_idx=<%=article_idx%>"><img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a>
				<img src="/images/button/btn_save.gif" border="0" onclick="send_service();" align='absmiddle'>

				<% If service_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_service_del('<%=service_idx%>');" align='absmiddle'>
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%>님은 코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></a> 
					<% end if %>  
				<% End If %>	

			</td>	
		</tr>
		<% End If %>
		<tr height='30'>
			<td colspan='2' class='con3' style='border-style:none'> 
				<a href="service_order.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>				
		
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>번  호</td> 
			<td class="head" width=500>상 품 명</td> 
			<td class="head" width=100>보임/숨김</td> 
			<td class="head" width=150>부가서비스 등록</td> 
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


		If article_view="Y" Then 
			article_view="<span class='red'>보임</span>"
		Else
			article_view="<span class='blue'>숨김</span>"
		End If
	%>
		<tr height=30>
			<td class="con5"><%=article_idx%></td>
			<td class="con2">
				&nbsp;<span style="color=#1604fe;">(회사)<%=article_name%></span>
			</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">&nbsp;</td>
		</tr>
<%
		strSql = " select * from  code_article where article_step2>0 and article_step1="&article_step1&" order by article_order asc"
		Set objRs1=objCnn.Execute(strSql)

		Do Until objRs1.eof

  		article_idx			= objRs1("article_idx")
  		article_name		= objRs1("article_name")
		article_step1		= objRs1("article_step1")
		article_step2		= objRs1("article_step2")
		article_view		= objRs1("article_view")

		If article_view="Y" Then 
			article_view="<span class='red'>보임</span>"
		Else
			article_view="<span class='blue'>숨김</span>"
		End If

%>	
		<tr height=30>
			<td class="con5"><%=article_idx%></td>
			<td class="con2">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span style="color=#fd0315;"> (상품) <%=article_name%></span>
			</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">
				<a href="service_list.asp?article_step1=<%=article_step1%>&article_step2=<%=article_step2%>&article_idx=<%=article_idx%>"><img src="/images/button/btn_icon03.gif" align="absmiddle">&nbsp;&nbsp;부가서비스 등록</a>
			</td>
		</tr>

  <% 
		i=i+1 
		strSql = " select * from code_service where "
		strSql = strsql & " article_idx="&article_idx&" order by service_name asc "
		Set objRs2=objCnn.Execute(strSql)

		Do Until objRs2.Eof
			service_idx			= objRs2("service_idx")
			service_name		= objRs2("service_name")
			service_view		= objRs2("service_view")

			If service_view="Y" Then 
				service_view="<span class='red'>보임</span>"
			Else
				service_view="<span class='blue'>숨김</span>"
			End if
  %>
				<tr height=30>
					<td class="con5"><%=i%></td>
					<td class="con2">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						(부가서비스) <a href="service_list.asp?article_idx=<%=article_idx%>&service_idx=<%=service_idx%>">
						<%=service_name%></a>
					</td>
					<td class="con4"><%=service_view%></td>
					<td class="con4">&nbsp;</td>
				</tr>

		<%
			objRs2.movenext
			i=i+1
		Loop

		objRs1.movenext
		Loop
   	objRs.MoveNext   		
   	loop
   end if		
  %>   
		</table>
		</form>
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