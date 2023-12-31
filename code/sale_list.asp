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

  article_step1		= WORD_CHANGE(request("article_step1"),20)
  article_step2		= WORD_CHANGE(request("article_step2"),20)
  sale_idx			= WORD_CHANGE(Request("sale_idx"),20)	
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
  

  If sale_idx<>"" Then
	strSql = " select sale_idx, sale_name,sale_view from code_sale where sale_idx='"&sale_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	sale_name		= objRs("sale_name")  
	sale_view		= objRs("sale_view")
  End if
  %>


<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script language="Javascript">
<!--
	function code_sale_del(sale_idx)
	{
		ans=confirm(" 할인탭 코드를 삭제하시겠습니까? \n\n 삭제하는 코드가 고객정보에 사용되지 않아야 삭제가 가능합니다.");
		if(ans==true)
		{
			location.href="sale_del_ok.asp?sale_idx="+sale_idx
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

		<form name="frm_sale" Method="POST" action="sale_regist_ok.asp">
		<input type="hidden" name="article_idx" value="<%=article_idx%>">
		<input type="hidden" name="article_step1" value="<%=article_step1%>">
		<input type="hidden" name="article_step2" value="<%=article_step2%>">
		<input type="hidden" name="sale_idx" value="<%=sale_idx%>">

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
			<th>할인탭 이름</th>
			<td>
				<input type="text" name="sale_name" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=sale_name%>" size=40>	
				&nbsp;&nbsp;
				<input type="radio" name="sale_view" value="Y" <% If sale_view="Y" Or sale_view="" Then %> checked <% End If %>>보임&nbsp;&nbsp;&nbsp;
				<input type="radio" name="sale_view" value="N" <% If sale_view="N" Then %> checked <% End If %>>숨김&nbsp;&nbsp;&nbsp;
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<a href="sale_list.asp?article_idx=<%=article_idx%>"><img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a>
				<img src="/images/button/btn_save.gif" border="0" onclick="send_sale();" align='absmiddle'>

				<% If sale_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_sale_del('<%=sale_idx%>');" align='absmiddle'>
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%>님은 코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></a> 
					<% end if %>  
				<% End If %>	

			</td>	
		</tr>
		<% End If %>
		<tr height='30'>
			<td colspan='2' class='con3' style='border-style:none'> 
				<a href="sale_order.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>				
		
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>번  호</td> 
			<td class="head" width=500>상 품 명</td> 
			<td class="head" width=100>보임/숨김</td> 
			<td class="head" width=150>할인탭등록</td> 
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
				<a href="sale_list.asp?article_step1=<%=article_step1%>&article_step2=<%=article_step2%>&article_idx=<%=article_idx%>"><img src="/images/button/btn_icon03.gif" align="absmiddle">&nbsp;&nbsp;할인탭 등록</a></td>
		</tr>
  <% 
		i=i+1 
		strSql = " select * from code_sale where "
		strSql = strsql & " article_idx="&article_idx&" order by sale_order asc "
		Set objRs2=objCnn.Execute(strSql)

		Do Until objRs2.Eof
			sale_idx		= objRs2("sale_idx")
			sale_name		= objRs2("sale_name")
			sale_view		= objRs2("sale_view")

			If sale_view="Y" Then 
				sale_view="<span class='red'>보임</span>"
			Else
				sale_view="<span class='blue'>숨김</span>"
			End if
  %>
				<tr height=30>
					<td class="con5"><%=i%></td>
					<td class="con2">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						(할인탭) <a href="sale_list.asp?article_idx=<%=article_idx%>&sale_idx=<%=sale_idx%>">
						<%=sale_name%></a>
					</td>
					<td class="con4"><%=sale_view%></td>
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