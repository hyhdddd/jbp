  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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
  
  '그룹은 50명 까지만 가능....

  strSql = " delete sms_group_emp where group_idx="&group_idx&" and sms_idx="&sms_idx&" "
  set objRs=objCnn.Execute(strSql)
  %>
  <script language="javascript">
  opener.document.location.reload();
  </script>
  <%
  Alert_url " 사원이 sms 그룹에서 삭제되었습니다.","sms_group_emp_sub.asp?group_idx="&group_idx
  %>
