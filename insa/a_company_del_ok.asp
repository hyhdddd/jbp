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
 
  if ad_i_a_company="A" Then
  else
	Alert_back session_m_name&" ���� ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  dealer_code		= WORD_CHANGE(Request("dealer_code"),20)

  '�����ڵ�� ������ �� ����.
  If o_code=dealer_code Then
	Alert_back "�����ڵ�� ������ �� �����ϴ�."
  End If
  
  '����� �����ϸ� ������ �� ����.
  strSql = " select * from emp_list where m_dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		Alert_back " �����Ϸ��� ȸ�翡 �Ҽӵ� ������� �����մϴ�. \n\n �����ϱ� ���ؼ��� ����Ҽ��� ��� �ٲپ� �ּ���"
		Response.end
  End if

  '�ΰ�ŷ�ó�� ���ǰ� ������ ������ �� ����.
  strsql = " select count(*) from customer_goods where g_trans_out_dealer='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		custom_cnt = objRs(0)

		If custom_cnt>0 then
			Alert_back " �����ҷ��� �ŷ�ó�� ������(�ΰ�ŷ�ó)�� ("&custom_cnt&" ��) ���ǰ� �ֽ��ϴ�. \n\n �ΰ�ŷ�ó�� ���õ� ��� �������� ������ �ּž� ���� �����մϴ�."
			Response.End
		End if
  End if

  '�μ��ŷ�ó�� ���ǰ� ������ ������ �� ����.
  strsql = " select count(*) from customer_goods where g_trans_in_dealer='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		custom_cnt = objRs(0)

		If custom_cnt>0 then
			Alert_back " �����ҷ��� �ŷ�ó�� ������(�μ��ŷ�ó)�� ("&custom_cnt&" ��) ���ǰ� �ֽ��ϴ�. \n\n �μ��ŷ�ó�� ���õ� ��� �������� ������ �ּž� ���� �����մϴ�."
			Response.End
		End if
  End if

  '������� - ���곻�������� ���ǰ� ������ ������ �� ����.
  strsql = " select count(*) from exact_list where s_dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		custom_cnt = objRs(0)

		If custom_cnt>0 then
			Alert_back " �����ҷ��� �ŷ�ó�� ������� - ���곻�������� ("&custom_cnt&" ��) ���ǰ� �ֽ��ϴ�. \n\n ���곻�������� �ش� �ŷ�ó�� �����ϰų� ������ �ּž� �ڵ� ���� �����մϴ�."
			Response.end
		End if
		
  End if

  strSql ="delete dealer_info where dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url " �ڵ带 �����߽��ϴ�.","a_company_list.asp"

  %>