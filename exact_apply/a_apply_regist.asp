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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  if ad_a_gift="N" then
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If	
  
  page				= WORD_CHANGE(Request("page"),20)
  nowblock			= WORD_CHANGE(Request("nowblock"),20)
  s_link_txt		= WORD_CHANGE(Request("s_link_txt"),0)
  apply_idx			= WORD_CHANGE(Request("apply_idx"),20)

  if apply_idx<>"" then
	strSql = "SELECT * FROM exact_apply where apply_idx = " & apply_idx
	Set objRs=objCnn.Execute(strSql)

	apply_date			= objRs("apply_date")
	apply_status		= objRs("apply_status")
  end if  
  %>
<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script type="text/javascript" src="/include/js/calendar_beans_v2.0.js"></script>

<script type="text/javascript">		
$(document).ready(function() {
	CalAddCss();
	initCal({id:"apply_date",type:"day",today:"y",icon:"y", min:"2014", iconUrl:""});			
});
</script>

<script type="text/javascript">

function fnc_board_regist(form_name)
{
	var frm = document.getElementById(form_name);

	if(frm.apply_date.value=="")
	{
		alert("정산신청일을 입력해주세요.");
		frm.apply_date.focus();
		return;
	}
	
	frm.submit();
}
</script>

<script type="text/javascript">

function fnc_board_del(form_name, apply_idx)
{
	var frm = document.getElementById(form_name);
	
	var ans = confirm("데이터를 삭제하시겠습니까?");

	if(ans==true)
	{	
		frm.action = "a_apply_del_ok.asp";
		frm.submit();
	}
}
</script>


<body>
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr height='400' valign='top'> 
	<td>
		<!------------------ 내용 시작  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">정산일 신청관리</li>
		</ul>
		</div>

		<form id="frm_board" name="frm_board" action="a_apply_regist_ok.asp" METHOD="POST">
		<input type="hidden" name="apply_idx"  value="<%=apply_idx%>">
		<input type="hidden" name="page"  value="<%=page%>">
		<input type="hidden" name="nowblock"  value="<%=nowblock%>">
		<input type="hidden" name="s_link_txt"  value="<%=s_link_txt%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">

		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">정산일</th>
			<td width='85%' class="list_TLBR_left"><input type='text' class="txtbox" id='apply_date' name='apply_date' size=10 value='<%=apply_date%>' readonly></td>
		</tr>
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">상태</th>
			<td width='85%' class="list_TLBR_left">
				<select name="apply_status" class="txtbox" style="width:150px;">
				<option value="신청" <% If apply_status="신청" Then %> selected <% End If %>> 신청 </option>
				<option value="접수" <% If apply_status="접수" Then %> selected <% End If %>> 접수 </option>
				<option value="완료" <% If apply_status="완료" Then %> selected <% End If %>> 완료 </option>
				</select>
			</td>
		</tr>
		</table>

		<div class="alignRight">      
			<a href="a_apply_list.asp?page=<%=page%>&nowblock=<%=nowblock%>&<%=s_link_txt%>"><span class="btn_m_white01"> 목록으로</span></a> 
			<span class="btn_m_white01" onclick="fnc_board_regist('frm_board');"> 저장하기</span>
			<span class="btn_m_white01" onclick="fnc_board_del('frm_board');"> 삭제하기</span>
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
  DBClose()
  %>