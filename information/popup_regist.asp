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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 

  <%
  Login_chk(Session_m_id)
  tname		="popup"
  
  if ad_c_popup="N" then
 	Alert_URL session_m_name &" ���� �˾����� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	

  p_idx					= WORD_CHANGE(Request("p_idx"),20)

  If p_idx<>"" Then 
	  strSql="select * from popup where p_idx="&p_idx  	
	  set objRs=objCnn.Execute(strSql)
			
	  p_idx				= objRs("p_idx")
	  p_title			= objRs("p_title")
	  p_contents		= objRs("p_contents")
	  p_writeday		= objRs("p_writeday")
	  p_width			= objRs("p_width")
	  p_height			= objRs("p_height")
	  p_top				= objRs("p_top")
	  p_left			= objRs("p_left")
	  p_view			= objRs("p_view")
  End if
  %>  
<!DOCTYPE html> 
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">
<!--
//������ �Խ��� �۾���
function popup_regist(form_name)
{
	var frm			= eval("document.getElementById('"+form_name+"')");
	
	if(frm.p_title.value=="")
	{
		alert("�˾�â ������ �Է��� �ּ���!");
		frm.p_title.focus();
		return;
	}

	if(frm.p_width.value=="")
	{
		alert("�˾�â ���̸� �Է��� �ּ���!");
		frm.p_width.focus();
		return;
	}

	if(frm.p_height.value=="")
	{
		alert("�˾�â ���̸� �Է��� �ּ���!");
		frm.p_height.focus();
		return;
	}


	frm.submit();
}

function popup_del(form_name,p_idx)
{
	var frm=eval("document.all."+form_name);
	
	ans=confirm("�˾� �������� �����Ͻðڽ��ϱ�?");


	if(ans==true)
	{
		location.href="popup_del_ok.asp?p_idx="+p_idx;
	}
}

-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td>
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub12_t06.gif"></div>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<form id="frm_board" name="frm_board" action="popup_regist_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="p_idx"  value="<%=p_idx%>">
		<tr height=30> 
			<th width="100">�˾� ���� ����</th>
			<td>
				<input type='text' class="txtbox" name='p_title' size=50 maxlength='50' value='<%=p_title%>'>
			</td>
		</tr>
		<tr> 
			<th width="100">�˾�â ������</th>
			<td> ����: 
					<input type="text" name="p_width" size="6" class='txtbox' maxlength="4" value="<%=p_width%>" onFocus="FocusColor(this); this.select();" onKeyUp="fncOnlyNumber(this);">
					px, ����:
					<input type="text" name="p_height" size="6" class='txtbox' maxlength="4" value="<%=p_height%>" onFocus="FocusColor(this); this.select();" onKeyUp="fncOnlyNumber(this);">
					px �� ���ڸ� �Է��ϼ��� </td>
		</tr>
		<tr> 
			<th width="100">�˾�â ��ġ</th>
			<td> TOP: 
					<input type="text" name="p_top" size="6" class='txtbox' maxlength="4" value="<%=p_top%>" onFocus="FocusColor(this); this.select();" onKeyUp="fncOnlyNumber(this);">
					px, LEFT:
					<input type="text" name="p_left" size="6" class='txtbox' maxlength="4" value="<%=p_left%>" onFocus="FocusColor(this); this.select();" onKeyUp="fncOnlyNumber(this);">
					px �� ���ڸ� �Է��ϼ��� </td>
		</tr>
		<tr> 
			<th width="100">���� / ����</th>
			<td> 
					<input type="radio" name="p_view" size="6" maxlength="4" value="Y" <% If p_view="Y" Or p_view="" Then %> checked <% End If %>> ���� &nbsp;&nbsp;
					<input type="radio" name="p_view" size="6" maxlength="4" value="N" <% If p_view="N" Then %> checked <% End If %>> ����
			</td>
		</tr>
		<tr height=30> 
			<td colspan='2'> 
				<textarea cols="80" class="ckeditor" id="board_contents" name="board_contents" rows="10" style="background-color: yellow;"><%=p_contents%></textarea>
				<script>CKEDITOR.replace( 'board_contents',
					allowedContent:true,
					{
					filebrowserImageUploadUrl: '/include/editor/upload/upload.asp?type=Images&tname=<%=o_code%>/<%=tname%>',
					filebrowserFlashUploadUrl: '/include/editor/upload/upload.asp?type=Flash&tname=<%=o_code%>/<%=tname%>'
					});</script>					
			</td>
		</tr>		

		<tr height=30>            
			<td align='center' colspan="2"> 
				<a href="popup_list.asp?page=<%=page%>"><img src="/images/button/btn_list.gif"  border="0"></a> 

				<% If p_idx<>"" Then %>
					<% if ad_c_popup="E" OR ad_c_popup="A" then %>
						<img src="/images/button/btn_regist.gif" onclick="popup_regist('frm_board');" onmouseover="this.style.cursor='hand';"> 
					<% Else %>
						<a href='javascript:alert("<%=session_m_name%> ���� �˾� ���������� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_regist.gif" border="0"></a>
					<% End If %>
				<% Else %>
					<% if ad_c_popup="W" Or ad_c_popup="E" OR ad_c_popup="A" then %>
						<img src="/images/button/btn_regist.gif" onclick="popup_regist('frm_board');" onmouseover="this.style.cursor='hand';"> 
					<% Else %>
						<a href='javascript:alert("<%=session_m_name%> ���� �˾� ��ϱ����� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_regist.gif" border="0"></a>
					<% End If %>
				<% End If %>

				<% If p_idx<>"" Then %>
					<% If ad_c_popup="A" Then %>
						<span onclick="popup_del('frm_board','<%=p_idx%>');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_delete.gif"></span>
					<% Else %>
						<a href='javascript:alert("<%=session_m_name %> ���� �˾� ���� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_delete.gif" border="0"></a>&nbsp;&nbsp;
					<% End If %>
				<% End If %>
			</td>
		</tr>
		</form>	
		</table>
		<!------------------ ���� ����  ------------------>			
	</td>		
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>