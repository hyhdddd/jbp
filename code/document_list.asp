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
	Alert_back session_m_name &" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if
  
  document_idx		= WORD_CHANGE(request("document_idx"),20)
  
  if document_idx<>"" then
  	strSql = " select A.document_idx, A.document_name, A.article_idx, A.document_view, "
	strSql = strSql & " A.document_writeday, B.article_name "
	strSql = strSql & " from code_document A "
	strSql = strSql & " left outer join code_article B ON A.article_idx=B.article_idx "
	strSql = strSql & " where  A.document_idx="&document_idx&" "
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		document_idx	= ""
	Else
	c_article_idx			= objRs("article_idx")
	document_idx				= objRs("document_idx")
  	document_name				= objRs("document_name")
  	document_view				= objRs("document_view")
  	document_writeday			= objRs("document_writeday")
	c_article_name			= objRs("article_name")
	End If
	
	objRs.close
  Else
	document_view="Y"
  end if	
  
  %>
<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function code_document_del(code)
	{
		ans=confirm("코드 지우시기 위해서는 고객정보에 해당하는 코드가 없어야 합니다. \n\n 코드를 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="document_del_ok.asp?document_idx="+code
		}
	}

	// 코드관리 -  코드 등록    
	function send_document() 
	{
		frm=document.all.frm_document;
		
		if(frm.article_idx.value=="0")
		{
			alert("회사를 선택해 주세요!");
			return;
		}

		if(frm.document_name.value.length==0)
		{
			alert("코드 명을 입력해 주세요!");
			frm.document_name.focus();
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

		<form id="frm_document" name="frm_document" Method="POST" action="document_regist_ok.asp">
		<input type="hidden" name="document_idx" value="<%=document_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_css">
		<% If document_idx<>"" Then %>
		<Tr>
			<th width="15%" class="head_Gray_TLB">회사선택</th>
			<td width="85%" class="list_TLBR_left"><%=c_article_name%>
				<input type="hidden" name="article_idx" value="<%=c_article_idx%>">
			</td>
		</tr>
		<% Else %>
		<tr>
			<th width="15%" class="head_Gray_TLB">회사선택</th>
			<td width="85%" class="list_TLBR_left">
				<select name="article_idx" style="width:90px;">
				<option value="0" <% if article_idx="0" then %> selected <% end if %>> 회사선택           
				<% 
				strSql = " select * from code_article where article_step2=0 "
				strSql = strSql & " and article_view='Y' order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
				<option value="<%=article_idx%>" <% if c_article_idx=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objRs.MoveNext
				Loop
				objRs.close
				%>	
			</select></td>
		</tr>
		<% End If %>
		<tr height=30> 
			<th class="head_Gray_LB">코드 명</th>
			<td class="list_LBR_left">
				<input type="Text" class="txtbox" name="document_name" size="30"  value="<%=document_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);">
				
				&nbsp;&nbsp;
				<input type="radio" name="document_view" value="Y" <% If document_view="Y"   Then %> checked <% End If %>>보임&nbsp;&nbsp;&nbsp;
				<input type="radio" name="document_view" value="N" <% If document_view="N" Or document_view="" Then %> checked <% End If %>>숨김&nbsp;&nbsp;&nbsp;	
				</td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="document_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_document();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>님은 개통정보 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>       								
	
				<% If document_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_document_del('<%=document_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%>님은 약정코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
				</td>	
		</tr>
		<tr height='30'>
			<td colspan='2' class='con3' style='border-style:none'> 
				<a href="document_order.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>	

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=25>             
			<td class="head" width=50>번  호</td>
			<td class="head" width=550>상품약정 명</td>
			<td class="head" width=100>보임/숨김</td>
			<td class="head" width=100>개설일</td>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 


  strsql = " select * from code_article where article_view='Y' "
  strSql = strSql & " and article_step2=0 order by article_order asc "
  'Response.write strSql
  Set objRs1=objCnn.Execute(strSql)

  If objRs1.eof Or objRs1.bof Then
  %>
		<tr height=30>
			<td colspan='4' align='center' class="con5">
				상품이 존재하지 않습니다.
			</td>
		</tr>
  <%
  Else

  Do Until objRs1.eof 
	  article_idx	= objRs1("article_idx")
	  article_name	= objRs1("article_name")
	  %>
		<tr height=30>
			<td class='con5'  style="background:#e7e7e7"> 회사명 </td>
			<td colspan='4' align='center' class="con2" style="background:#e7e7e7">&nbsp;<b><%=article_name%></b></td>
		</tr>
  <%
  strSql = " select * from code_document where article_idx="&article_idx&" "
  strSql = strSql & " order by document_order asc"
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)
  
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td colspan='4'>
				코드가 존재하지 않습니다.
			</td>
		</tr>
  <%
  else      		 

  	i = 1
  	Do until objRs.EOF 
  		document_idx			= objRs("document_idx")
  		document_name			= objRs("document_name")
  		document_view			= objRs("document_view")

		If document_view="Y" Then 
			document_view="<span class='red'>보임</span>"
		Else
			document_view="<span class='blue'>숨김</span>"
		End If

  		document_writeday		= Left(objRs("document_writeday"),10)
  %>	
		<tr height=30>
			<td class="con4"><%=i%></td>
			<td class="con2">&nbsp;&nbsp;<a href="document_list.asp?document_idx=<%=document_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=document_name%></a></td>
			<td class="con4"><%=document_view%></td>
			<td class="con4"><%=document_writeday%></td>
		</tr>

  <% 
		objRs.MoveNext
   		i=i+1 
    loop
   end if		
		

  objRs1.movenext
  loop
  End if   
   objRs.close
%>   
		</table>
	
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