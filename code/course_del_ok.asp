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
  
  course_code		= WORD_CHANGE(Request("course_code"),20)

  strSql = " select * from customer_goods where g_code_course_idx='"&course_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then


	strSql = " select * from customer_gamang where c_m_course_idx='"&course_code&"'"
	Set objRs1=objCnn.Execute(strSql)

	If objRs1.eof Or objRs1.bof Then
		strSql ="delete code_course where course_code='"&course_code&"'"
		Set objRs=objCnn.Execute(strSql)	
	Else
	  	Alert_back " 삭제하고자 하는 코드를 사용하는 가망고객이 존재합니다. \n\n 가망고객관리에서 접수경로 바꾸신후 코드를 지워주시기 바랍니다."
		Response.end	
	End if
	Alert_url " 코드를 삭제했습니다.","course_list.asp"
  Else
  	Alert_back " 삭제하고자 하는 코드를 사용하는 고객이 존재합니다. \n\n 고객관리에서 접수경로 바꾸신후 코드를 지워주시기 바랍니다."
	Response.end
  End if  
  %>