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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  o_agree			= WORD_CHANGE(Request("o_agree"),0)					'파트너 신청 약관

  strSql = " update company_info set "
  strSql = strSql & "  o_agree			= '"& o_agree &"' "  
  strSql = strSql & "  where o_code = '"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url "파트너 가입 약관이 수정 되었습니다. ","/information/y_partner_agree.asp"
  %>