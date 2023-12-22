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

  position_idx		= WORD_CHANGE(request("position_idx"),20)
  position_code		= WORD_CHANGE(request("position_code"),20)
  position_name		= WORD_CHANGE(request("position_name"),20)
  
  if position_idx<>"" then  
	strSql = " update code_position set "
	strSql = strSql & " position_name = '"& position_name &"'"
	strSql = strSql & " where position_code='"&position_code&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "직책 코드가 수정 되었습니다. ","position_list.asp"
	Response.end
  else    

	strSql = "Select ISNULL(MAX(position_idx)+1,1) from code_position "
	set objRs=objCnn.Execute(strSql)
	position_idx	= objRs(0)

	If Len(position_idx)=1 Then
		position_code="P00"&position_idx
	ElseIf Len(position_idx)=2 Then
		position_code="P0"&position_idx
	ElseIf Len(position_idx)=3 Then
		position_code="P"&position_idx
	End If

	strSql =" select position_code from code_position "
	strSql = strSql & " where position_code='"&position_code&"'"
	set objRs=objCnn.Execute(strSql)
  
	if objRs.eof or objRs.bof then
	Else
		Alert_back "직책 코드 중복입니다.. \n\n 다시 입력해 주세요! "
		response.End
	End if
  
	strSql = "INSERT INTO code_position (position_idx, position_code, position_name, position_writeday) VALUES "
	strSql = strSql & " ("& position_idx &",'"& position_code &"','" & position_name & "', getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url " 직책 코드가 등록되었습니다.","position_list.asp"
  %>