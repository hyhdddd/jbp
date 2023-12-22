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

	ans = confirm("일괄처리 내역을 저장하시겠습니까?")
	if(ans==true)
	{
		frm.submit();
	}
}
-->
</script>


<div id="popupWrap">
	
	<h2>일괄 처리 </h2>
	<span class="close" ><img src="/images/button/btn_close.png" class="btn_popup_close"></span>
	
	<div class='subContents'>


		<form id="frm_board"  name="frm_board"  action="a_gift_batch_ok.asp" METHOD="POST"> 
		<input type="hidden" name="gift_idx" value="<%=gift_idx%>">
		
		<br>
		<table width=100% border=0 cellspacing="0" cellpadding="0" class="table_css">
		<tr height="35">
			<th class="head_Gray_TLB" style="width:15%;">신청상태</th>
			<td class="list_TLBR_left" style="width:85%;">
				<select name="gift_status" class='txtbox' style="width:150px;">
				<option value="신청" <% If consult_status="신청" Then %> selected <% End If %>>신청</option>
				<option value="접수" <% If consult_status="접수" Then %> selected <% End If %>>접수</option>
				<option value="완료" <% If consult_status="완료" Then %> selected <% End If %>>완료</option>
				</select>
			</td>
		</tr>		
		</table>

		
		<div class="alignCenter">
			<span class="btn_m_white01" onclick="fnc_regist('frm_board');"> 저장하기</span>
		</div>	

	</div>
</div>
  <%
  DBClose()
  %>