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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%  
  if ad_a_gift="N" then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	

  page				= WORD_CHANGE(Request("page"),20)
  nowblock			= WORD_CHANGE(Request("nowblock"),20)
  s_link_txt		= WORD_CHANGE(Request("s_link_txt"),0)
  gift_idx			= WORD_CHANGE(Request("gift_idx"),20)
  
  strSql = "delete board_gift where gift_idx="& gift_idx
  Set objRs = objCnn.Execute(strSql)

  strSql = "delete board_gift_bank where gift_idx="& gift_idx
  Set objRs = objCnn.Execute(strSql)

  Alert_url "�����Ͱ� �����Ǿ����ϴ�.","a_gift_list.asp?page="&page&"&nowblock="& nowblock &"&"&s_link_txt
  DBClose() 
  %>
