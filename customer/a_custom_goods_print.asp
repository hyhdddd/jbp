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

  if ad_b_a_custom="N" And ad_b_g_custom="N" then
	Alert_URL session_m_name &" ���� ����ǰ ���������� �����ϴ�. �����ڿ��� �����Ͻñ� �ٶ��ϴ�.","/main.asp"
	Response.end
  End If
  
  g_goods_idx		= WORD_CHANGE(request("g_goods_idx"),20)			'�� ��ǰ ����

  If g_goods_idx<>"" Then
	strSql = " select A.g_goods_idx, A.c_name, A.c_type, A.c_jumin1, A.c_jumin2, A.c_tel1, A.c_tel2, A.c_tel3, "
	strSql = strsql & " A.c_office_no, A.c_zipcode1, A.c_zipcode2, A.c_address, A.c_email, "
	strSql = strSql & " A.g_sp_bank_code, A.g_sp_bank_acount, A.g_sp_bank_name, "
	strSql = strsql & " A.g_article_idx1, A.g_article_idx2, A.g_option_idx, A.c_jumin_date, "
	strSql = strSql & " A.g_yuchi_m_id , A.g_date_yuchi, A.g_date_gaetong, A.g_service_no, "
	strSql = strSql & " A.g_zipcode1, A.g_zipcode2, A.g_address, A.g_bigo, A.g_set, "
	strSql = strSql & " A.g_file1, A.g_file2, A.g_file3, A.g_file4, A.g_bank_cd, A.g_bank_no, A.g_bank_name, "
	strSql = strSql & " A.g_code_course_idx,  A.g_sp_date_start, A.g_sp_date_end, "
	strSql = strSql & " A.g_sum_money_chk, A.g_sum_money_txt, "
	strSql = strSql & " A.g_code_promise, A.g_sp_name, A.g_sp_price, A.g_cancel_date, "
	strSql = strSql & " A.g_writeday, B.m_name as yuchi_name, A.g_sp_give_type, "
	strsql = strSql & " A.g_give_type, A.g_card_cd, A.g_card_no, A.g_card_gigan , A.g_card_gigan1, A.g_date_gaetong_hope, "
	strSql = strSql & " C.article_name as article1_txt, D.bank_name, E.article_name as article2_txt, D.bank_name ,"
	strSql = strSql & " F.gaetong_name, A.g_bank_jumin1, A.g_bank_jumin2, M.card_name, J.service_name, "
	strSql = strSql & " G.course_name, H.promise_name, I.sale_name, "
	strSql = strSql & " K.option_name "
	strSql = strSql & "	from customer_goods A left outer  "
	strSql = strSql & " 		join emp_list B ON A.g_yuchi_m_id=B.m_id "
	strSql = strSql & "	   left join code_article C on A.g_article_idx1=C.article_idx "
	strSql = strSql & "	   left join code_bank  D on A.g_bank_cd=D.board_idx "
	strSql = strSql & "	   left join code_article E on A.g_article_idx2=E.article_idx"
    strSql = strSql & "	   left join code_gaetong F on A.g_code_gaetong_idx=F.gaetong_code"
    strSql = strSql & "	   left join code_course G on A.g_code_course_idx=G.course_code"
    strSql = strSql & "	   left join code_promise H on A.g_code_promise=H.promise_idx"
    strSql = strSql & "	   left join code_sale  I on A.g_code_sale=I.sale_idx"
    strSql = strSql & "	   left join code_service  J on A.g_code_service=J.service_idx"
    strSql = strSql & "	   left join code_article_option K on A.g_option_idx=K.option_idx"
	strSql = strSql & "	   left join code_card  M on A.g_card_cd=M.board_idx "
	strSql = strSql & "			where A.g_goods_idx="&g_goods_idx
	strSql = strSql & "					order by A.g_goods_idx Desc "
	Set objRs=objCnn.Execute(strSql)
		c_name				= objRs("c_name")					'����
		c_type				= objRs("c_type")					'�� Ÿ��
		c_jumin1			= objRs("c_jumin1")					'�� �ֹι�ȣ
		c_jumin2			= objRs("c_jumin2")					'�� �ֹι�ȣ
		c_tel1				= objRs("c_tel1")					'�ڵ���
		c_tel2				= objRs("c_tel2")					'�ڵ���
		c_tel3				= objRs("c_tel3")					'�ڵ���
		c_email				= objRs("c_email")					'�̸���
		c_office_no			= objRs("c_office_no")				'����� ��ȣ
		c_zipcode1			= objRs("c_zipcode1")				'�������ȣ
		c_zipcode2			= objRs("c_zipcode2")				'�������ȣ
		c_address			= objRs("c_address")				'���ּ�
		c_jumin_date		= objRs("c_jumin_date")				'�ֹι�ȣ �߱�����
		g_article_idx1		= objRs("g_article_idx1")			'��ǰ��
		g_date_yuchi		= Left(objRs("g_date_yuchi"),10)	'������
		g_zipcode1			= objRs("g_zipcode1")				'��ġ �ּ�
		g_zipcode2			= objRs("g_zipcode2")				'��ġ �ּ�
		g_address			= objRs("g_address")				'��ġ �ּ�
		g_bigo				= objRs("g_bigo")					'��ǰ ���
		g_set				= fnc_g_set(objRs("g_set"))			'��Ʈ����
		g_bank_cd			= objRs("g_bank_cd")				'�����ڵ�
		g_bank_no			= objRs("g_bank_no")				'���¹�ȣ
		g_bank_name			= objRs("g_bank_name")				'������
		bank_name			= objRs("bank_name")				'�����
		g_file1				= objRs("g_file1")		
		g_file2				= objRs("g_file2")
		g_file3				= objRs("g_file3")
		g_file4				= objRs("g_file4")
		yuchi_name			= objRs("yuchi_name")				'��ǰ ��ġ��
		article1_txt		= objRs("article1_txt")				'��ǰ ȸ���
		article2_txt		= objRs("article2_txt")				'��ǰ �̸�
		g_date_gaetong		= objRs("g_date_gaetong")			'��ǰ ������
		gaetong_name		= objRs("gaetong_name")				'��ǰ ���� ����
		g_option_idx		= objRs("g_option_idx")				'��ǰ �ɼ�	
		g_sp_name			= objRs("g_sp_name")				'����ǰ ��
		g_sp_date_start		= objRs("g_sp_date_start")			'����ǰ ��ۿ�����
		g_sp_date_end		= objRs("g_sp_date_end")			'����ǰ ��ۿϷ���
		g_sp_price			= objRs("g_sp_price")				'����ǰ �ݾ�
		course_name			= objRs("course_name")				'��ǰ �������
		promise_name		= objRs("promise_name")				'��ǰ ����
		sale_name			= objRs("sale_name")				'��ǰ ������

		g_give_type			= objRs("g_give_type")				'��������
		g_card_cd			= objRs("g_card_cd")				'ī���
		g_card_no			= objRs("g_card_no")				'ī���ȣ
		g_card_gigan		= objRs("g_card_gigan")				'ī�� ��ȿ�Ⱓ
		g_card_gigan1		= objRs("g_card_gigan1")			'ī�� ��ȿ�Ⱓ

		g_card_gigan		= g_card_gigan&"�� "&g_card_gigan1&"��"


		g_sp_give_type		= objRs("g_sp_give_type")			'����ǰ ���޹��(A/��ü���� , B/�������� , C/�ΰ輾������		
		g_date_gaetong_hope	= objRs("g_date_gaetong_hope")		'���������

		g_bank_jumin1		= objRs("g_bank_jumin1")			'��ü���� �ֹι�ȣ(����� �ٸ����)
		g_bank_jumin2		= objRs("g_bank_jumin2")			'��ü���� �ֹι�ȣ(����� �ٸ����)
		g_service_no		= objRs("g_service_no")				'���Լ��񽺹�ȣ
		option_name			= objRs("option_name")
		card_name			= objRs("card_name")
		service_name		= objRs("service_name")

		'����ǰ ��������
		g_sp_bank_code		= objRs("g_sp_bank_code")							'����ǰ ���� �����ڵ�
		g_sp_bank_acount	= objRs("g_sp_bank_acount")							'����ǰ ���� �������
		g_sp_bank_name		= objRs("g_sp_bank_name")							'����ǰ ���� ���࿹����

		g_sum_money_chk		= objRs("g_sum_money_chk")							'�ջ�û������
		g_sum_money_txt		= objRs("g_sum_money_txt")							'�ջ�û������

		g_bigo				= replace(g_bigo,chr(13) & chr(10),"<br>")

		'3���� �̻�� ������ ��ȣȭ �ϱ�
		'g_writeday			= fnc_date_change(objRs("g_writeday"))
		'g_writeday_old		= dateDiff("d",g_writeday, now)


		'If g_writeday_old>=30 Then 
		'	c_name				= left(c_name,2)&"*"
		'	c_jumin2			= left(c_jumin2,1)&"*******"
		'	c_address			= left(c_address,10)&" ***** " 
		'	g_bigo				= " ******** "

		'	If c_tel1<>"" Then 
		'	c_tel1				= left(c_tel1,3)&"-****-"&right(c_tel1,4)
		'	End If

		'	If c_tel2<>"" Then 
		'	c_tel2				= left(c_tel2,3)&"-****-"&right(c_tel2,4)
		'	End If

		'	if g_sp_bank_acount<>"" then
		'	g_sp_bank_acount	= left(g_sp_bank_acount,5)&" ***** "
		'	end if

		'	if give_jumin2<>"" then
		'	give_jumin2			= left(give_jumin2,1)&"*******"
		'	end if

		'	if give_no<>"" then 
		'	give_no				= left(give_no,5)&" ***** "
		'	end if
			
		'	if g_bank_no<>"" then 
		'	g_bank_no			= left(g_bank_no,5)&" ***** "
		'	end if

		'	if c_jumin_date<>"" then 
		'	c_jumin_date		= "*******"
		'	end if

		'	if g_address<>"" then 
		'	g_address			= left(g_address,10)&" *****"
		'	end if

		'	If g_card_no<>"" Then
		'	g_card_no			= "*******"	
		'	End If
			
		'	If g_bank_jumin2<>"" then
		'	g_bank_jumin2		= left(g_bank_jumin2,1)&"*******"
		'	End If
			
		'	If g_card_jumin2<>"" then
		'	g_card_jumin2		= left(g_card_jumin2,1)&"*******"
		'	End If

		'	If g_sp_bank_jumin2<>"" Then
		'	g_sp_bank_jumin2	= left(g_sp_bank_jumin2,1)&"*******"	
		'	End If
			
		'	If g_card_gigan<>"" Then
		'	g_card_gigan	= "**"	
		'	End If
			
		'	If g_card_gigan1<>"" Then
		'	g_card_gigan1	= "**"	
		'	End If
			
		'	If g_move_name<>"" Then
		'	g_move_name		= left(g_move_name,2)&"*"
		'	End If
			
		'	If g_move_tel1<>"" Then
		'	g_move_tel1		= left(g_move_tel1,3)&"-****-"&right(g_move_tel1,4)
		'	End If
			
		'	If g_move_tel2<>"" Then
		'	g_move_tel2		= left(g_move_tel2,3)&"-****-"&right(g_move_tel2,4)
		'	End if
			
		'	If g_move_jumin2<>"" then
		'	g_move_jumin2		= left(g_move_jumin2,1)&"*******"
		'	End If
			
		'End If
  End if
  %>
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />  
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body>
<div class="outerContainer_pop">
<!------------------ ���� ����  ------------------>
<div class="sub_title"><img src="/images/common/sub01_t01_01.gif"></div>
<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3" >
<tr height="30">
	<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;�� ���� </td>
