  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
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
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if		

  policy_idx		= WORD_CHANGE(request("policy_idx"),20)
  article_idx1		= WORD_CHANGE(Request("s_article_idx1"),20)
  article_idx2		= WORD_CHANGE(Request("s_article_idx2"),20)

  strSql = " select * from code_service where  article_idx="& article_idx2 &" and service_view='Y' order by service_order asc "
  Set objRs = objcnn.Execute(strSql)
  
  strSql1	= ""
  Do Until objRs.eof
	service_idx		= objRs("service_idx")
	
	Request_val1	= "A"&service_idx
	service_charge	= money_chk(request(Request_val1))

	strSql = "select * from charge_buga where policy_idx="& policy_idx &" and g_article_idx2="& article_idx2 &" and service_idx="& service_idx 
	Set objRs2=objCnn.Execute(strSql)

	If objRs2.eof Or objRs2.bof Then
		strSql1 = strSql1 &" insert into charge_buga (policy_idx, g_article_idx2, service_idx, service_charge) "
		strSql1 = strSql1 &" values("& policy_idx &","& article_idx2 &","& service_idx &", "& service_charge &"); "
	Else
		strSql1 = stRSql1 &" update charge_buga Set service_charge	= "& service_charge &" "
		strSql1 = strSql1 &"	where policy_idx="& policy_idx &" and g_article_idx2="& article_idx2 &" and service_idx="& service_idx &"; "
	End if

	objRs.movenext
  loop
  
  'Response.write strSql1
  Set objRs = objcnn.Execute(strSql1)

  Alert_url "설정이 저장되었습니다.","charge_buga.asp?policy_idx="& policy_idx &"&s_article_idx1="&article_idx1&"&s_article_idx2="&article_idx2
  %>