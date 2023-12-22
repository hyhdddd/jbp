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
  if ad_c_code="N" then
	Alert_back session_m_name &" 님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  course_idx			= WORD_CHANGE(request("course_idx"),20)
  course_code			= WORD_CHANGE(request("course_code"),20)
  course_name			= WORD_CHANGE(request("course_name"),20)
  
  if course_idx<>"" then  
	strSql = " update code_course set "
	strSql = strSql & " course_name = '"& course_name &"'"
	strSql = strSql & " where course_code='"&course_code&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "접수경로 코드가 수정 되었습니다. ","course_list.asp"
	Response.end
  else   
  
  	strSql = "Select ISNULL(MAX(course_idx)+1,1) from code_course "
	set objRs=objCnn.Execute(strSql)
	course_idx	= objRs(0)

	If Len(course_idx)=1 Then
		course_code="H00"&course_idx
	ElseIf Len(course_idx)=2 Then
		course_code="H0"&course_idx
	ElseIf Len(course_idx)=3 Then
		course_code="H"&course_idx
	End If

	strSql =" select course_code from code_course "
	strSql = strSql & " where course_code='"&course_code&"'"
	set objRs=objCnn.Execute(strSql)
  
	if objRs.eof or objRs.bof then
	Else
		Alert_back "접수경로 코드 중복입니다.. \n\n 다시 입력해 주세요! "
		response.End
	End if

	strSql = "INSERT INTO code_course (course_idx, course_code, course_name, course_order, course_writeday) VALUES "
	strSql = strSql & " ("& course_idx &",'"& course_code &"','"& course_name &"', "& course_idx &" ,getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "접수경로 코드가 등록되었습니다.","course_list.asp"
  %>