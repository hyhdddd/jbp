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
  
  board_idx		= WORD_CHANGE(Request("board_idx"),20)
  
  if board_idx<>"" then
  	strSql = " select * from code_card where board_idx="&board_idx&" "
  	set objRs=objCnn.Execute(strSql)

	If objRs.eof or objRs.bof Then
		board_idx		= ""
	Else	
	  	card_name		= objRs("card_name")
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
	function code_card_del(code)
	{
		ans=confirm("코드 지우시기 위해서는 고객관리 / 인사관리 정보에 선택된 코드를 사용하고 있지 않아야 합니다. \n\n 코드를 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="card_del_ok.asp?board_idx="+code
		}
	}

	function send_card() 
	{
		frm=document.all.frm_card;

		if(frm.card_name.value=="")
		{
			alert("카드사를 입력해 주세요!");
			frm.card_name.focus();
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


		<form name="frm_card" Method="POST" action="card_regist_ok.asp">
		<input type="hidden" name="board_idx" value="<%=board_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'> 
			<td colspan='2' class="description">
				&nbsp;&nbsp;* CMS에서 사용하는 카드사 명을 등록/수정 할 수 있는 메뉴 입니다.   고객관리/인사관리 등에서 사용하고 있으면 삭제가 되지 않습니다.
			</td>
		</tr>
		<tr height=30> 
			<th width="130">카 드 명 </th>
			<td width="870">
				<input type="Text" class="txtbox" name="card_name" size="30"  value="<%=card_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);">						
				</td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="card_list.asp">	
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'>
				<% end if %>      									
					<img src="/images/button/btn_new.gif" border="0"></a> 

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_card();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 코드 등록 권한이 없습니다.");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>  

				<% If board_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_card_del('<%=board_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> 님은 코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>


			</td>	
		</tr>
		</table>				

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=100>번  호</td>
			<td class="head" width=600>은 행 명</td>
		</tr>

  <%

  strSql = " select * from code_card  order by card_name Asc"
  Set objRs = objCnn.Execute(strSql)
  
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

  	i = 1
  	Do until objRs.EOF
		board_idx			= objRs("board_idx")
  		card_name			= objRs("card_name")
  %>	
		<tr height=30>             
			<td class="con5"><%=i%></td>
			<td class="con2">
				<a href="card_list.asp?board_idx=<%=board_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=card_name%></a></td>
		</tr>

  <% 
   		objrs.MoveNext
   		i=i+1 
   	loop
  end if	
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>