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
  <%
  s_o_code			= WORD_CHANGE(Request("s_o_code"),20) 
  chk				= WORD_CHANGE(Request("chk"),20)
  s_sms_cnt			= WORD_CHANGE(Request("s_sms_cnt"),10)

  If chk="entersoft_admin" Then
    strSql = " update SMS_MESSAGE_CNT set s_message1=s_message1+"&s_sms_cnt&" where s_o_code='"&s_o_code&"'"
	Set objRs=objCnn.Execute(strSql)
  Else
	Alert_close "�߸��� ���� �Դϴ�."
  End If
  
  alert "������ �Ϸ�Ǿ����ϴ�."
  win_close
  Response.End 

  %>