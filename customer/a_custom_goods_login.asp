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

  if ad_b_a_custom="N" And ad_b_m_custom="N" then
	Alert_URL session_m_name &" ���� ����ǰ ���������� �����ϴ�. �����ڿ��� �����Ͻñ� �ٶ��ϴ�.","/main.asp"
	Response.end
  End if

  g_goods_idx		= WORD_CHANGE(request("g_goods_idx"),20)
  dealer_code		= WORD_CHANGE(Request("dealer_code"),20)
  
  If dealer_code="" or IsNull(dealer_code) Or dealer_code="0"  Then
	Alert "������� ������ �ּ���!"
	win_close()
  End If
  
  strSql = " select dealer_name, dealer_ingea_url, dealer_ingea_id,dealer_ingea_passwd from dealer_info where dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)
	
  dealer_name		= objRs("dealer_name")
  dealer_ingea_url	= objRs("dealer_ingea_url")
  dealer_ingea_id	= objRs("dealer_ingea_id")
  dealer_ingea_passwd	= objRs("dealer_ingea_passwd")

  If dealer_ingea_url="" Or IsNull(dealer_ingea_url) Then
	Alert "����� ���� �������� ������ ��������("& dealer_name &")���� �Է��� �ּ���!"
	win_close()
  End if

  If dealer_ingea_id="" Or IsNull(dealer_ingea_id) Then
	Alert "����� ���� �Է� ID�� ������ ��������("& dealer_name &")���� �Է��� �ּ���!"
	win_close()
  End if

  If dealer_ingea_passwd="" Or IsNull(dealer_ingea_passwd) Then
	Alert "����� ���� �Է� �н����带 ������ ��������("& dealer_name &")���� �Է��� �ּ���!"
	win_close()
  End if

  %>



<form id="frm_trans" name="frm_trans" method="post" action="<%=dealer_ingea_url%>/include/asp/login_ok.asp">
<input type="hidden" name="m_id" value="<%=dealer_ingea_id%>">
<input type="hidden" name="m_passwd" value="<%=dealer_ingea_passwd%>">
</form>

<script language="javascript">
<!--
	var frm=document.all.frm_trans;
	frm.submit();
-->
</script>