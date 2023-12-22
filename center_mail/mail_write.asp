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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 

  <%
  Login_chk(Session_m_id)

  tname ="mail_list"
  %>
<!DOCTYPE html>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/mail_emp_info.asp"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">
<!--
function OnConditionAdded( queryName, queryValue ) 
{    
	document.all.frm_mail.select_name.options[document.all.frm_mail.select_name.length] = new Option( queryName, queryValue );
	//alert(aa);
	return true;
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
<tr> 
	<td valign='top' align='center'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub13_t01.gif"></div>

		<form id="frm_mail" name="frm_mail" method="post"  action="mail_write_ok.asp" enctype="MULTIPART/FORM-DATA">
		<input type="hidden" name="session_m_id" value="<%=session_m_id%>">
		<input type="hidden" name="select_name_hid">

		<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3">
		<tr height=30>
			<th width="150"> 보내는 사람 </th>
			<td width="650" colspan='2'>&nbsp;<%=session_m_name%> 님 </td>
		</tr>
		<tr height=30>
			<th> 받 는 사 람 </td>
			<td colspan='2'>
				<input type="text" name="send_name" size=30 class="txtbox" onKeyPress="Mail_EnterCheck('frm_mail');"> 
				<span class="red">* 사원이름을 입력한 후 엔터를 치세요!</span>&nbsp;&nbsp;&nbsp;&nbsp;
				
				<% If ad_i_a_emp<>"N" Then %>
				<a href="javascript:NewWindow('mail_com_list.asp','zipcode',580,550,'yes');"><img src="/images/button/btn_person_open.gif" Border="0" align="absmiddle"></a>
				&nbsp;
				<a href="javascript:NewWindow('mail_group_list.asp','mail_group',700,600,'yes');"><img src="/images/button/btn_person_open2.gif" Border="0" align="absmiddle"></a>

				<% End If %>&nbsp;
				<% If ad_i_y_emp<>"N" Then %>
				<a href="javascript:NewWindow('mail_com_list.asp?y_chk=O','zipcode',580,550,'yes');"><img src="/images/button/btn_person_open1.gif" Border="0" align="absmiddle"></a>
				<% End If %>

				<span onclick="NewWindow('/sms/sms_group_regist.asp','sms_group_add','700','500','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_sms.gif" align="absmiddle"></span>

			</td>
		</tr>
		<tr height=30>
			<th> 받 는 사 람 </td>
			<td width="300"> 
				<select name="select_name" size=4  MULTIPLE  style="width:300px; border-width:1; border-style:solid; border-color:003366;">
				</select>
			<td width="350">
				<img src="/images/button/btn_person_del.gif" border="0" onclick="select_name_del1('frm_mail');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr height=30>
			<th> 메일 제목	</td>
			<td colspan='2'><input type="text" name="subject" size=50 class="txtbox"></td>
		</tr>
		<tr height=30>
			<td colspan="3"> 
				<textarea cols="80" class="ckeditor" id="board_contents" name="board_contents" rows="10" style="background-color: yellow;"><%=board_contents%></textarea>
				<script>CKEDITOR.replace( 'board_contents', {
					filebrowserImageUploadUrl: '/include/editor/upload/upload.asp?type=Images&tname=<%=o_code%>/<%=tname%>',
					filebrowserFlashUploadUrl: '/include/editor/upload/upload.asp?type=Flash&tname=<%=o_code%>/<%=tname%>'
					});</script>	
			</td>	
		</tr>
		<tr height=30>
			<th> 첨부 파일 </td>
			<td colspan='2'> <input type="file" name="file1" size="40" class="txtbox"> </td>
		</tr>							
		</table>

		<div class="button">
			<img src="/images/button/btn_list.gif" border=0 onclick="location.href='mail_to_list.asp';" onmouseover="this.style.cursor='hand';">
			<img src="/images/button/btn_send_mail.gif" border=0 onclick="send_mail_message('frm_mail');" onmouseover="this.style.cursor='hand';">
		</div>
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

<%
	message_idx		= WORD_CHANGE(request("message_idx"),20)
	emp_name		= WORD_CHANGE(request("emp_name"),20)
	if message_idx<>"" then 
		strSql = " select B.m_name, A.subject from mail_message A left outer "
		strSql = strSql & " join emp_list B ON A.send_m_id=B.m_id "
		strsql = strsql & "	 Where A.board_idx="&message_idx
		set objRs=objcnn.Execute(strSql)
		
		emp_name1		= objRs("m_name")
		mail_subject	= objRs("subject")
%>
		<script language="javascript">
		<!--
			var frm=document.all.frm_mail;
			frm.send_name.value="<%=emp_name1%>";
			frm.subject.value="[회신] <%=mail_subject%>";
			Mail_Re_Check('frm_mail');
		-->
		</script>
<%		
		
	end if
	
	if message_idx="" and emp_name<>"" then
%>
		<script language="javascript">
		<!--
			var frm=document.all.frm_mail;
			frm.send_name.value="<%=emp_name%>";
			Mail_Re_Check('frm_mail');
		-->
		</script>
<%
	end if	
%>	