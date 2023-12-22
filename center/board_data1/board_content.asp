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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)
 
  if ad_e_data1="N" then
	Alert_url session_m_name &" 님은 사내자료실 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end If

  tname		= WORD_CHANGE(request("tname"),20)
  board_idx	= WORD_CHANGE(request("board_idx"),20)
  page		= WORD_CHANGE(request("page"),20)
  
  strSql = "Update "& tname &" Set board_readnum = board_readnum+1  where board_idx =" & board_idx
  set objRs=objCnn.Execute(strSql)
  
  strSql = "SELECT * FROM "& tname &" where board_idx=" & board_idx
  set objRs=objCnn.Execute(strSql)

  board_name		= objRs("board_name")
  board_writeday	= Left(objRs("board_writeday"),10)
  board_readnum		= objRs("board_readnum")
  board_title		= objRs("board_title")
  board_contents 	= objRs("board_contents")
  board_fname1		= objRs("board_fname1")

  if len(board_fname1)>0 then
	filepath1	= o_code&"/"&tname&"/"&left(board_fname1, InstrRev(board_fname1,"/"))  
  	filename1	= mid(board_fname1, InstrRev(board_fname1,"/")+1)  
  end If
  %>
<!DOCTYPE html>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function board_del_ok(url)
	{
		ans=confirm("글을 삭제하시겠습니까?");
		if(ans==true)
		{
			location.replace(url);
		}
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>
		
		<div class="sub_title"><img src="/images/common/sub07_t03.gif"></div>

		<table width="100%" height="26" border="0" cellpadding="0" cellspacing="0" id="board_table3">    			
		<tr height=30>
			<th><%=board_title%></th>
		</tr>
		<Tr>
			<td>					
				<table width=100% border=0 cellpadding="0" cellspacing="0" id="board_table3">        				
				<tr height="30"> 
					<th width="100">글번호</th>
					<td width="300"><%=BOARD_IDX%></td>
					<th width="100">등록일</th>
					<td width="300"><%=board_writeday%></td>
				</tr>
				<tr height="30"> 
					<th>등록자</th>
					<td>&nbsp;<%=board_name%></td>
					<th>조회수</th>
					<td>&nbsp;<%=board_readnum%>명</td>
				</tr>
				<tr height="30"> 
					<td align="right" colspan='4'>
						<% if len(board_fname1)>1 then %>
						<b><a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=mid(board_fname1,8)%></a></b>
						<% end if %>&nbsp;
					</td>
				</tr>
				</table>
			</td>
		</tr>	
		<tr height=250>
			<td valign='top'><%=board_contents%></td>
		</tr>        		
		<tr height="30"> 
			<td align="right" >       
				<a href="board_list.asp?tname=<%=tname%>&page=<%=page%>"><img src="/images/button/btn_list.gif"  border="0"></a> 

				<% if ad_e_data1="E" Or ad_e_data1="A" Then %>
					<a href="board_write.asp?board_idx=<%=board_idx%>&tname=<%=tname%>"><img src="/images/button/btn_Rewrite.gif"  border="0"></a> 
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 수정 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_Rewrite.gif" border="0"></a>
				<% End If %>
				<% If ad_e_data1="A" Then %>
					<a href="javascript:board_del_ok('board_del_ok.asp?board_idx=<%=board_idx%>&tname=<%=tname%>')"><img src="/images/button/btn_delete.gif" border="0"></a> 
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 삭제 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_delete.gif" border="0"></a>
				<% End If %>

			</td>
		</tr> 
		</table>
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>