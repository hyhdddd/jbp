  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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

  group_idx				= WORD_CHANGE(request("group_idx"),20)
  group_name			= WORD_CHANGE(request("group_name"),20)
  
  if group_idx<>"" then  
	strSql = " update code_group set "
	strSql = strSql & " group_name = '"& group_name &"'"
	strSql = strSql & " where group_idx="&group_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url "�ڵ尡 ���� �Ǿ����ϴ�. ","group_list.asp"
	Response.end
  else  
  

	strSql = "Select ISNULL(MAX(group_idx)+1,1) from code_group "
	set objRs=objCnn.Execute(strSql)
	group_idx	= objRs(0)

	If Len(group_idx)=1 Then
		group_code="G00"&group_idx
	ElseIf Len(group_idx)=2 Then
		group_code="G0"&group_idx
	ElseIf Len(group_idx)=3 Then
		group_code="G"&group_idx
	End If

	strSql =" select group_code from code_group "
	strSql = strSql & " where group_code='"&group_code&"'"
	set objRs=objCnn.Execute(strSql)
  
	if objRs.eof or objRs.bof then
	Else
		Alert_back "�ڵ� �ߺ��Դϴ�.. \n\n �ٽ� �Է��� �ּ���! "
		response.End
	End if
  
	strSql = "INSERT INTO code_group (group_idx, group_code, group_name, group_use,group_writeday) VALUES "
	strSql = strSql & " ("& group_idx &",'"& group_code &"','" & group_name & "', 'Y',getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "�ڵ尡 ��ϵǾ����ϴ�.","group_list.asp"
  %>