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
 
  if ad_c_code="A" Then
  else
	Alert_back session_m_name &" 님은 개통정보 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  gaetong_idx		= WORD_CHANGE(Request("gaetong_idx"),20)

  strSql = " select gaetong_code from code_gaetong where gaetong_idx="&gaetong_idx
  Set objRs=objCnn.Execute(strSql)

  gaetong_code = objRs(0)


  strSql = " select * from customer_goods where g_code_gaetong_idx='"&gaetong_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_gaetong where gaetong_code='"&gaetong_code&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " 코드를 삭제했습니다.","gaetong_list.asp"
  Else
  	Alert_back " 삭제하고자 하는 코드를 사용하는 고객이 존재합니다. \n\n 고객관리에서 코드를 바꾸신후 코드를 지워주시기 바랍니다."
	Response.end
  End if  
  %>