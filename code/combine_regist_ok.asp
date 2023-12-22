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
  Response.AddHeader "X-Content-Type-Options", "no-sniff"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_c_code="N" then
	Alert_back session_m_name &"님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  combine_idx			= WORD_CHANGE(request("combine_idx"),20)
  combine_name			= WORD_CHANGE(request("combine_name"),20)
  combine_view			= WORD_CHANGE(request("combine_view"),20)
  article1_idx			= WORD_CHANGE(Request("article1_idx"),20)
  combine_order			= WORD_CHANGE(money_chk(Request("combine_order")),20)

  if combine_idx<>"" then  
	strSql = " update code_combine set "
	strSql = strSql &"  combine_name		= '"& combine_name &"' "
	strSql = strSql &", combine_view		= '"& combine_view &"' "
	strSql = strSql &", combine_order		=  "& combine_order &"  "
	strSql = strSql &"  where combine_idx	=  "& combine_idx &" "
	set objRs=objCnn.Execute(strSql)
  else   
	strSql = "Select ISNULL(MAX(combine_idx)+1,1) from code_combine "
	set objRs=objCnn.Execute(strSql)
	combine_idx	= objRs(0)

	strSql = "INSERT INTO code_combine (combine_idx, article1_idx, combine_view, combine_name, combine_order, combine_writeday) VALUES "
	strSql = strSql &" ("& combine_idx &","&article1_idx&", '"& combine_view &"','"& combine_name &"',"& combine_order &", getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "코드가 등록/수정 되었습니다.","combine_list.asp"
  DBClose()
  %>