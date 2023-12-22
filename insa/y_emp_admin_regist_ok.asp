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

  m_id				= WORD_CHANGE(Request("m_id"),20)
  m_name			= WORD_CHANGE(Request("m_name"),20)

  If m_id="" Then
	Alert_back " 접근이 잘못되었습니다."
	Response.End
  End if

 '고객관리
  ad_b_p_custom		= CheckAdmin(Request("ad_b_p_custom"))		'고객관리 - 고객관리(개인)
  ad_b_y_custom		= CheckAdmin(Request("ad_b_y_custom"))		'고객관리 - 고객관리(거래처)

  '가망고객관리
  ad_g_p_gamang		= CheckAdmin(Request("ad_g_p_gamang"))		'가망고객관리 - 나의 가망고객
  ad_g_y_gamang		= CheckAdmin(Request("ad_g_y_gamang"))		'가망고객관리 - 협력점 가망고객

  'insa Menu
  ad_i_y_emp		= CheckAdmin(Request("ad_i_y_emp"))			'인사관리 - 거래처 사원관리

  '실적관리 
  ad_k_p_result		= CheckAdmin(Request("ad_k_p_result"))		'실적관리 - 나의 실적 관리
  ad_k_y_result		= CheckAdmin(Request("ad_k_y_result"))		'실적관리 - 거래처 실적 관리

  '정산관리 메뉴
  ad_r_y_exact		= CheckAdmin(Request("ad_r_y_exact"))		'정산관리 - 거래처 정산관리

  '고객센터 메뉴
  ad_e_notice2		= CheckAdmin(Request("ad_e_notice2"))		'고객센터 - 거래처 공지사항
  ad_e_data2		= CheckAdmin(Request("ad_e_data2"))			'고객센터 - 거래처 자료실

  strsql = " select * from emp_admin where m_id='"&m_id&"'"
  set objRs=objCnn.execute(strSql)
  
	
  if objRs.eof or objRs.bof then 
    strSql = "select ISNULL(MAX(board_idx)+1,1) AS SEQ from emp_admin"
	Set objRs=objCnn.Execute(strSql)

	board_idx=objRs(0)
	
  	strSql = " insert into emp_admin ("
  	strSql = strSql & "  board_idx "
	strSql = strSql & ", o_code"
	strSql = strSql & ", m_id"
	strSql = strSql & ", ad_b_p_custom"
	strSql = strSql & ", ad_b_y_custom"
	strSql = strSql & ", ad_g_p_gamang"
	strSql = strSql & ", ad_g_y_gamang"
	strSql = strSql & ", ad_i_y_emp"
	strSql = strSql & ", ad_k_p_result"
	strSql = strSql & ", ad_k_y_result"
	strSql = strSql & ", ad_r_y_exact"
	strSql = strSql & ", ad_e_notice2"
	strSql = strSql & ", ad_e_data2"
  	strSql = strSql & "  ) "
  	strSql = strSql & "  values("
  	strSql = strSql & "  "& board_idx &" "
  	strSql = strSql & ",'"& o_code &"'"
  	strSql = strSql & ",'"& m_id &"'"
  	strSql = strSql & ",'"& ad_b_p_custom &"'"
  	strSql = strSql & ",'"& ad_b_y_custom &"'"
  	strSql = strSql & ",'"& ad_g_p_gamang &"'"
  	strSql = strSql & ",'"& ad_g_y_gamang &"'"
  	strSql = strSql & ",'"& ad_i_y_emp &"'"
  	strSql = strSql & ",'"& ad_k_p_result &"'"
  	strSql = strSql & ",'"& ad_k_y_result &"'"
  	strSql = strSql & ",'"& ad_r_y_exact &"'"
  	strSql = strSql & ",'"& ad_e_notice2 &"'"
  	strSql = strSql & ",'"& ad_e_data2 &"'"
  	strSql = strSql & " )"
  else
  	strSql = " update emp_admin set "
  	strSql = strSql & "  ad_b_p_custom			= '"& ad_b_p_custom &"' "   
  	strSql = strSql & ", ad_b_y_custom			= '"& ad_b_y_custom &"' "  
  	strSql = strSql & ", ad_g_p_gamang			= '"& ad_g_p_gamang &"' "  
  	strSql = strSql & ", ad_g_y_gamang			= '"& ad_g_y_gamang &"' "  
  	strSql = strSql & ", ad_i_y_emp				= '"& ad_i_y_emp &"' "  
  	strSql = strSql & ", ad_k_p_result			= '"& ad_k_p_result &"' "  
  	strSql = strSql & ", ad_k_y_result			= '"& ad_k_y_result &"' "  
  	strSql = strSql & ", ad_r_y_exact			= '"& ad_r_y_exact &"' "  
  	strSql = strSql & ", ad_e_notice2			= '"& ad_e_notice2 &"' "  
  	strSql = strSql & ", ad_e_data2				= '"& ad_e_data2 &"' "  
  	strSql = strSql & "  where m_id='"& m_id &"'"  
  end If
  'Response.write strSql
  set objRs=objCnn.Execute(strSql)  
  Alert_url " 사원 권한 설정이 등록/수정 되었습니다.","y_emp_admin_regist.asp?m_id="&m_id&"&m_name="&m_name
  %>

  %>