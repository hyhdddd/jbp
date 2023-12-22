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

  group_idx			= WORD_CHANGE(Request("group_idx1"),20)
  group_idx			= Split(group_idx,",")
  

  strSql = "select B.m_name, B.m_id, C.duty_name, D.position_name, E.dealer_name "
  strSql = strSql & "	from sms_group_emp A left outer  "
  strSql = strSql & "		join emp_list B ON A.emp_idx=B.m_idx "
  strSql = strSql & "		left join code_duty C ON B.m_duty=C.duty_code"
  strSql = strSql & "		left join code_position D ON B.m_position=D.position_code "
  strSql = strSql & "		left join dealer_info E ON B.m_dealer_code=E.dealer_code "  

  strSql = strSql & "		 where 1=1 "

  For i=0 To UBound(group_idx)
	   If i=0 Then 
		strSql = strSql & " and A.group_idx="& Trim(group_idx(i))   
	  Else		
		strSql = strSql & " or A.group_idx="& Trim(group_idx(i))    
	  End if
  Next
  
  Set objRs=objCnn.Execute(strSql) 

  %>
<script language="javascript">
<!--

  <%
  Do Until objRs.EOF
      	m_id			= objRs("m_id")
       	to_name			= objRs("m_name")
       	position_name	= objRs("position_name")
       	duty_name		= objRs("duty_name")
       	dealer_name		= objRs("dealer_name")
        	
       	job_position  = to_name&"_"&position_name&"_"&duty_name+"_("&dealer_name&")"
		
		'Response.write m_id&":"&job_position&"<br>"
  %>
  		window.opener.OnConditionAdded('<%=job_position%>','<%=m_id%>');
  <%
		objRs.movenext
  Loop
  
  %>
  self.close();
-->
</script>

	

