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

  if ad_i_a_emp="N" then
	Alert_url session_m_name&" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
 
  If session_m_step="M" Then
  Else
	Alert_url session_m_name&" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  End If 

  m_id			= WORD_CHANGE(request("m_id"),20)
  m_name		= WORD_CHANGE(request("m_name"),20)

  %>  	

<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
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
		ad_b_p_custom	= "N"										'고객관리 - 개인
		ad_b_y_custom	= "N"										'고객관리 - 거래처
		ad_b_a_custom	= "N"										'고객관리 - 전체
		ad_b_g_custom	= "N"										'고객관리 - 상부점
		ad_b_m_custom	= "N"										'고객관리 - 담당별

		'엑셀권한 설정
		ad_b_p_excel	= "N"										'고객관리 - 엑셀_개인
		ad_b_y_excel	= "N"										'고객관리 - 엑셀_협력점
		ad_b_a_excel	= "N"										'고객관리 - 엑셀_전체
		ad_b_g_excel	= "N"										'고객관리 - 엑셀_상부점
		ad_b_m_excel	= "N"										'고객관리 - 엑셀_담당별

		'가망 고객관리
		ad_g_p_gamang	= "N"										'가망고객 - 나의 가망고객
		ad_g_y_gamang	= "N"										'가망고객 - 협력점 가망고객
		ad_g_a_gamang	= "N"										'가망고객 - 전체 가망고객

		'insa Menu
		ad_i_a_emp		= "N"										'인사관리 - 전체 사원관리
		ad_i_y_emp		= "N"										'인사관리 - 거래처 사원관리
		ad_i_a_company	= "N"										'인사관리 - 거래처 정보등록

		ad_p_a_pay		= "N"										'급여관리 - 전체
		'실적관리 
		ad_k_p_result	= "N"										'실적관리 - 나의 실적 관리
		ad_k_y_result	= "N"										'실적관리 - 거래처 실적 관리
		ad_k_a_result	= "N"										'실적관리 - 전체 실적 관리

		'정산관리 메뉴
		ad_r_p_exact	= "N"										'정산관리 - 개인 정산관리
		ad_r_y_exact	= "N"										'정산관리 - 거래처 정산관리
		ad_r_a_exact	= "N"										'정산관리 - 전체 정산관리
		ad_r_g_exact	= "N"										'정산관리 - 인계처 정산관리

		'고객센터 메뉴
		ad_e_notice1	= "N"										'고객센터 - 사내 공지사항
		ad_e_notice2	= "N"										'고객센터 - 거래처 공지사항
		ad_e_data1		= "N"										'고객센터 - 사내 자료실
		ad_e_data2		= "N"										'고객센터 - 거래처 자료실
		
		'코드 관리
		ad_c_code		= "N"										'부가서비스 - 코드관리
		ad_c_sms		= "N"										'부가서비스 - sms관리
		ad_c_popup		= "N"										'부가서비스 - 팝업관리
		ad_c_black		= "N"										'부가서비스 - 블랙리스트 관리
		ad_c_fee		= "N"										'부가서비스 - 요금표 관리

		ad_p_gift		= "N"
		ad_a_gift		= "N"

	Else	
		'고객관리
		ad_b_p_custom	= CheckAdmin(objRs("ad_b_p_custom"))		'고객관리 - 고객관리(개인)
		ad_b_y_custom	= CheckAdmin(objRs("ad_b_y_custom"))		'고객관리 - 고객관리(거래처)		
		ad_b_a_custom	= CheckAdmin(objRs("ad_b_a_custom"))		'고객관리 - 전체 고객상품(일반)
		ad_b_g_custom	= CheckAdmin(objRs("ad_b_g_custom"))		'고객관리 - 인계처 고객
		ad_b_m_custom	= CheckAdmin(objRs("ad_b_m_custom"))		'고객관리 - 담당 고객관리

		'엑셀권한설정
		ad_b_p_excel	= CheckAdmin(objRs("ad_b_p_excel"))			'고객관리 - 엑셀_개인
		ad_b_y_excel	= CheckAdmin(objRs("ad_b_y_excel"))			'고객관리 - 엑셀_협력점
		ad_b_a_excel	= CheckAdmin(objRs("ad_b_a_excel"))			'고객관리 - 엑셀_전체
		ad_b_g_excel	= CheckAdmin(objRs("ad_b_g_excel"))			'고객관리 - 엑셀_상부점
		ad_b_m_excel	= CheckAdmin(objRs("ad_b_m_excel"))			'고객관리 - 엑셀_담당별

		'가망고객관리
		ad_g_p_gamang	= CheckAdmin(objRs("ad_g_p_gamang"))		'가망고객 - 나의 가망고객
		ad_g_y_gamang	= CheckAdmin(objRs("ad_g_y_gamang"))		'가망고객 - 협력점 가망고객
		ad_g_a_gamang	= CheckAdmin(objRs("ad_g_a_gamang"))		'가망고객 - 전체 가망고객

		'insa Menu
		ad_i_a_emp		= CheckAdmin(objRs("ad_i_a_emp"))			'인사관리 - 전체 사원관리
		ad_i_y_emp		= CheckAdmin(objRs("ad_i_y_emp"))			'인사관리 - 거래처 사원관리
		ad_i_a_company	= CheckAdmin(objRs("ad_i_a_company"))		'인사관리 - 거래처 정보등록

		'실적관리 
		ad_k_p_result	= CheckAdmin(objRs("ad_k_p_result"))		'실적관리 - 나의 실적 관리
		ad_k_y_result	= CheckAdmin(objRs("ad_k_y_result"))		'실적관리 - 거래처 실적 관리
		ad_k_a_result	= CheckAdmin(objRs("ad_k_a_result"))		'실적관리 - 전체 실적 관리

		'정산관리 메뉴
		ad_r_p_exact	= CheckAdmin(objRs("ad_r_p_exact"))			'정산관리 - 개인 정산관리
		ad_r_y_exact	= CheckAdmin(objRs("ad_r_y_exact"))			'정산관리 - 거래처 정산관리
		ad_r_a_exact	= CheckAdmin(objRs("ad_r_a_exact"))			'정산관리 - 전체 정산관리
		ad_r_g_exact	= CheckAdmin(objRs("ad_r_g_exact"))			'정산관리 - 인계 정산관리

		'고객센터 메뉴
		ad_e_notice1	= CheckAdmin(objRs("ad_e_notice1"))			'고객센터 - 사내 공지사항
		ad_e_notice2	= CheckAdmin(objRs("ad_e_notice2"))			'고객센터 - 거래처 공지사항
		ad_e_data1		= CheckAdmin(objRs("ad_e_data1"))			'고객센터 - 사내 자료실
		ad_e_data2		= CheckAdmin(objRs("ad_e_data2"))			'고객센터 - 거래처 자료실


		'부가서비스 관리
		ad_c_sms		= CheckAdmin(objRs("ad_c_sms"))				'부가서비스 - sms 관리
		ad_c_code		= CheckAdmin(objRs("ad_c_code"))			'부가서비스 - 코드관리
		ad_c_popup		= CheckAdmin(objRs("ad_c_popup"))			'부가서비스 - popup 관리
		ad_c_black		= CheckAdmin(objRs("ad_c_black"))			'부가서비스 - 블랙리스트 관리
		ad_c_fee		= CheckAdmin(objRs("ad_c_fee"))				'부가서비스 - 요금표 관리
		ad_a_marking	= CheckAdmin(objRs("ad_a_marking"))	

		ad_p_gift		= CheckAdmin(objRs("ad_p_gift"))	
		ad_a_gift		= CheckAdmin(objRs("ad_a_gift"))	

	end if  	
  end If
  %>
		<div class="sub_title"><img src="/images/common/sub03_t02.gif"></div>

		<form action="a_emp_admin_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_id" value="<%=m_id%>">				
		<input type="hidden" name="m_name" value="<%=m_name%>">				

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="board_table3">
		<tr height=30> 
			<th width="200">사원명</th>
			<td colspan='3'> <%=m_name%></td>
		</tr>
		<tr height='30'> 
			<td colspan='4' align='left'>&nbsp; <b> * 고객관리 </b></th>
		</tr>
		<tr height='30'> 
			<th width="150">개인 가입신청 관리 </th>
			<td width="350"> 
				<select name="ad_b_p_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_p_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_b_p_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_b_p_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_b_p_custom="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_b_p_custom="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_p_excel" value="Y" <% If ad_b_p_excel="Y" Then %> checked <% End If %>>엑셀다운
			</td>
		</tr>
		<tr>
			<th width="150">협력점 가입신청 관리</th>
			<td width="350"> 
				<select name="ad_b_y_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_y_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_b_y_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_b_y_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_b_y_custom="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_b_y_custom="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_y_excel" value="Y" <% If ad_b_y_excel="Y" Then %> checked <% End If %>>엑셀다운
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'>전체 가입신청 관리</td>
			<td width="850" colspan='3'> 
				<select name="ad_b_a_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_a_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_b_a_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_b_a_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_b_a_custom="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_b_a_custom="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_a_excel" value="Y" <% If ad_b_a_excel="Y" Then %> checked <% End If %>>엑셀다운

			</td>			
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'>상부점 고객 관리</td>
			<td width="850" colspan='3'> 
				<select name="ad_b_g_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_g_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_b_g_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_b_g_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_b_g_custom="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_b_g_custom="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_g_excel" value="Y" <% If ad_b_g_excel="Y" Then %> checked <% End If %>>엑셀다운

			</td>			
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'>담당별 고객 관리</td>
			<td width="850" colspan='3'> 
				<select name="ad_b_m_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_m_custom="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_b_m_custom="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_b_m_custom="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_b_m_custom="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_b_m_custom="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_m_excel" value="Y" <% If ad_b_m_excel="Y" Then %> checked <% End If %>>엑셀다운

			</td>			
		</tr> 
		<tr height='25'> 
			<td colspan='4' align='left'><b> * 가망고객 관리 </b></th>
		</tr>
		<tr height='25'> 
			<th width="150"> 개인 가망고객 관리</th>
			<td width="850"> 
				<select name="ad_g_p_gamang" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_g_p_gamang="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_g_p_gamang="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_g_p_gamang="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_g_p_gamang="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_g_p_gamang="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 협력점 가망고객 관리</td>
			<td width="850"> 
				<select name="ad_g_y_gamang" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_g_y_gamang="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_g_y_gamang="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_g_y_gamang="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_g_y_gamang="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_g_y_gamang="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 전체 가망고객 관리</td>
			<td width="850"> 
				<select name="ad_g_a_gamang" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_g_a_gamang="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_g_a_gamang="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_g_a_gamang="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_g_a_gamang="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_g_a_gamang="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td colspan='4' align='left'><b> * 인사 관리 </b></th>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 전체 사원 관리 </td>
			<td width="850"> 
				<select name="ad_i_a_emp" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_i_a_emp="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_i_a_emp="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_i_a_emp="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_i_a_emp="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_i_a_emp="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> 직영 사원관리 </th>
			<td width="850"> 
				<select name="ad_i_y_emp" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_i_y_emp="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_i_y_emp="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_i_y_emp="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_i_y_emp="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_i_y_emp="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'> 협력점 정보 관리 </td>
			<td width="850"> 
				<select name="ad_i_a_company" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_i_a_company="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_i_a_company="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_i_a_company="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_i_a_company="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_i_a_company="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td colspan='4' align='left'><b> * 실적 관리 </b></th>
		</tr>
		<tr height='25'> 
			<th width="150"> 개인 실적관리 </th>
			<td width="850"> 
				<select name="ad_k_p_result" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_k_p_result="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_k_p_result="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_k_p_result="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_k_p_result="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_k_p_result="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> 직영 실적관리 </th>
			<td width="850"> 
				<select name="ad_k_y_result" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_k_y_result="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_k_y_result="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_k_y_result="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_k_y_result="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_k_y_result="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'> 전체 실적관리 </td>
			<td width="850"> 
				<select name="ad_k_a_result" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_k_a_result="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_k_a_result="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_k_a_result="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_k_a_result="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_k_a_result="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td colspan='4' align='left'><b> * 정산 관리 <b></th>
		</tr>
		<tr height='25'> 
			<th width="150"> 개인 정산 내역서 </th>
			<td width="850"> 
				<select name="ad_r_p_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_p_exact="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_r_p_exact="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_r_p_exact="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<th width="150"> 협력점 정산 내역서 </th>
			<td width="850"> 
				<select name="ad_r_y_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_y_exact="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_r_y_exact="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_r_y_exact="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_r_y_exact="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_r_y_exact="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr>
			<td width="150" class='con6'> 전체 정산관리및 내역서 </td>
			<td width="850"> 
				<select name="ad_r_a_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_a_exact="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_r_a_exact="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_r_a_exact="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_r_a_exact="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_r_a_exact="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr>
			<td width="150" class='con6'> 상부점 정산관리 </td>
			<td width="850"> 
				<select name="ad_r_g_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_g_exact="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_r_g_exact="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_r_g_exact="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_r_g_exact="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_r_g_exact="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 

		<tr>
			<td width="150" class='con6'> 정산일/사은품 신청 </td>
			<td width="850"> 
				<select name="ad_p_gift" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_p_gift="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_p_gift="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_p_gift="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_p_gift="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_p_gift="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr>
			<td width="150" class='con6'> 정산일/사은품 관리 </td>
			<td width="850"> 
				<select name="ad_a_gift" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_a_gift="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_a_gift="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_a_gift="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_a_gift="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_a_gift="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 

		<tr height='25'> 
			<td colspan='2' align='left'><b> * 고객 센터 </b></th>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 사내 공지사항 </td>
			<td width="850"> 
				<select name="ad_e_notice1" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_notice1="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_e_notice1="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_e_notice1="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_e_notice1="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_e_notice1="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> 협력점 공지사항 </th>
			<td width="850"> 
				<select name="ad_e_notice2" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_notice2="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_e_notice2="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_e_notice2="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_e_notice2="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_e_notice2="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'> 사내 자료실 </td>
			<td width="850"> 
				<select name="ad_e_data1" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_data1="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_e_data1="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_e_data1="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_e_data1="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_e_data1="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> 협력점 자료실 </th>
			<td width="850"> 
				<select name="ad_e_data2" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_data2="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_e_data2="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_e_data2="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_e_data2="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_e_data2="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td colspan='2' align='left'><b> * 부가서비스 관리 </b></th>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> SMS 관리 </td>
			<td width="850"> 
				<select name="ad_c_sms" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_sms="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_c_sms="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_c_sms="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_c_sms="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_c_sms="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 코드 관리 </td>
			<td width="850"> 
				<select name="ad_c_code" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_code="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_c_code="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_c_code="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_c_code="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_c_code="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 팝업 공지 관리 </td>
			<td width="850"> 
				<select name="ad_c_popup" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_popup="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_c_popup="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_c_popup="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_c_popup="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_c_popup="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 블랙 리스트 관리 </td>
			<td width="850"> 
				<select name="ad_c_black" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_black="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_c_black="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_c_black="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_c_black="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_c_black="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 요금표 관리 </td>
			<td width="850"> 
				<select name="ad_c_fee" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_fee="N" Then %> selected <% End If %>> 권한 없음 </option>
				<option value="R" <% If ad_c_fee="R" Then %> selected <% End If %>> 읽기 권한 </option>
				<option value="W" <% If ad_c_fee="W" Then %> selected <% End If %>> 쓰기 권한 </option>
				<option value="E" <% If ad_c_fee="E" Then %> selected <% End If %>> 수정 권한 </option>
				<option value="A" <% If ad_c_fee="A" Then %> selected <% End If %>> 모든 권한 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> 마킹정책 </td>
			<td width="850"> 
				<select name="ad_a_marking" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_a_marking="N" Then %> selected <% End If %>> 마킹적용 </option>
				<option value="A" <% If ad_a_marking="A" Then %> selected <% End If %>> 마킹미적용 </option>
				</select> 
			</td>
		</tr>
		<tr height='25'>
			<td colspan='2' align='center' style="text-align:center;">						
				<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_admin_chk();" onmouseover="this.style.cursor='hand';">										        				
				<a href ="/insa/a_emp_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a> 
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
