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
  emp_idx			= WORD_CHANGE(Request("emp_idx"),10)
  page				= WORD_CHANGE(Request("page"),10)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),10)

  '�׷��� 50�� ������ ����....
  strSql = " select count(group_idx) from sms_group_emp where group_idx="&group_idx
  Set objRs=objCnn.Execute(strSql)    

  strSql = " select * from sms_group_emp where group_idx="&group_idx&" and emp_idx="&emp_idx&" "
  'response.write strSql
  Set objRs=objCnn.Execute(strSql)    

  If objRs.eof Or objRs.bof Then
  	strSql = "Select ISNULL(MAX(sms_idx)+1,1) from sms_group_emp "
	set objRs=objCnn.Execute(strSql)
	sms_idx			= objRs(0)


	strSql = " insert into sms_group_emp(sms_idx, o_code, group_idx, emp_idx) "
	strSql = strSql & " values("&sms_idx&", '"&o_code&"', "&group_idx&", "&emp_idx&")"
	set objRs=objCnn.Execute(strSql)
  %>
	<script language="javascript">
	opener.document.location.reload();
	</script>
  <%
	Alert_url " ����� sms �׷쿡 �߰��Ǿ����ϴ�.","sms_group_emp_add.asp?group_idx="&group_idx&"&page="&page&"&s_dealer_code="&s_dealer_code
  Else
	Alert_back " �̹� �߰��� ����Դϴ�."
  End if
  %>