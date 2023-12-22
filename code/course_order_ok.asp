  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Response.Expires = 0
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
  end If
  
  course_idx		= WORD_CHANGE(Request("course_idx"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  course_order		= WORD_CHANGE(Request("course_order"),20)
  page				= WORD_CHANGE(Request("page"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(course_order),0) from code_course where course_order>"&course_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)


  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select course_idx from code_course where course_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		course_idx1	= objRs2(0)

		if course_idx1="0" or course_idx1="" then
  		else
  			strSql = "update code_course set course_order="&course_order&" where course_idx="&course_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_course set course_order="&sorting1&" where course_idx="&course_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(course_order),0) from code_course where course_order<"&course_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select course_idx from code_course where  course_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		course_idx1	= objRs2(0)

  		if course_idx1="0" or course_idx1="" then  		
  		else
	  		strSql = "update code_course set course_order="&course_order&" where course_idx="&course_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_course set course_order="&sorting1&" where course_idx="&course_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "course_list.asp?page="&page
  %>

