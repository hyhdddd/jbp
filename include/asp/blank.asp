<!--#include virtual="/include/asp/dbconnection.asp"-->
<!--#include virtual="/include/asp/config.asp"-->
<%
	'끊어지지 않는 세션 테스트
	c_m_id		= WORD_CHANGE(Request.Cookies("m_id1"),20)
	c_m_id		= Replace(c_m_id," ","")

	s_m_id		=  WORD_CHANGE(Request("s_m_id"),20)
	s_m_id		= Replace(s_m_id," ","")

	If s_m_id=c_m_id Then
		
		strSql = " select m_id, m_name, o_code, m_step from emp_list where m_id='"& s_m_id &"'"
		Set objRs=objCnn.Execute(strSql)

		If objRs.eof Or objRs.bof Then
			session("m_id")		= ""
		Else
			session("m_id")		= objRs("m_id")
		End If

		objRs.close

	End If

	s_m_id		= session("m_id")

%>
<html>
<head>
<meta http-equiv="refresh" content="600; URL=/include/asp/blank.asp?s_m_id=<%=s_m_id%>"> 
</head>
</html> 

