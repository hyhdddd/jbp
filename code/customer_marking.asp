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
  Login_chk(Session_m_id)

  if ad_c_code="N" then
	Alert_back session_m_name &" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	response.end
  end If

  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/css/style_button.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
function frm_submit(form_name)
{
	var frm			= document.getElementById(form_name);
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

		<form id="frm_delete" name="frm_delete" Method="POST" action="customer_marking_ok.asp">		
	
		<!--#include virtual="/include/asp/code_menu_list.asp"-->

		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_css">
		<tr height="40">
			<th colspan="4" class="head_Gray_TLBR">마킹 정책 기간을 선택해 주세요 (기간이후 데이터가 마킹됩니다.) </th>
		</tr>
		<tr height="30">
			<td colspan="4" class="list_LBR_center"><b>마킹기간 : </b>
				<select name="o_marking" class="txtbox" style="width:100px;">
				<option value="0" <% If o_marking="0" Then %> selected <% End If %>>마킹안함 </option>
				<option value="1" <% If o_marking="1" Then %> selected <% End If %>>1일  </option>
				<option value="3" <% If o_marking="3" Then %> selected <% End If %>>3일  </option>
				<option value="7" <% If o_marking="7" Then %> selected <% End If %>>1주 </option>
				<option value="14" <% If o_marking="14" Then %> selected <% End If %>>2주 </option>
				<option value="30" <% If o_marking="30" Then %> selected <% End If %>>1개월 </option>
				<option value="60" <% If o_marking="60" Then %> selected <% End If %>>2개월 </option>
				<option value="90" <% If o_marking="90" Then %> selected <% End If %>>3개월 </option>
				</select>
			</td>
		</tr>
		<tr height="30" >
			<td colspan="26" align="center" style="text-align:center;">
				<a href="javaScript:frm_submit('frm_delete');" class="btn_m_white01">저장하기</a>
			</td>
		</tr>
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
</div>