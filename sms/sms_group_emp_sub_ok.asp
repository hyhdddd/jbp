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

  group_idx			= WORD_CHANGE(Request("group_idx"),10)
  sms_idx			= WORD_CHANGE(Request("sms_idx"),10)
  
  '�׷��� 50�� ������ ����....

  strSql = " delete sms_group_emp where group_idx="&group_idx&" and sms_idx="&sms_idx&" "
  set objRs=objCnn.Execute(strSql)
  %>
  <script language="javascript">
  opener.document.location.reload();
  </script>
  <%
  Alert_url " ����� sms �׷쿡�� �����Ǿ����ϴ�.","sms_group_emp_sub.asp?group_idx="&group_idx
  %>
