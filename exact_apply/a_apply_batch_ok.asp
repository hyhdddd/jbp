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
  apply_idx			= WORD_CHANGE(request("apply_idx"),0)
  apply_status		= WORD_CHANGE(request("apply_status"),20)

  strSql = " update exact_apply set apply_status='"& apply_status &"' where apply_idx in ("& apply_idx &") "
  Set objRs=objCnn.Execute(strSql)

  Alert " ���� �������� �ϰ� ó�� �Ǿ����ϴ�."
  win_reload_modal()
  win_close_modal()
  %>

