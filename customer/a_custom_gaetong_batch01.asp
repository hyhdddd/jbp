  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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
		alert("������ ������ �ּ���!");
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
	<td colspan='2' align='center'> ���� �ø���  </td>
</tr>
<tr height="30">
	<th width=150 align='center'>�̹���</th>
	<td> 
		<input type="file" name="g_file1" class="txtbox" size="50" style="ime-mode:disabled;">
	</td>
</tr>
<tr>
	<td colspan='2' align='center'>
		<input type="button" value="���Ͼ��ε�(*.txt , *.csv)" onclick="img_append();"><br> * (Ȯ���ڴ� �ݵ�� txt �̰ų�  csv ���� �մϴ�.)
	</td>
</tr>
</table>
</form>
<br><br><br><br><br>
<TABLE width="100%" border=0 cellspacing=1 cellpadding=0 id="board_table2">
<tr height='30'>
	<td colspan='5'> ���ε� ���Ͽ� �ݵ�� �־�� �� Ÿ��Ʋ���Դϴ�</td>
</tr>
<tr height="30">
	<th class="head">No</th> 
	<th class="head">�����ڸ�</th>
	<th class="head">���Լ��񽺹�ȣ</th>        
	<th class="head">������</th>        
	<th class="head">������</th>      
</tr>
</table>
  <%
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing
  Set objCnn =Nothing
  %>
