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

  if session_m_step="M" Then
  else
 	Alert_URL session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
	Response.end
  end if	 

  board_idx				= WORD_CHANGE(request("board_idx"),20)
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)

  
  strSql = " delete customer_gaetong_log where board_idx="&board_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " �̷±��� ���� �Ǿ����ϴ�.","a_custom_goods_regist.asp?g_goods_idx="&g_goods_idx
  %>