  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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

  gaetong_idx			= WORD_CHANGE(request("gaetong_idx"),20)
  gaetong_name			= WORD_CHANGE(request("gaetong_name"),20)
  gaetong_color			= WORD_CHANGE(request("gaetong_color"),20)
  
  if gaetong_idx<>"" then  
	strSql = " update code_gaetong set "
	strSql = strSql & " gaetong_name = '"& gaetong_name &"'"
	strSql = strSql & ", gaetong_color = '"& gaetong_color &"'"
	strSql = strSql & " where gaetong_idx="&gaetong_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url "�������� �ڵ尡 ���� �Ǿ����ϴ�. ","gaetong_list.asp"
	Response.end
  else    
	strSql = "Select ISNULL(MAX(gaetong_idx)+1,1) from code_gaetong "
	set objRs=objCnn.Execute(strSql)
	gaetong_idx	= objRs(0)

	If Len(gaetong_idx)=1 Then
		gaetong_code="H00"&gaetong_idx
	ElseIf Len(gaetong_idx)=2 Then
		gaetong_code="H0"&gaetong_idx
	ElseIf Len(gaetong_idx)=3 Then
		gaetong_code="H"&gaetong_idx
	End If

	strSql =" select gaetong_code from code_gaetong "
	strSql = strSql & " where gaetong_code='"&gaetong_code&"'"
	set objRs=objCnn.Execute(strSql)
  
	if objRs.eof or objRs.bof then
	Else
		Alert_back "�������� �ڵ� �ߺ��Դϴ�.. \n\n �ٽ� �Է��� �ּ���! "
		response.End
	End if

	strSql = "INSERT INTO code_gaetong (gaetong_idx, gaetong_code, gaetong_color, gaetong_name, gaetong_order, "
	strSql = strSql & " gaetong_writeday) VALUES "
	strSql = strSql & " ("& gaetong_idx &",'"& gaetong_code &"', '"& gaetong_color &"',"
	strSql = strSql & " '" & gaetong_name & "',"& gaetong_idx &", getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "�������� �ڵ尡 ��ϵǾ����ϴ�.","gaetong_list.asp"
  %>