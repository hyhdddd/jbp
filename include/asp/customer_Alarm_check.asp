  <% Session.CodePage = 949 %>
  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
  '====================================='
  Response.CharSet = "euc-kr"
  Response.AddHeader "Pragma","no-cache"
  Response.AddHeader "Expires","0"

  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/Config.asp"-->
  <%

  strSql = "select top 1 board_idx, alarm_chk, customer_name, m_name, goods_idx from customer_goods_alarm where alarm_chk='X' order by board_idx desc"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	Response.write "X"
	'customer_name	= "�־ȱ�"
	'm_name			= "�׽�Ʈ"
	'Response.write "����:"&customer_name&"<br>"&"�����:"&m_name&"<br>"&"�ð�:"&now()
  Else	
	board_idx		= objRs("board_idx")
	alarm_chk		= objRs("alarm_chk")
	customer_name	= objRs("customer_name")
	m_name			= objRs("m_name")
	goods_idx		= objRs("goods_idx")

  	'�űԵ�� �� ����
	If alarm_chk="X" Then 		
  %>

		<table width='100%' height="150" border=0 cellspacing="0" cellpadding="0" style="font-size:12px;border:1px solid c7c7c7;background:url(/images/common/alram_bg.gif);">
		<tr height='30'>
			<td colspan='2' align='center'><font color="ff8400"><b>�ű� ��� �� ����</b></font></td>
		</tr>
		<tr height='25'>
			<td width='100' align='center'>���� :</td>
			<td width='150'><a href="/customer/a_custom_goods_regist.asp?g_goods_idx=<%=goods_idx%>"><b><%=customer_name%></b></a></td>
		</tr>
		<tr height='25'>
			<td width='100' align='center'>����� :</td>
			<td width='150'><%=m_name%></td>
		</tr>
		<tr height='25'>
			<td colspan='2' align='center'>������ Ŭ���ϸ� �˸�â�� ������ϴ�.</td>
		</tr>
		<tr>
			<td colspan='2' align='right'><span onclick="Alarm_hidden();" onmouseover="this.style.cursor='hand'"><img src="/images/button/btn_colse2.gif"></span>
			<audio controls loop autoplay>
			<embed src="/images/wav/new_goods.wav" LOOP="0" AUTOSTERT="TRUE"  hidden="true"></embed></object>
			</td>
		</tr>		
		</table>
  <%
		strSql = "delete customer_goods_alarm where alarm_chk='O'"
		Set objRs=objCnn.Execute(strSql)
	End If
  End if
  %>
  