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

  if ad_c_code="A" Then
  else
	Alert_back session_m_name &" ���� �ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  board_idx		= WORD_CHANGE(Request("board_idx"),20)
  message_chk	= "O"
  

  strSql = " select count(*) from customer_goods where (g_bank_cd="&board_idx&" or g_sp_bank_code="&board_idx&") "
  Set objRs=objCnn.Execute(strSql)
  
  
  If objRs(0)="0" Or objRs(0)=0  Then
  Else
	Message_txt1 = "������ ("&objRs(0)&"��), "
	Message_chk = "X"
  End If
  
  strSql = " select count(*) from dealer_info where (dealer_bank_cd="&board_idx&") "
  Set objRs=objCnn.Execute(strSql)
  
  If objRs(0)="0" Or objRs(0)=0  Then
  Else
	Message_txt2 = "�ŷ�ó ���� ("&objRs(0)&"��), "
	Message_chk = "X"
  End If
    
  strSql = " select count(*) from dealer_partner_info where (dealer_bank_cd="&board_idx&") "
  Set objRs=objCnn.Execute(strSql)
  
  If objRs(0)="0" Or objRs(0)=0  Then
  Else
	Message_txt3 = "��Ʈ�� ��û ���� ("&objRs(0)&"��), "
	Message_chk = "X"
  End If

  strSql = " select count(*) from emp_list where (m_bank_cd="&board_idx&") "
  Set objRs=objCnn.Execute(strSql)
  
  If objRs(0)="0" Or objRs(0)=0  Then
  Else
	Message_txt4 = "������� ("&objRs(0)&"��)  "
	Message_chk = "X"
  End If  
  
  If Message_chk="X" Then
  	Alert_back Message_txt1 & " " & Message_txt2 & " " & Message_txt3 & " "& Message_txt4 &" ���� �ڵ带 ����ϰ� �����Ƿ� ������ �� �����ϴ�."
	Response.end
  Else

	strSql ="delete code_bank where board_idx="& board_idx &" "
	Set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ带 �����߽��ϴ�.","bank_list.asp"
  End if  
  %>