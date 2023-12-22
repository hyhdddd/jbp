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

  if ad_i_y_emp="N" then
	Alert_url session_m_name &" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
 
  m_id			= WORD_CHANGE(request("m_id"),20)
  m_name		= WORD_CHANGE(request("m_name"),20)

  %>  	


<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function send_admin_chk()
	{
		var frm=document.all.frm_emp_regist;
		ans=confirm(" 권한 설정을 저장하시겠습니까?");
		
		if(ans==true)
		{
			frm.submit();
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
<%
  	
  if m_id="" Then
	Alert_back " 접근이 잘못되었습니다."
	Response.end
  else
    strSql="select * from emp_admin where m_id='"&m_id&"'"  	
	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof Or objRs.eof Then
		'고객관리
		ad_b_p_custom	= "N"										'고객관리 - 고객관리(개인)
		ad_b_y_custom	= "N"										'고객관리 - 고객관리(거래처)
		ad_b_a_custom	= "N"										'고객관리 - 전체 고객상품(일반)

		'가망 고객관리
		ad_g_p_gamang	= "N"										'가망고객 - 개인 가망고객 목록
		ad_g_y_gamang	= "N"										'가망고객 - 협력점 가망고객 목록
		ad_g_a_gamang	= "N"										'가망고객 - 전체 가망고객 목록

		'insa Menu
		ad_i_a_emp		= "N"										'인사관리 - 전체 사원관리
		ad_i_y_emp		= "N"										'인사관리 - 직영 사원관리
		ad_i_a_company	= "N"										'인사관리 - 파트너 정보관리

		'실적관리 
		ad_k_p_result	= "N"										'실적관리 - 개인 실적관리
		ad_k_y_result	= "N"										'실적관리 - 직영 실적관리
		ad_k_a_result	= "N"										'실적관리 - 전체 실적관리

		'정산관리 메뉴
		ad_r_y_exact	= "N"										'정산관리 - 협력점 정산내역
		ad_r_a_exact	= "N"										'정산관리 - 전체 정산관리

		'고객센터 메뉴
		ad_e_notice1	= "N"										'고객센터 - 사내 공지사항
		ad_e_notice2	= "N"										'고객센터 - 거래처 공지사항
		ad_e_data1		= "N"										'고객센터 - 사내 자료실
		ad_e_data2		= "N"										'고객센터 - 거래처 자료실
		
		'코드 관리
		ad_c_duty		= "N"										'코드관리 - 부서코드
		ad_c_position	= "N"										'코드관리 - 직책코드
		ad_c_sale		= "N"										'코드관리 - 할인탭
		ad_c_course		= "N"										'코드관리 - 접수경로
		ad_c_gaetong	= "N"										'코드관리 - 개통코드
		ad_c_promise	= "N"										'코드관리 - 상품약정
		ad_c_article	= "N"										'코드관리 - 상품코드	

	Else	
		'고객관리
		ad_b_p_custom	= CheckAdmin(objRs("ad_b_p_custom"))		'고객관리 - 고객관리(개인)
		ad_b_y_custom	= CheckAdmin(objRs("ad_b_y_custom"))		'고객관리 - 고객관리(거래처)		
		ad_b_a_custom	= CheckAdmin(objRs("ad_b_a_custom"))		'고객관리 - 전체 고객상품(일반)

		'가망고객관리
		ad_g_p_gamang	= CheckAdmin(objRs("ad_g_p_gamang"))		'가망고객 - 개인 가망고객 목록
		ad_g_y_gamang	= CheckAdmin(objRs("ad_g_y_gamang"))		'가망고객 - 협력점 가망고객 목록
		ad_g_a_gamang	= CheckAdmin(objRs("ad_g_a_gamang"))		'가망고객 - 전체 가망고객 목록


		'insa Menu
		ad_i_a_emp		= CheckAdmin(objRs("ad_i_a_emp"))			'인사관리 - 전체 사원관리
		ad_i_y_emp		= CheckAdmin(objRs("ad_i_y_emp"))			'인사관리 - 직영 사원관리
		ad_i_a_company	= CheckAdmin(objRs("ad_i_a_company"))		'인사관리 - 파트너 정보관리

		'실적관리 
		ad_k_p_result	= CheckAdmin(objRs("ad_k_p_result"))		'실적관리 - 개인 실적 관리
		ad_k_y_result	= CheckAdmin(objRs("ad_k_y_result"))		'실적관리 - 직영 실적 관리
		ad_k_a_result	= CheckAdmin(objRs("ad_k_a_result"))		'실적관리 - 전체 실적 관리

		'정산관리 메뉴
		ad_r_y_exact	= CheckAdmin(objRs("ad_r_y_exact"))			'정산관리 - 협력점 정산내역
		ad_r_a_exact	= CheckAdmin(objRs("ad_r_a_exact"))			'정산관리 - 전체 정산관리

		'고객센터 메뉴
		ad_e_notice1	= CheckAdmin(objRs("ad_e_notice1"))			'고객센터 - 사내 공지사항
		ad_e_notice2	= CheckAdmin(objRs("ad_e_notice2"))			'고객센터 - 거래처 공지사항
		ad_e_data1		= CheckAdmin(objRs("ad_e_data1"))			'고객센터 - 사내 자료실
		ad_e_data2		= CheckAdmin(objRs("ad_e_data2"))			'고객센터 - 거래처 자료실		
	end if  	
  end If
  %>
		<div class="sub_title"><img src="/images/common/sub03_t01.gif"></div>

		<form action="y_emp_admin_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_id" value="<%=m_id%>">				
		<input type="hidden" name="m_name" value="<%=m_name%>">				

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="board_table3">
		<tr height=25> 
			<th width="200">사원명</th>
			<td colspan='3'> <%=m_name%></td>
		</tr>
		<tr height='30'> 
			<td colspan='4' align='left'> * 고객관리 </th>
		</tr>
		<tr height='30'> 
			<th width="200">개인 가입신청 관리</th>
			<td width="200"> 
				<select name="ad_b_p_custom" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_b_p_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_b_p_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_b_p_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
			<th width="200">협력점 가입신청 관리</th>
			<td width="200"> 
				<select name="ad_b_y_custom" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_b_y_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_b_y_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_b_y_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * 가망고객 관리 </th>
		</tr>
		<tr height='30'> 
			<th width="200"> 개인 가망고객 관리</th>
			<td width="200"> 
				<select name="ad_g_p_gamang" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_g_p_gamang="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_g_p_gamang="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_g_p_gamang="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
			<th width="200"> 협력점 가망고객 관리 </th>
			<td width="200"> 
				<select name="ad_g_y_diary" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_g_y_diary="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_g_y_diary="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_g_y_diary="W" Then %> selected <% End If %>> 쓰기 권한 </option>
					<option value="E" <% If ad_g_y_diary="E" Then %> selected <% End If %>> 수정 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * 인사 관리 </th>
		</tr>
		<tr height='30'> 
			<th width="200"> 직영 사원관리 </th>
			<td width="200"> 
				<select name="ad_i_y_emp" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_i_y_emp="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_i_y_emp="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_i_y_emp="W" Then %> selected <% End If %>> 쓰기 권한 </option>
					<option value="E" <% If ad_i_y_emp="E" Then %> selected <% End If %>> 수정 권한 </option>
				</select> 
			</td>
			<th width="200"></th>
			<td width="200"></td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * 실적 관리 </th>
		</tr>
		<tr height='30'> 
			<th width="200"> 개인 실적관리 </th>
			<td width="200"> 
				<select name="ad_k_p_result" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_k_p_result="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_k_p_result="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_k_p_result="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
			<th width="200"> 직영 실적관리 </th>
			<td width="200"> 
				<select name="ad_k_y_result" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_k_y_result="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_k_y_result="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_k_y_result="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * 정산 관리 </th>
		</tr>
		<tr height='30'> 
			<th width="200"> 협력점 정산내역 </th>
			<td width="200"> 
				<select name="ad_r_y_exact" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_r_y_exact="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_r_y_exact="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_r_y_exact="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
			<th width="200"></th>
			<td width="200"></td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * 고객 센터 </th>
		</tr>
		<tr height='30'> 
			<th width="200"> 거래처 공지사항 </th>
			<td width="200"> 
				<select name="ad_e_notice2" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_e_notice2="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_e_notice2="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_e_notice2="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
			<th width="200"> 거래처 자료실 </th>
			<td width="200"> 
				<select name="ad_e_data2" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_e_data2="N" Then %> selected <% End If %>> 권한 없음 </option>
					<option value="R" <% If ad_e_data2="R" Then %> selected <% End If %>> 읽기 권한 </option>
					<option value="W" <% If ad_e_data2="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='30'>
			<td colspan='4' align='center'>						
				<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_admin_chk();" onmouseover="this.style.cursor='hand';">									        				
				<a href ="/insa/y_emp_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a> 
			</td>
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
</body>
</html>
