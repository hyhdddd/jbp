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
 
  if ad_i_a_emp="A" Then
  else
	Alert_back session_m_name&" 님은 삭제 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  m_id		= WORD_CHANGE(Request("m_id"),20)

  '마스터 아이디는 삭제 불가능
  strSql = "select * from emp_list where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_id_chk = objRs("m_step")

  If m_id_chk="M" Then	
	  Alert_back "마스터 사원은 삭제할 수 없습니다."
	  Response.end
  End If
  
  '고객 유치 정보 체크
  strSql = " select * from customer_goods where g_yuchi_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "삭제하고자 하는 사원이 유치한 고객이 존재합니다. \n\n 고객 유치자를 바꾸신후 사원을 삭제해 주세요!"
		Response.end
  End If

  '사원 상담글 체크
  strSql = " select * from customer_goods_consult where consult_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "삭제하고자 하는 사원이 등록한 고객상담 글이 존재합니다. \n\n 고객 상담글을 삭제후  사원을 삭제해 주세요!"
		Response.end
  End If

  '게시판 글 체크
  strSql = " select * from board_data1 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "삭제하고자 하는 사원이 등록한 사내자료실 글이 존재합니다. \n\n 글을 삭제후  사원을 삭제해 주세요!"
		Response.end
  End If

  '게시판 글 체크
  strSql = " select * from board_data2 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "삭제하고자 하는 사원이 등록한 거래처 자료실 글이 존재합니다. \n\n 글을 삭제후  사원을 삭제해 주세요!"
		Response.end
  End If

  '게시판 글 체크
  strSql = " select * from board_notice1 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "삭제하고자 하는 사원이 등록한 사내 공지사항 글이 존재합니다. \n\n 글을 삭제후  사원을 삭제해 주세요!"
		Response.end
  End If

  '게시판 글 체크
  strSql = " select * from board_notice2 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "삭제하고자 하는 사원이 등록한 거래처 공지사항 글이 존재합니다. \n\n 글을 삭제후  사원을 삭제해 주세요!"
		Response.end
  End If

  '업무일지 , 급여관리 추가 체크 해야 함.

  'Response.write m_id
  'Response.End
  
  '사원정보 삭제
  strSql ="delete emp_list where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  '사원정보 권한 삭제
  strSql ="delete emp_admin where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 사원을 삭제했습니다.","a_emp_list.asp"

  %>