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
  gift_idx			= WORD_CHANGE(request("gift_idx"),0)
  gift_status		= WORD_CHANGE(request("gift_status"),20)

  strSql = " update board_gift set gift_status='"& gift_status &"' where gift_idx in ("& gift_idx &") "
  Set objRs=objCnn.Execute(strSql)

  Alert " ���� �������� �ϰ� ó�� �Ǿ����ϴ�."
  win_reload_modal()
  win_close_modal()
  %>

