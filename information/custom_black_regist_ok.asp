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

  black_idx				= WORD_CHANGE(request("black_idx"),20)
  black_name			= WORD_CHANGE(request("black_name"),20)
  black_jumin1			= WORD_CHANGE(request("black_jumin1"),20)
  black_jumin2			= WORD_CHANGE(request("black_jumin2"),20)
  black_tel1			= WORD_CHANGE(request("black_tel1"),20)
  black_type			= WORD_CHANGE(request("black_type"),20)
  black_bigo			= WORD_CHANGE(request("black_bigo"),0)

  if black_idx<>"" then  
	strSql = " update customer_goods_black set "
	strSql = strSql & " black_name = '"& black_name &"'"
	strSql = strSql & ", black_jumin1 = '"& black_jumin1 &"'"
	strSql = strSql & ", black_jumin2 = '"& black_jumin2 &"'"
	strSql = strSql & ", black_tel1 = '"& black_tel1 &"'"
	strSql = strSql & ", black_type = '"& black_type &"'"
	strSql = strSql & ", black_bigo = '"& black_bigo &"'"
	strSql = strSql & " where black_idx="&black_idx&""
	set objRs=objCnn.Execute(strSql)

	Alert_url "������Ʈ ���� ���� �Ǿ����ϴ�. ","custom_black_list.asp"
	Response.end
  else    
    strSql = "select * from customer_goods_black where black_jumin1='"&black_jumin1&"' and black_jumin2='"&black_jumin2&"'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		strSql = "Select ISNULL(MAX(black_idx)+1,1) from customer_goods_black "
		set objRs=objCnn.Execute(strSql)
		black_idx		= objRs(0)

		strSql = "INSERT INTO customer_goods_black (black_idx, o_code, black_name, black_jumin1, black_jumin2, black_type, "
		strSql = strSql & " black_bigo, black_tel1, black_writeday) VALUES "
		strSql = strSql & " ("& black_idx &",'"& o_code &"','"& black_name &"',"
		strSql = strSql & " '" & black_jumin1 & "','" & black_jumin2 & "','" & black_type & "', '"&black_bigo&"','"&black_tel1&"', getdate())"
		set objRs=objCnn.Execute(strSql) 
	Else
		Alert_back "�ߺ��� ������Ʈ�� ���� �մϴ�."
	End if
  end if      

  Alert_url "������Ʈ ���� ��ϵǾ����ϴ�.","custom_black_list.asp"
  %>