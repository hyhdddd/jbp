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
<link rel="stylesheet" href="/include/css/style.css" type="text/css">
<script language="javascript">
<!--

function img_append()
{
	var frm=document.all.frm_img_append;

	if (frm.g_file1.value=="")
	{
		alert("파일을 선택해 주세요!");
		return;
	}
	frm.action="a_custom_gaetong_batch02.asp";
	frm.submit();
}
-->
</script>
<form id="frm_img_append" name='frm_img_append' method='post' enctype="MULTIPART/FORM-DATA"> 
<input type="hidden" name="tname" value="<%=tname%>">
<table width=100% border=1 id="board_table3">				
<tr height='30'>
	<td colspan='2' align='center'> 파일 올리기  </td>
</tr>
<tr height="30">
	<th width=150 align='center'>이미지</th>
	<td> 
		<input type="file" name="g_file1" class="txtbox" size="50" style="ime-mode:disabled;">
	</td>
</tr>
<tr>
	<td colspan='2' align='center'>
		<input type="button" value="파일업로드(*.txt , *.csv)" onclick="img_append();"><br> * (확장자는 반드시 txt 이거나  csv 여야 합니다.)
	</td>
</tr>
</table>
</form>
<br><br><br><br><br>
<TABLE width="100%" border=0 cellspacing=1 cellpadding=0 id="board_table2">
<tr height='30'>
	<td colspan='5'> 업로드 파일에 반드시 있어야 할 타이틀명입니다</td>
</tr>
<tr height="30">
	<th class="head">No</th> 
	<th class="head">가입자명</th>
	<th class="head">가입서비스번호</th>        
	<th class="head">개통일</th>        
	<th class="head">접수일</th>      
</tr>
</table>
  <%
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing
  Set objCnn =Nothing
  %>
