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
  if ad_c_code<>"A" then
	Alert_back session_m_name &" 님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  
  position_code		= WORD_CHANGE(Request("position_code"),20)

  If position_code="" Then
	Alert_back " 잘못된 접근 입니다."
	Response.end
  End If
  
  strSql = " select * from emp_list where m_position='"&position_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_position where position_code='"&position_code&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " 코드를 삭제했습니다.","position_list.asp"
  Else
  	Alert_back " 삭제하고자 하는 코드를 사용하는 사원이 존재합니다. \n\n 사원관리에서 직책을 바꾸신후 코드를 지워주시기 바랍니다."
	Response.end
  End if  
  %>