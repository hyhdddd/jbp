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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  If session_m_step<>"M" Then 
	Alert_URL session_m_name &" ���� �ϰ����� ������ �����ϴ�. "
	Response.end
  End if

  g_charge_idx			= WORD_CHANGE(request("g_charge_idx"),0)
  s_link_txt			= WORD_CHANGE(request("s_link_txt"),0)								'�˻���
  g_charge_idx			= split(g_charge_idx,",")
  
 
  for i=0 to ubound(g_charge_idx)

		g_charge_idx1	= Trim(Mid(g_charge_idx(i),1,InstrRev(g_charge_idx(i),":")-1))
		g_goods_idx		= Mid(g_charge_idx(i),InstrRev(g_charge_idx(i),":")+1)
		
		g_goods_idx1	= g_goods_idx1 + g_goods_idx&","
  Next

  g_goods_idx1 = Left(g_goods_idx1, Len(g_goods_idx1)-1)
	

	'customer_goods
	strSql2 = strSql2 & " delete customer_goods "
	strSql2 = strSql2 & " where g_goods_idx in("&g_goods_idx1&")"
	Set objRs2=objCnn.Execute(strSql2)

	'customer_goods_consult
	strSql3 = strSql3 & " delete customer_goods_consult "
	strSql3 = strSql3 & " where g_goods_idx in("&g_goods_idx1&")"
	Set objRs3=objCnn.Execute(strSql3)

	'customer_goods_charge
	strSql4 = strSql4 & " delete customer_goods_charge "
	strSql4 = strSql4 & " where g_goods_idx in("&g_goods_idx1&")"
	Set objRs4=objCnn.Execute(strSql4)

	'customer_goods_charge
	strSql4 = strSql4 & " delete customer_goods_charge_g "
	strSql4 = strSql4 & " where g_goods_idx in("&g_goods_idx1&")"
	Set objRs4=objCnn.Execute(strSql4)

	'customer_gaetong_log
	strSql6 = strSql6 & " delete customer_gaetong_log "
	strSql6 = strSql6 & " where g_goods_idx in("&g_goods_idx1&")"
	Set objRs6=objCnn.Execute(strSql6)

  Alert_url " ���� �׸��� �ϰ����� �Ǿ����ϴ�.", "a_exact_list.asp?"&s_link_txt
  DBClose()
  %>