</tr>
<tr height="30">
	<th width='130'>�� �� ��</th>
	<td width='270'><%=c_name%> </td>
	<th width='130'>�� ���� </th>
	<td width='270'>
		<% If c_type="C" Then %> ���� <% End If %>
		<% If c_type="O" Then %> ����� <% End If %>
		<% If c_type="F" Then %> �ܱ��� <% End If %></td>
</tr>
<tr>
	<th>�ֹι�ȣ</th>
	<td><%=c_jumin1%>-<%=c_jumin2%></td>
	<th>����ڹ�ȣ</th>
	<td><%=c_office_no%></td>
</tr>
<tr height="30">
	<th>��&nbsp;&nbsp;��</th>
	<td colspan='3'>(��:<%=c_zipcode1%>-<%=c_zipcode2%>) &nbsp;&nbsp;<%=c_address%></td>
</tr>
<tr height="30">
	<th>��ȭ��ȣ</th>
	<Td><%=c_tel1%></td>
	<th>�� �� ��</th>
	<Td><%=c_tel2%></td>
</tr>	
<tr height="30">
	<th>�� �� ��</th>
	<Td><%=c_email%></td>
	<th>�ֹ� �߱���</th>
	<Td><%=c_jumin_date%></td>	
</tr>
<tr height="30">
	<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ǰ ���� </td>
