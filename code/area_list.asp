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
  Login_chk(Session_m_id)

  if ad_c_code="N" then
	Alert_url session_m_name &" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if
  
  area_idx		= WORD_CHANGE(request("area_idx"),20)
  
  if area_idx<>"" then
  	strSql = " select A.area_idx, A.area_name, A.article_idx, A.area_policy, A.area_view, "
	strSql = strSql & " A.area_writeday, B.article_name "
	strSql = strSql & " from code_area A "
	strSql = strSql & " left outer join code_article B ON A.article_idx=B.article_idx "
	strSql = strSql & " where  A.area_idx="&area_idx&" "
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		area_idx	= ""
	Else
	c_article_idx			= objRs("article_idx")
	area_idx				= objRs("area_idx")
  	area_name				= objRs("area_name")
  	area_view				= objRs("area_view")
  	area_policy				= objRs("area_policy")
  	area_writeday			= objRs("area_writeday")
	c_article_name			= objRs("article_name")
	End If
	
	objRs.close
  Else
	area_view="Y"
	area_policy="Y"
  end if	
  
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function code_area_del(code)
	{
		ans=confirm("코드 지우시기 위해서는 고객정보에 해당하는 코드가 없어야 합니다. \n\n 코드를 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="area_del_ok.asp?area_idx="+code
		}
	}

	// 코드관리 -  코드 등록    
	function send_area() 
	{
		frm=document.all.frm_area;
		
		if(frm.article_idx.value=="0")
		{
			alert("회사를 선택해 주세요!");
			return;
		}

		if(frm.area_name.value.length==0)
		{
			alert("코드 명을 입력해 주세요!");
			frm.area_name.focus();
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

		<form name="frm_area" Method="POST" action="area_regist_ok.asp">
		<input type="hidden" name="area_idx" value="<%=area_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		
		<% If area_idx<>"" Then %>
		<Tr>
			<th width="130">회사선택</th>
			<td width="870"><%=c_article_name%>
				<input type="hidden" name="article_idx" value="<%=c_article_idx%>">
			</td>
		</tr>
		<% Else %>
		<tr>
			<th width="130">회사선택</th>
			<td width="870">
				<select name="article_idx" style="width:90px;">
				<option value="0" <% if article_idx="0" then %> selected <% end if %>> 회사선택           
				<% 
				strSql = " select * from code_article where article_step2=0 "
				strSql = strSql & " and article_view='Y' order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else						 
				i = 1
				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
					<option value="<%=article_idx%>" <% if c_article_idx=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objRs.MoveNext
					i=i+1 
				Loop
				End If
				objRs.close
				%>	
			</select></td>
		</tr>
		<% End If %>
		<tr height=30> 
			<th width='130'>지역 명</th>
			<td width='870'>
				<input type="Text" class="txtbox" name="area_name" size="30"  value="<%=area_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);">
				
				&nbsp;&nbsp;
				<input type="radio" name="area_view" value="Y" <% If area_view="Y"   Then %> checked <% End If %>>보임&nbsp;&nbsp;&nbsp;
				<input type="radio" name="area_view" value="N" <% If area_view="N" Or area_view="" Then %> checked <% End If %>>숨김&nbsp;&nbsp;&nbsp;	
				</td>
		</tr>
		<tr height=30> 
			<th>정책표 적용</th>
			<td>				
				<input type="radio" name="area_policy" value="Y" <% If area_policy="Y"  Then %> checked <% End If %>><span class='red'>적용</span>&nbsp;&nbsp;&nbsp;
				<input type="radio" name="area_policy" value="N" <% If area_policy="N" Then %> checked <% End If %>><span class='blue'>미적용 </span>
				&nbsp;&nbsp;&nbsp; 정책표에는 하나 회사에 10개의 지역까지 표시 할 수 있습니다.&nbsp;&nbsp;&nbsp;
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="area_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_area();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 개통정보 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>       								
	
				<% If area_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_area_del('<%=area_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> 님은 약정코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
				</td>	
		</tr>
		<tr height='30'>
			<td colspan='2' class='con3' style='border-style:none'> 
				<a href="area_order.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>	

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=25>             
			<td class="head" width=50>번  호</td>
			<td class="head" width=550>지역 명</td>
			<td class="head" width=100>정책표 적용</td>
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
  strSql = " select * from code_area where article_idx="&article_idx&"  "
  strSql = strSql & " order by area_order asc"
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
  		area_idx			= objRs("area_idx")
  		area_name			= objRs("area_name")
  		area_view			= objRs("area_view")
		area_policy			= objRs("area_policy")

		If area_policy="Y" Then 
			area_policy_txt="<span class='red'>적용</span>"
		Else
			area_policy_txt="<span class='blue'>미적용</span>"
		End if


		If area_view="Y" Then 
			area_view="<span class='red'>보임</span>"
		Else
			area_view="<span class='blue'>숨김</span>"
		End If

  		area_writeday		= Left(objRs("area_writeday"),10)
  %>	
		<tr height=30>
			<td class="con4"><%=i%></td>
			<td class="con2">&nbsp;&nbsp;<a href="area_list.asp?area_idx=<%=area_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=area_name%></a></td>
			<td class="con4"><%=area_policy_txt%></td>
			<td class="con4"><%=area_view%></td>
			<td class="con4"><%=area_writeday%></td>
		</tr>

  <% 
		objRs.MoveNext
   		i=i+1 
    loop
   end if		
		

  objRs1.movenext
  loop
  End if   
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>