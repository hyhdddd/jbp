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

  area_idx			= WORD_CHANGE(request("area_idx"),20)
  area_name			= WORD_CHANGE(request("area_name"),20)
  area_view			= WORD_CHANGE(request("area_view"),20)
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  area_policy		= WORD_CHANGE(Request("area_policy"),20)
  
  if area_idx<>"" then  
    If area_policy="Y" Then
		strSql ="select count(area_idx) from code_area where article_idx="&article_idx&" "
		strSql = strSql & " and area_idx<>"&area_idx&" "
		Set objRs=objCnn.Execute(strSql)

		area_cnt	= objRs(0)

		If area_cnt>=10 Then
			area_msg =" �����ἳ�� ������ 10�� �̻��� ǥ�õ� �� ��� '��åǥ ������' ���� �����Ͽ����ϴ�."
			area_policy = "N"
		Else
			area_msg = ""
		End if
    End If
    
	strSql = " update code_area set "
	strSql = strSql & " area_name = '"& area_name &"'"
	strSql = strSql & ", area_view = '"& area_view &"'"
	strSql = strSql & ", area_policy = '"& area_policy &"'"
	strSql = strSql & " where area_idx="&area_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url "�ڵ尡 ���� �Ǿ����ϴ�. \n\n"& area_msg,"area_list.asp"
	Response.end
  else   
	strSql = "Select ISNULL(MAX(area_idx)+1,1) from code_area "
	set objRs=objCnn.Execute(strSql)
	area_idx	= objRs(0)

    If area_policy="Y" Then
		strSql ="select count(area_idx) from code_area where article_idx="&article_idx&" "
		Set objRs=objCnn.Execute(strSql)

		area_cnt	= objRs(0)

		If area_cnt>=10 Then
			area_msg =" �����ἳ�� ������ 10�� �̻��� ǥ�õ� �� ��� '��åǥ ������' ���� �����Ͽ����ϴ�."
			area_policy = "N"
		Else
			area_msg = ""
		End if
    End If	

	strSql = "INSERT INTO code_area (area_idx, article_idx, area_view, area_name, "
	strSql = strSql & " area_order, area_policy, area_writeday) VALUES "
	strSql = strSql & " ("& area_idx &","&article_idx&", '"& area_view &"',"
	strSql = strSql & " '" & area_name & "',"& area_idx &", '"&area_policy&"', getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "�ڵ尡 ��ϵǾ����ϴ�.\n\n"&area_msg,"area_list.asp"
  %>