   <%
  '====================================='
  ' ������Ʈ : SENQ PROJECT
  ' ��    �� : HTTP://OSS.SENQ.CO.KR
  ' �������� : 2007/08/15 ~2008/08/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <%
  m_id		= WORD_CHANGE(Request("m_id"),20)

  strSql = " select * from emp_list where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  %>
	<script language="javascript">
	<!--
		opener.document.all.frm_emp_regist.id_chk.value="O";
		alert(" ��밡���� ���̵� �Դϴ�.");
		self.close();
	-->
	</script>
  <%
  Else
  %>
	<script language="javascript">
	<!--
		alert(" �Է��Ͻ� ���̵�� ����ϴ� ���̵� �Դϴ�. \n\n �ٽ� �Է��� �ּ���!");
		opener.document.all.frm_emp_regist.m_id.value="";
		self.close();
	-->
	</script>	
  <%
  End if
  %>