  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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


  gift_idx		=WORD_CHANGE(request("gift_idx"),0)

  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script type="text/javascript" src="/include/js/calendar_beans_v2.0.js"></script>


<script type="text/javascript">
$(document).ready(function() {
	$(".btn_popup_close").click(function(e) { 
		window.parent.remove_modal();
	});
});
</script>

<script type="text/javascript">
<!--
function fnc_regist(form_name)
{
	var frm	= document.getElementById(form_name);

	ans = confirm("�ϰ�ó�� ������ �����Ͻðڽ��ϱ�?")
	if(ans==true)
	{
		frm.submit();
	}
}
-->
</script>


<div id="popupWrap">
	
	<h2>�ϰ� ó�� </h2>
	<span class="close" ><img src="/images/button/btn_close.png" class="btn_popup_close"></span>
	
	<div class='subContents'>


		<form id="frm_board"  name="frm_board"  action="a_gift_batch_ok.asp" METHOD="POST"> 
		<input type="hidden" name="gift_idx" value="<%=gift_idx%>">
		
		<br>
		<table width=100% border=0 cellspacing="0" cellpadding="0" class="table_css">
		<tr height="35">
			<th class="head_Gray_TLB" style="width:15%;">��û����</th>
			<td class="list_TLBR_left" style="width:85%;">
				<select name="gift_status" class='txtbox' style="width:150px;">
				<option value="��û" <% If consult_status="��û" Then %> selected <% End If %>>��û</option>
				<option value="����" <% If consult_status="����" Then %> selected <% End If %>>����</option>
				<option value="�Ϸ�" <% If consult_status="�Ϸ�" Then %> selected <% End If %>>�Ϸ�</option>
				</select>
			</td>
		</tr>		
		</table>

		
		<div class="alignCenter">
			<span class="btn_m_white01" onclick="fnc_regist('frm_board');"> �����ϱ�</span>
		</div>	

	</div>
</div>
  <%
  DBClose()
  %>