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

  s_article_idx1		= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2		= WORD_CHANGE(Request("s_article_idx2"),20)
 
	 
  if s_article_idx1="" Then
	strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
	strSql = strSql & "	from code_article where article_step2=0 order by article_order asc "
	Set objRs=objCnn.Execute(strSql)
		
	If objRs.eof Or objRs.bof Then
		s_article_idx1		= ""
		s_article_idx1		= ""
	else
		s_article_idx1			= CStr(objRs("article_idx"))
	End If

	strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
	strSql = strSql & "	from code_article where article_step1="&s_article_idx1&" and article_step2>0 order by article_order asc "
	Set objRs=objCnn.Execute(strSql)
		
	If objRs.eof Or objRs.bof Then
		s_article_idx2		= ""
		s_article_idx2		= ""
	else
		s_article_idx2			= CStr(objRs("article_idx"))
	End If

  end if	
  
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/custom_goods.asp"></SCRIPT>

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
		
		
		<form name="frm_order" method="post" action="article_order2.asp">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">								
		<tr height=30 >
			<td class='con1' style='border-style:none'>
				&nbsp;
				<select name="s_article_idx1" onchange="s_article_change(this,'frm_order',this.selectedIndex);">
				<% 
				strSql = "Select * from code_article where article_step2=0 order by  article_order asc"
				Set objRs=objCnn.Execute(strSql)

				Do Until objRs.eof
					article_idx1		= objRs("article_idx")
					article_name1		= objRs("article_name")
				%>
				<option value="<%=article_idx1%>" <% If CStr(article_idx1)=s_article_idx1 Then %> selected <% End If %>>
				<%=article_name1%> </option>
				<%
					objRs.movenext
				loop
				%>
				</select>
				<select name="s_article_idx2" style="width:100px;font-size:12px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="submit();">
					<% 
					If s_article_idx1<>"" then

					strSql = " select * from code_article where article_step1="&s_article_idx1&" and article_step2>0 "
					strSql = strSql & " order by article_order Asc"
					Set objRs=objCnn.Execute(strSql)

					if objRs.BOF or objRs.EOF then
					else							 
						i = 1
						Do until objRs.EOF   	
							article_idx		= objRs("article_idx")
							article_name	= objRs("article_name")
						%>	
							<option value="<%=article_idx%>" <% if CInt(s_article_idx2)=article_idx then %> selected <% end if %>><%=article_name%></option>
						<% 
							objrs.MoveNext
							i=i+1 
						Loop
						End If
					End if
				%>	
				</select>
			</td>
			<Td class='con3' style='border-style:none'> 
				<A href="article_order.asp"><img src="/images/button/btn_order1.gif" align="absmiddle"></a> 
				<a href="article_order1.asp"><img src="/images/button/btn_order2.gif" align="absmiddle"></a>
				<a href="article_order2.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>번  호</td> 
			<td class="head" width=500>옵션명</td> 
			<td class="head" width=100>표시</td> 
			<td class="head" width=100>순서</td> 
		</tr>
  <%
  strSql = " select * from code_article_option where article_idx="&s_article_idx2&" order by option_order Asc"
  Set objRs=objCnn.Execute(strSql)
	
  if objRs.BOF or objRs.EOF then
  %>
		<tr height=30>
			<td colspan='3' align='center' class="table_list3">
				코드가 존재하지 않습니다.
			</td>
		</tr>
  <%  		 
  else
	i = 1
	Do until objRs.EOF   	
  		option_idx		= objRs("option_idx")
	  	option_name		= objRs("option_name")
		option_view		= objRs("option_view")
		option_set		= objRs("option_set")
		article_idx		= objRs("article_idx")
		option_order	= objRs("option_order")

		If option_view="Y" Then 
			option_view="<span class='red'>보임</span>"
		Else
			option_view="<span class='blue'>숨김</span>"
		End If
		
		option_set_txt = fnc_option_set(option_set)
%>
		<tr height=30>
			<td class="con5"><%=option_idx%></td>
			<td class="con2">
				&nbsp;<span style="color=#1604fe;"> <%=option_name%></span>
			</td>
			<td class="con4">
				<%=option_view %>
			</td>
			<td class="con4">
				<a href="article_order2_ok.asp?s_article_idx1=<%=s_article_idx1%>&option_idx=<%=option_idx%>&article_idx=<%=article_idx%>&option_order=<%=option_order%>&chk=U&page=<%=page%>"><img src='/images/button/btn_up.gif' border=0 align='absmiddle'></a>
				&nbsp;|&nbsp;
				<a href="article_order2_ok.asp?s_article_idx1=<%=s_article_idx1%>&option_idx=<%=option_idx%>&article_idx=<%=article_idx%>&option_order=<%=option_order%>&chk=D&page=<%=page%>"><img src='/images/button/btn_down.gif' border=0 align='absmiddle'></a>
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