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
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  filename="����ǰ���(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  Login_chk(Session_m_id)

  if ad_b_p_excel<>"Y" then
 	Alert_URL session_m_name &" ���� �� �����ٿ� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	  
  
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  s_gaetong_code	= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2	= WORD_CHANGE(Request("s_article_idx2"),20)
  s_search_key		= WORD_CHANGE(Request("s_search_key"),20)
  s_option_idx		= WORD_CHANGE(Request("s_option_idx"),20)
  s_g_set			= WORD_CHANGE(Request("s_g_set"),20)
  s_date_start		= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end		= WORD_CHANGE(Request("s_date_end"),20)
  s_dealer_code1	= WORD_CHANGE(Request("s_dealer_code1"),20)
  s_receipt_chk		= WORD_CHANGE(Request("s_receipt_chk"),20)
  s_sp_give_type	= WORD_CHANGE(Request("s_sp_give_type"),20)

  If s_article_idx1="" Then	s_article_idx1="0"  End If
  If s_article_idx2="" Then	s_article_idx2="0"  End If
  If s_option_idx="" Then	s_option_idx="0"  End If
  If s_g_set=""		 Then		s_g_set="0"	  End If
  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">

<style type="text/css">
<!--  
	A:link    {color:#000000;text-decoration:none;}
	A:visited {color:#000000;text-decoration:none;}
	A:active  {color:#000000;text-decoration:none;}
	A:hover  {color:#8CC84B;text-decoration:none}

	body 
	{
		scrollbar-face-color: #ffffff; scrollbar-shadow-color: #666666; 
		scrollbar-highlight-color: #666666; scrollbar-3dlight-color: #ffffff; 
		scrollbar-darkshadow-color: #ffffff; scrollbar-track-color: #ffffff;
		scrollbar-arrow-color: #666666
	}
	td	{font: 9pt ����,GulimChe,Gulim;color: black;}
	
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

<!------------------ ���� ����  ------------------>


<TABLE width="2200" cellspacing=1 cellpadding=0 border=1>
<tr height='30'>
	<th bgcolor='gray' width="30">No</th>
	<th bgcolor='gray'  width="80">����</th>
	<th bgcolor='gray'  width="150">��ǰ��</th>
	<th bgcolor='gray'  width="150">��ǰ�ɼ�</th>
	<th bgcolor='gray'  width="80">��Ʈ����</th>
	<th bgcolor='gray'  width="80">����.��ȣ</th>
	<th bgcolor='gray'  width="150">������</th>
	<th bgcolor='gray'  width="80">����</th>
	<th bgcolor='gray'  width="80">�ΰ�����</th>
	<th bgcolor='gray'  width="80">�������</th>
	<th bgcolor='gray'  width="120">������</th>
	<th bgcolor='gray'  width="80">��ġ��</th>
	<th bgcolor='gray'  width="80">�������ǰ</th>
	<th bgcolor='gray'  width="100">�������ǰ�ݾ�</th>

	<th bgcolor='gray'  width="80">����ǰ</th>
	<th bgcolor='gray'  width="100">����ǰ ����ó</th>
	<th bgcolor='gray'  width="80">�ݾ�</th>
	<th bgcolor='gray'  width="80">���޿���</th>
	<th bgcolor='gray'  width="80">���޿Ϸ�</th>
	<th bgcolor='gray'  width="150">�ּ�</th>
	<th bgcolor='gray'  width="120">�ֹι�ȣ</th>
	<th bgcolor='gray'  width="80">����ó</th>
	<th bgcolor='gray'  width="80">����</th>
	<th bgcolor='gray'  width="80">���¹�ȣ</th>
	<th bgcolor='gray'  width="80">����ǰ ����</th>
	<th bgcolor='gray'  width="80">����ǰ ����</th>
	<th bgcolor='gray'  width="80">����ǰ ������</th>
	<th bgcolor='gray'  width="80">����ǰ ���� �޸�</th>
	<th bgcolor='gray'  width="200">��Ÿ</th>
	<th bgcolor='gray'  width="120">������</th>
</tr>
<%
if request("page")=""		then  page=1		Else page=Request("page")			end if
if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

strSql = " select A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_yuchi_m_id , A.g_date_yuchi,"
strSql = strSql & " A.g_date_gaetong, A.g_writeday, G.promise_name, H.sale_name, A.g_service_no, A.g_bigo, "
strSql = strSql & " A.g_sp_name, A.g_sp_price, A.g_sp_date_start, A.g_sp_date_end, A.c_address, A.c_jumin1, A.c_jumin2, "
strSql = strSql & " A.c_tel2, A.g_bank_cd, A.g_bank_no,  I.bank_name, J.option_name, A.g_set, "
strSql = strSql & " O.service_name, A.g_sp_bank_code, "
strSql = strSql & " A.g_sp_bank_acount, A.g_sp_bank_name, A.g_sp_bank_memo, F.bank_name as g_sp_bank, "
strSql = strSql & " B.m_name as yuchi_name, C.article_name , D.article_name as article_name1, A.g_sp_give_type, "
strSql = strSql & " E.gaetong_name, A.c_name,  A.g_sp_price_top, A.g_sp_name_top, "
strSql = strSql & " K.dealer_name as g_trans_out_dealer_name "
strSql = strSql & "		from customer_goods A left outer  "
strSql = strSql & " 		join emp_list B ON A.g_yuchi_m_id=B.m_id"
strSql = strSql & "	   left	join code_article C on A.g_article_idx1=C.article_idx"
strSql = strSql & "	   left	join code_article D on A.g_article_idx2=D.article_idx"
strSql = strSql & "	   left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
strSql = strSql & "	   left join code_bank F on A.g_sp_bank_code=F.board_idx "
strSql = strSql & "	   left join code_promise G on A.g_code_promise=G.promise_idx"
strSql = strSql & "	   left join code_sale H on A.g_code_sale=H.sale_idx"
strSql = strSql & "	   left join code_bank I on A.g_bank_cd=I.board_idx "
strSql = strSql & "    left join code_article_option J on A.g_option_idx=J.option_idx"
strSql = strSql & "	   left join dealer_info K ON A.g_trans_out_dealer=K.dealer_code"
strSql = strSql & "	   left join code_service O ON A.g_code_service=O.service_idx"
strSql = strSql & "				where (A.g_yuchi_m_id='"&session_m_id&"') "



  If s_receipt_chk="O" Then
		strSql = strSql & "			and (A.g_receipt_type='B' or A.g_receipt_type='C') "
  Else

	  If search_txt<>"" then
		If search_key="m_name" Then
			strSql = strSql & "		and (B.m_name like '%"&search_txt&"%')"
		Else
			strSql = strSql & "		and (A."&search_key&" like '%"&search_txt&"%') "
		End If
	  End If

	  If s_gaetong_code<>"" Then
		strSql = strSql & "			and (A.g_code_gaetong_idx='"& s_gaetong_code &"') "	
	  End If

	  If s_dealer_code<>"" then
		  strSql = strSql & "		and (A.g_trans_in_dealer='"&s_dealer_code&"')"
	  End If
	  
	  If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	  End if

	  If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	  End If
	  
	  If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	  End If

	  
	  If s_dealer_code1<>"" then
		strSql = strSql & "			and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
	  End If

	  If s_g_set<>"0" Then
		strSql = strSql & "			and (A.g_set='"&s_g_set & "') "
	  End If
	  	  
	  '����ǰ ���� ����
	  If s_sp_give_type<>"" then
		  strSql = strSql & "		and (A.g_sp_give_type='"&s_sp_give_type&"')"
	  End If

	  If s_search_key="g_date_yuchi" then	'��ġ�� �˻�
		strSql = strSql & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="g_date_gaetong" then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods1" then
		'����� �� ���޿���
		strSql = strSql & "			and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
		strSql = strSql & "			and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods2" Then
		'����� �� ���޿Ϸ�
		strSql = strSql & "			and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
		strSql = strSql & "			and (A.g_sp_date_end>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_end<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods3" Then
		'�̰���� �� ���޿���
		strSql = strSql & "			and ((A.g_date_gaetong is null) or (A.g_date_gaetong='')) "
		strSql = strSql & "			and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods4" Then
		'�̰���� �� ���޿Ϸ�
		strSql = strSql & "			and ((A.g_date_gaetong is null) or (A.g_date_gaetong='')) "
		strSql = strSql & "			and (A.g_sp_date_end>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_end<='"&s_date_end&" 23:59:59') "	
	  End If		  

  End if

  strSql = strSql & "				order by  A.receipt_order_p desc, A.g_date_yuchi Desc,g_goods_idx desc "
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
  paging_chk="X"
%>
<tr  height='30'>
	<td colspan='21'> �� ��ϻ�ǰ�� �����ϴ�. </td>
</td>
<%
  else
  i=1

  Do until objRs.EOF
	g_goods_idx			= objRs("g_goods_idx")
	g_yuchi_m_id		= objRs("g_yuchi_m_id")								'��ġ�� ���̵�
	g_date_yuchi		= fnc_date_change(objRs("g_date_yuchi"))			'������
	g_date_gaetong		= fnc_date_change(objRs("g_date_gaetong"))			'������
	yuchi_name			= objRs("yuchi_name")
	article_name		= objRs("article_name")
	article_name1		= objRs("article_name1")
	gaetong_name		= objRs("gaetong_name")								'���� ��Ȳ
	c_name				= objRs("c_name")									'����
	promise_name		= objRs("promise_name")								'��ǰ ����
	sale_name			= objRs("sale_name")								'������
	g_service_no		= objRs("g_service_no")								'���Լ��񽺹�ȣ
	g_trans_out_dealer_name	= objRs("g_trans_out_dealer_name")				'�ΰ�ŷ�ó

	g_sp_name			= objRs("g_sp_name")
	g_sp_price			= objRs("g_sp_price")
	g_sp_date_start		= objRs("g_sp_date_start")
	g_sp_date_end		= objRs("g_sp_date_end")
	c_address			= objRs("c_address")
	c_tel2				= objRs("c_tel2")
	g_bank_cd			= objRs("g_bank_cd")
	g_bank_no			= objRs("g_bank_no")
	bank_name			= objRs("bank_name")
	option_name			= objRs("option_name")
	c_jumin1			= objRs("c_jumin1")
	c_jumin2			= objRs("c_jumin2")
	g_set				= fnc_g_set(objRs("g_set"))							'��Ʈ����

	g_sp_give_type		= objRs("g_sp_give_type")							'����ǰ ����ó
	g_sp_give_type_txt	= fnc_g_sp_give_type(g_sp_give_type,"Y")


	g_sp_bank_acount	= objRs("g_sp_bank_acount")
	g_sp_bank_name		= objRs("g_sp_bank_name")
	g_sp_bank_memo		= objRs("g_sp_bank_memo")
	g_sp_bank			= objRs("g_sp_bank")	

	g_bigo				= objRs("g_bigo")
	service_name		= objRs("service_name")								'�ΰ����� 

	g_sp_name_top		= objRs("g_sp_name_top")							'�������ǰ��		
	g_sp_price_top		= money_change(objRs("g_sp_price_top"))				'�������ǰ �ݾ�

%>
<!--#include virtual="/include/asp/customer_marking.asp"-->
<tr  height='30'>
	<td> <%=i%> </td>
	<td><%=c_name%></td>
	<td><%=article_name%>_<%=article_name1%></td>
	<td><%=option_name%></td>
	<td><%=g_set%></td>
	<td style="mso-number-format:\@"><%=g_service_no%></td>
	<td><%=sale_name%></td>
	<td><%=promise_name%></td>
	<td><%=service_name%></td>
	<td><%=gaetong_name%></td>
	<td style="mso-number-format:\@"><%=g_date_gaetong%></td>
	<td><%=yuchi_name%></td>
	<td style="mso-number-format:\@"><%=g_sp_name_top%></td>
	<td><%=g_sp_price_top%></td>

	<td><%=g_sp_name%></td>
	<td><%=g_sp_give_type_txt%></td>
	<td><%=g_sp_price%></td>
	<td><%=g_sp_date_start%></td>
	<td><%=g_sp_date_end%></td>
	<td><%=c_address%></td>
	<td><%=c_jumin1%>-<%=c_jumin2%></td>
	<td style="mso-number-format:\@"><%=c_tel2%></td>
	<td><%=bank_name%></td>
	<td style="mso-number-format:\@"><%=g_bank_no%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank_acount%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank_name%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank_memo%></td>
	<td style="mso-number-format:\@"><%=g_bigo%></td>
	<td style="mso-number-format:\@"><%=g_date_yuchi%></td>

</tr>
<%
i=i+1
objRs.movenext
Loop
End If

objRs.close
objCnn.Close
Set objRs = Nothing
Set objCnn = Nothing
%>		  
</div>
</table>
	

       		