</tr>
<tr height="30">
	<th> ���Լ��񽺹�ȣ </th>
	<td><%=g_service_no%></td>
	<th>���� ����</th>
	<td><%=g_date_yuchi%></td>
</tr>

<tr height="30">
	<th> ���� ��ǰ  </th>
	<td colspan='3'> <%=article1_txt%>&nbsp;&nbsp;&nbsp;<%=article2_txt%>&nbsp;&nbsp;&nbsp;<%=option_name%> &nbsp;&nbsp;&nbsp;(��Ʈ:<%=g_set%>)</td>
</tr>
<tr height="30">
	<th> ��ǰ ���� </th>
	<Td><%=promise_name%></td>
	<th> �� �� �� </th>
	<Td><%=sale_name%></td>
</tr>
<tr>
	<th> �ΰ����� </th>
	<Td><%=service_name%></td>
	<th>�� �� �� </th>
	<td> <%=g_date_gaetong%><font color='red'>(<%=gaetong_name%>)</td>
</tr>
<tr height="30">
	<th> ��ġ��� </th>
	<td colspan='3'>(��:<%=g_zipcode1%>-<%=g_zipcode2%>) <%=g_address%></td>
</tr>
<tr>
	<th> �湮 ������ </th>
	<td><%=g_date_gaetong_hope%>&nbsp;&nbsp;<%=ii%>��
	<th>�ؾ����� </th>
	<td><%=g_cancel_date%></td>
