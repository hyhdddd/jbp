  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
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
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <% 
  Login_chk(Session_m_id)
  
  black_chk			= WORD_CHANGE(Request("black_chk"),20)

  If black_chk="tel1" Then
	tel_num			= WORD_CHANGE(Request("tel_num"),20)
	strSql = " select * from customer_goods_black where black_tel1='"&tel_num&"'"  
	Set objRs=objCnn.execute(strSql)
  
  Else
	black_jumin1		= WORD_CHANGE(Request("black_jumin1"),20)
	black_jumin2		= WORD_CHANGE(Request("black_jumin2"),20)
    
	strSql = " select * from customer_goods_black where black_jumin1='"&black_jumin1&"' and black_jumin2='"&black_jumin2&"'"  
	Set objRs=objCnn.execute(strSql)
  End If
  

  %>
  <link rel="stylesheet" href="/include/css/style.css" type="text/css">
  <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

  <%
  If objRs.eof Or objRs.bof Then
  %>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<% If black_chk="tel1" Then %>
		<tr height=40> 
			<th>��ȭ��ȣ</th>
			<td><%=tel_num%></td>
		</tr>
		<% Else %>
		<tr height=40> 
			<th>�ֹι�ȣ</th>
			<td><%=black_jumin1%>-<%=black_jumin2%></td>
		</tr>
		<% End If %>
		<tr height=40> 
			<th>���</th>
			<td>�� û�������� ������ ���Դϴ�. </td>
		</tr>
		<tr height='40'>
			<td colspan='2' align='center'>
				<a href="javascript:close();"><img src="/images/button/btn_close.gif" border=0></a>
			</td>
		</tr>
		</table>
  <%
  Else
	black_jumin1		= objRs("black_jumin1")
	black_jumin2		= objRs("black_jumin2")
    
	black_name			= objRs("black_name")
	black_type			= objRs("black_type")
	black_bigo			= objRs("black_bigo")
	black_tel1			= objRs("black_tel1")
  %>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
  		<tr height=25> 
			<th width="130">����</th>
			<td width="870"><%=black_name%></td>	
		</tr>
		<tr height=30> 
			<th>�ֹι�ȣ</th>
			<td><%=black_jumin1%>-<%=black_jumin2%></td>
		</tr>
		<tr height=30> 
			<th>��ȭ��ȣ</th>
			<td><%=black_tel1%></td>
		</tr>
		<tr height=30> 
			<th>���</th>
			<td>
				<% If black_type="C" Then %>
					<b><span class='red'>&nbsp;�� �ҷ� �� </span></b> (û���� ���� �ʴ� ���Դϴ�.)
				<% End If %>

				<% If black_type="B" Then %>
					<b><span class='blue'>&nbsp;�� ��� �� </span></b> (û�� ������ �����մϴ�.)
				<% End If %>

				<% If black_type="A" Then %>
					<b><span class='blue'>&nbsp;�� ���� �� </span></b> (û�� ������ �����մϴ�.)
				<% End If %>
			</td>
		</tr>
		<tr height='30'>
			<th> ���� </th>
			<td>
				<%=black_bigo%></textarea>
			</td>
		</tr>
		<tr height='30'>
			<td colspan='2' align='center'>
				<a href="javascript:close();"><img src="/images/button/btn_close.gif" border=0></a>
			</td>
		</tr>
		</table>
  <% End If %>
