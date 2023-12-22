   <%
  '====================================='
  ' 프로젝트 : SENQ PROJECT
  ' 목    적 : HTTP://OSS.SENQ.CO.KR
  ' 개발일자 : 2007/08/15 ~2008/08/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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
		alert(" 사용가능한 아이디 입니다.");
		self.close();
	-->
	</script>
  <%
  Else
  %>
	<script language="javascript">
	<!--
		alert(" 입력하신 아이디는 사용하는 아이디 입니다. \n\n 다시 입력해 주세요!");
		opener.document.all.frm_emp_regist.m_id.value="";
		self.close();
	-->
	</script>	
  <%
  End if
  %>