</tr>	
<tr height="30">
	<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;���� ����</td>
</tr>
<tr height="30">						
	<th> ���� ���� </th>
	<Td colspan='3'>  
		<% If g_give_type="A" Then %>
			������ü
		<% ElseIf g_give_type="B" Then %>
			ī�峳��
		<% ElseIf g_give_type="C" Then %>
			���γ���
		<% ElseIf g_give_type="D" Then %>
			�ջ�û��
		<% End If %>
	</td>
</tr>	
<% If g_give_type="A" Then %>
<tr height="30"> 
	<th>�� �� ��</th>
	<td>(<%=bank_name%>)&nbsp;&nbsp; <%=g_bank_no%></td>
	<th>�� �� ��</th>
	<td><%=g_bank_name%>
		&nbsp;&nbsp;
		�ֹι�ȣ : <%=g_bank_jumin1%>-<%=g_bank_jumin2%>
	</td>
</tr>
<% End If %>

<% If g_give_type="B" Then %>
<tr height="30"> 
	<th>ī �� ��</th>
	<td>(<%=card_name%>)&nbsp;&nbsp; <%=g_card_no%></td>
	<th>ī����ȿ�Ⱓ</th>
	<td><%=g_card_gigan%></td>
</tr>
<% End If %>

<% If g_give_type="D" Then %>
<tr height="30"> 
	<th>�ջ� û��</th>
	<td>
		<% If g_sum_money_chk="A" Then %>
		��ȭ�� �ջ�
		<% End If %>

		<% If g_sum_money_chk="B" Then %>
		���ͳ� �ջ�
		<% End If %>

	</td>
	<th>�ջ� ���</th>
	<td><%=g_sum_money_txt%></td>
</tr>
<% End If %>
<tr height="30">
	<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;����ǰ ����</td>
</tr>
<tr height="30"> 
	<th> ����ǰ �� </th>
	<td><%=g_sp_name%></td>
	<th> ����ǰ �ݾ� </th>
	<td> <%=money_change(g_sp_price)%> ��</td>
</tr>
<tr height="30"> 
	<th> ����ǰ ���޿��� </th>
	<td><%=g_sp_date_start%></td>
	<th> ����ǰ ���޿Ϸ� </th>
	<td> <%=g_sp_date_end%>&nbsp;

	(����ó :
		<% If g_sp_give_type="A" Then %>
			��ġ������
		<% ElseIf g_sp_give_type="B" Then %>
			����������(��ü)
		<% ElseIf g_sp_give_type="C" Then %>
			����������(�ΰ�)
		<% ElseIf g_sp_give_type="D" Then %>
			��������
		<% End If %>)
	</td>
</tr>
<tr height="30">
	<th> ����ǰ ����</th>
	<td> 
		<%
		strSql = " select * from code_bank where board_idx="&g_sp_bank_code&" order by bank_name Asc"
		Set objRs=objCnn.Execute(strSql)
					
		if objRs.BOF or objRs.EOF Then
			bank_name			= "&nbsp;"
		else
			bank_name			= objRs("bank_name")
		End if
		%> 
		(<%=bank_name%>) &nbsp;&nbsp; <%=g_sp_bank_acount%>
	</td>
	<th> ������ </th>
	<td>
		<%=g_sp_bank_name%>
	</td>
</tr>
<tr height="60"> 
	<th>��Ÿ ����</th>
	<td colspan='3'><%=g_bigo%>
	</td>
</tr>		
</table>

<!------------------ ���� ����  ------------------>
</div> 
<script language="javascript">
<!--
	window.print();
-->
</script>