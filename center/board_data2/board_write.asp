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
 
  tname			= WORD_CHANGE(Request("tname"),20)
  board_idx		= WORD_CHANGE(Request("board_idx"),20)
  
  if board_idx<>"" then
	strSql = "SELECT board_m_id, board_title, board_contents FROM "& tname & " where board_idx = " & board_idx
	Set objRs=objCnn.Execute(strSql)

	board_m_id		= objRs("board_m_id")
	board_title		= objRs("board_title")
	board_contents	= objRs("board_contents")

	If UCase(board_m_id)<>UCase(session_m_id) Then		
		Alert_back " 작성자만이 수정 할 수 있습니다."
	End if
  Else
	board_contents	= ""
  end if  
  board_name		= session_m_name
  %>
<!DOCTYPE html> 
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">
<!--
	function send_board_write(form_name)
	{
		var frm			= eval("document.getElementById('"+form_name+"')");

		if(frm.session_m_id.value=="")
		{
			alert(" 로그인후 사용해 주세요! ");
			return;
		}
		if(frm.board_title.value=="")
		{
			alert("제목을 입력해주세요.");
			return;
		}
		
		frm.submit();
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

		<div class="sub_title"><img src="/images/common/sub07_t04.gif"></div>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<form id="frm_board" name="frm_board" action="board_write_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="tname"  value="<%=tname%>">
		<input type="hidden" name="board_idx"  value="<%=board_idx%>">
		<input type="hidden" name="session_m_id"  value="<%=session_m_id%>">
		<tr height=30> 
			<th width="100">등록자</th>
			<td>
				<input type='text' class="txtbox" name='board_name' size=10 class=1 value='<%=board_name%>' readonly>
			</td>
		</tr>
		<tr height=30> 
			<th>제&nbsp;&nbsp;&nbsp;&nbsp;목 </th>
			<td> 
				<input type="text" class="txtbox" name="board_title" size="50" value="<%=board_title%>">
			</td>
		</tr>
		<tr height=30> 
			<td colspan='2'> 
				<textarea cols="80" class="ckeditor" id="board_contents" name="board_contents" rows="10" style="background-color: yellow;"><%=board_contents%></textarea>
				<script>CKEDITOR.replace( 'board_contents', {
					filebrowserImageUploadUrl: '/include/editor/upload/upload.asp?type=Images&tname=<%=o_code%>/<%=tname%>',
					filebrowserFlashUploadUrl: '/include/editor/upload/upload.asp?type=Flash&tname=<%=o_code%>/<%=tname%>'
					});</script>						
			</td>
		</tr>
		<tr height=30> 
			<th> 파일 </th>
			<td><input type="file" class="txtbox" name="board_fname1" size="40"></td>
		</tr>
		<tr height=30>            
			<td align='center' colspan="2"> 
				<a href="board_list.asp?tname=<%=tname%>&page=<%=page%>"><img src="/images/button/btn_list.gif"  border="0" align="absmiddle"></a> 
				<img src="/images/button/btn_regist.gif" align="absmiddle" onclick="send_board_write('frm_board');" onmouseover="this.style.cursor='hand';"> </td>
		</tr>
		</form>	
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
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>