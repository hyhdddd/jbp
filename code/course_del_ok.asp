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
  if ad_c_code<>"A" then
	Alert_back session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
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
	  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� �������� �����մϴ�. \n\n �������������� ������� �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
		Response.end	
	End if
	Alert_url " �ڵ带 �����߽��ϴ�.","course_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� ���� �����մϴ�. \n\n ���������� ������� �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>