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
  e_exact_idx		= WORD_CHANGE(Request("e_exact_idx"),20)

  strSql = "SELECT * FROM exact_list A left outer join dealer_info B ON A.s_dealer_code=B.dealer_code "
  strSql = strSql & " where A.e_exact_idx = " & e_exact_idx
  Set objRs=objCnn.Execute(strSql)

  dealer_com_no		= objRs("dealer_com_no")
  dealer_service1	= objRs("dealer_service1")
  dealer_service2	= objRs("dealer_service2")
  dealer_address	= objRs("dealer_address")
  dealer_bank_name	= objRs("dealer_bank_name")
  dealer_name		= objrs("dealer_name")
  e_writeday		= objRs("e_writeday")
  tax_chk			= objRs("tax_chk")
  charge_gita1		= money_chk(objRs("charge_gita1"))

  If tax_chk<>"Y" Then
	Alert "���ݰ�꼭�� ���ݰ�꼭 �׸��� '����' �׸� üũ�Ǿ� �־�� ����� �� �ֽ��ϴ�."
	Win_close()
	Response.End
  End if

  tax_price_n		= money_chk(objRs("tax_price_n"))+charge_gita1
  tax_gap			= Fix(tax_price_n*0.1)		
  tax_price_y		= CDbl(Fix(tax_price_n+tax_gap))

  goods_money_lenth	= Len(tax_price_n)
  goods_blank_length= 11-goods_money_lenth
  
  Dim goods_money1(11)
  goods_money1(0)  = "&nbsp;" 
  goods_money1(1)  = "&nbsp;" 
  goods_money1(2)  = "&nbsp;" 
  goods_money1(3)  = "&nbsp;" 
  goods_money1(4)  = "&nbsp;" 
  goods_money1(5)  = "&nbsp;" 
  goods_money1(6)  = "&nbsp;" 
  goods_money1(7)  = "&nbsp;" 
  goods_money1(8)  = "&nbsp;" 
  goods_money1(9)  = "&nbsp;" 
  goods_money1(10) = "&nbsp;" 

  j=1
  For i=goods_blank_length To 10
		goods_money1(i)=Mid(tax_price_n,j,1)
		j=j+1
  Next
  
  Dim tax_money1(10)
  tax_money1(0)  = "&nbsp;" 
  tax_money1(1)  = "&nbsp;" 
  tax_money1(2)  = "&nbsp;" 
  tax_money1(3)  = "&nbsp;" 
  tax_money1(4)  = "&nbsp;" 
  tax_money1(5)  = "&nbsp;" 
  tax_money1(6)  = "&nbsp;" 
  tax_money1(7)  = "&nbsp;" 
  tax_money1(8)  = "&nbsp;" 
  tax_money1(9)  = "&nbsp;" 

  j=1
  For i=10-Len(tax_gap) To 9
		tax_money1(i)=Mid(tax_gap,j,1)
		j=j+1
  Next  

  c_goods_money		= money_change(tax_add)
  c_tax_money		= money_change(tax_gap)
  c_sum_money		= money_change(tax_sum)  
  
  strSql = "select * from company_info where o_code='"& o_code &"'"  	
  set objRs=objCnn.Execute(strSql)
  		
  o_com_name		= objRs("o_com_name")				'ȸ�� ��
  o_office_no1		= objRs("o_office_no1")				'ȸ�� ����� ��ȣ1
  o_office_no2		= objRs("o_office_no2")				'ȸ�� ����� ��ȣ2
  o_office_no3		= objRs("o_office_no3")				'ȸ�� ����� ��ȣ3
  o_name			= objRs("o_name")					'ȸ�� ��ǥ�ڸ�
  o_address			= objRs("o_address")				'ȸ�� �ּ�
  o_type1			= objRs("o_type1")					'ȸ�� ����
  o_type2			= objRs("o_type2")					'ȸ�� ����
  o_dojang			= objRs("o_dojang")					'ȸ�� ����
 

  %>


<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script>
function dealer_edit(form_name) 
{
    var frm=eval("document.all."+form_name);
    
    if (frm.dealer_file1.value=="") 
    {
        alert("ȸ�� ������ �Է��� �ּ���!");
		frm.dealer_file1.focus();
		return;
    }
   frm.submit();
}

</script>

<body leftMargin="0" topMargin="0" marginwidth="0" marginheight="0">

<table width="800" border="0" cellpadding="0" cellspacing="0" align="center" id="board_table2">
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr height='30'>
			<td colspan='3' style="text-align:left;font-size:12px;">&nbsp;(���� �� 11ȣ ����)</td>
		</tr>
		<tr>
			<td colspan='3'>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:12px;">
				<tr height="40">
					<td align="center">
						<b><span class="red" style="font-size:16px;">��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</span></td>
					<td align="center">
						<b><span class="red">( ������ ������ ) </span></td>
					<td align="center">���ι�ȣ</td>
					<td align="center">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=e_exact_idx%> ȣ</td>
				</tr>
				</table>
		</tr>
		</tr>
			<td colspan='3'>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:12px;">
				<tr>
					<td align="center" width="3%" rowSpan="4"><br>��<br><br><br><br>��<br><br><br><br>��<br></td>
					<td align="center" width="10%">��&nbsp;��<br>��&nbsp;ȣ</td>
					<td height="40" colSpan="3">&nbsp;<B><%=dealer_com_no%></b></td>
					<td align="center" width="3%" rowSpan="4"><br>��<br><br>��<br><br>��<br><br>��<br><br>��<br></td>
					<td align="center" width="10%">��&nbsp;��<br>��&nbsp;ȣ</td>
					<td align="center" colSpan="3">&nbsp;<%=o_office_no1%>-<%=o_office_no2%>-<%=o_office_no3%></td>
				</tr>
				<tr>
					<td align="center" width="10%">��&nbsp;ȣ<br>(���θ�)</td>
					<td align="center"><%=dealer_name%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td align="center" width="3%">����</td>
					<td align="center"><%=dealer_bank_name%>&nbsp;&nbsp;&nbsp;&nbsp;(��)</td>
					<td align="center" width="10%">��&nbsp;ȣ<br>(���θ�)</td>
					<td align="center"><%=o_com_name%></td>
					<td align="center" width="3%">����</td>
					<td align="center"><%=o_name%>&nbsp;&nbsp;(��)</td>
				</tr>
				<tr height="30">
					<td align="center" width="10%">�����<br>��&nbsp;&nbsp;��</td>
					<td align="center" colSpan="3"><%=dealer_address%>&nbsp;&nbsp;</td>
					<td align="center" width="10%">�����<br>��&nbsp;&nbsp;��</td>
					<td colSpan="3" width="40%"><%=o_address%>&nbsp;&nbsp;</td>
				</tr>
				<tr height="30">
					<td align="center" width="10%">��&nbsp;��</td>
					<td align="center"><%=dealer_service1%>&nbsp;</td>
					<td align="center" width="3%">����</td>
					<td align="center"><%=dealer_service2%>&nbsp;</td>
					<td align="center" width="10%">��&nbsp;��</td>
					<td align="center"><%=o_type1%>&nbsp;</td>
					<td align="center" width="3%">����</td>
					<td align="center"><%=o_type2%>&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='3'>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:12px;"> 
				<tr height="30">
					<td align="center" colSpan="3" bgcolor="#f8ebf5">��&nbsp;&nbsp;��</td>
					<td align="center" colSpan="12" bgcolor="#f8ebf5">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��</td>
					<td align="center" colSpan="10" bgcolor="#f8ebf5">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td align="center" bgcolor="#f8ebf5">��&nbsp;��</td>
				</tr>
				<tr height="30">
					<td width="5%">��</td>
					<td width="5%">��</td>
					<td width="5%">��</td>
					<td width="6%">������</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">õ</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">õ</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">õ</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">õ</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td width="3%">��</td>
					<td align="center" rowSpan="2">&nbsp;&nbsp;</td>
				</tr>
				<tr height="30">
					<td align="center"><%=year(e_writeday)%></td>
					<td align="center"><%=month(e_writeday)%></td>
					<td align="center"><%=day(e_writeday)%></td>
					<td><%=goods_blank_length%></td>
					<td><%=goods_money1(0)%></td>
					<td><%=goods_money1(1)%></td>
					<td><%=goods_money1(2)%></td>
					<td><%=goods_money1(3)%></td>
					<td><%=goods_money1(4)%></td>
					<td><%=goods_money1(5)%></td>
					<td><%=goods_money1(6)%></td>
					<td><%=goods_money1(7)%></td>
					<td><%=goods_money1(8)%></td>
					<td><%=goods_money1(9)%></td>
					<td><%=goods_money1(10)%></td>
					<td><%=tax_money1(0)%></td>
					<td><%=tax_money1(1)%></td>
					<td><%=tax_money1(2)%></td>
					<td><%=tax_money1(3)%></td>
					<td><%=tax_money1(4)%></td>
					<td><%=tax_money1(5)%></td>
					<td><%=tax_money1(6)%></td>
					<td><%=tax_money1(7)%></td>
					<td><%=tax_money1(8)%></td>
					<td><%=tax_money1(9)%></td>
				</tr>
				</table>
			</td>
		</tr>	
		<tr>
			<td colspan='3'>
				<table width="100%" cellspacing="0" cellpadding="0" border="1" style="font-size:12px;">
				<tr height="30">
					<td width="4%" bgcolor="#f8ebf5">��</td>
					<td width="4%" bgcolor="#f8ebf5">��</td>
					<td width="20%" bgcolor="#f8ebf5">ǰ�� �� �԰�</td>
					<td width="10%" bgcolor="#f8ebf5">����</td>
					<td width="12%" bgcolor="#f8ebf5">�ܰ�</td>
					<td width="14%" bgcolor="#f8ebf5">���ް���</td>
					<td width="14%" bgcolor="#f8ebf5">����</td>
					<td width="10%" bgcolor="#f8ebf5">���</td>
				</tr>
				<tr height="30">
					<td align="center"><%=month(e_writeday)%>&nbsp;</td>
					<td align="center"><%=day(e_writeday)%>&nbsp;</td>
					<td align="left">��ġ ������&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right"><%=money_change(tax_price_n)%> &nbsp;</td>
					<td align="right"><%=tax_gap%>&nbsp;</td>
					<td align="left">&nbsp;</td>
				</tr>
				<tr height="30">
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="left">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="left">&nbsp;</td>
				</tr>
				<tr height="30">
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="left">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="left">&nbsp;</td>
				</tr>
				<tr height="30">
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="left">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td align="left">&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='3'>
				<table width="100%" cellspacing="0" cellpadding="0" border="1" style="font-size:12px;">
				<tr height="30">
					<td width="30%" align="center" bgcolor="#f8ebf5">�հ�ݾ�</td>
					<td width="13%" align="center">����</td>
					<td width="13%" align="center">��ǥ</td>
					<td width="13%" align="center">����</td>
					<td width="13%" align="center">�ܻ�̼���</td>
					<td rowSpan="2" width="18%" align="center">�� �ݾ���&nbsp;<b>����</b>��</td>
				</tr>
				<tr height='30'>
					<td width="30%" align="center"><b><%=money_change(tax_price_y)%> &nbsp;</b></td>
					<td width="13%" align="center"><img src="/images/tax/chak.gif" border="0" align='absmiddle'></td> 
					<td width="13%" align="center">&nbsp;&nbsp;</td>
					<td width="13%" align="center">&nbsp;&nbsp;</td>
					<td width="13%" align="center">&nbsp;&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>		
		<tr>	
			<td colspan='3'>
				<table width="100%" cellspacing="0" cellpadding="0" border="1">
				<tr height='30'>
					<td  align="left" style="text-align:left;font-size:12px;">22226-28131 96.2.27 ����</td>
					<td  align="right" style="text-align:right;font-size:12px;">182��x128�� �μ����Ư�� 34g/��</td>
				</tr>
				<tr height='30'>
					<td colspan="2"  style="text-align:left;font-size:12px;">�� �� ���ݰ�꼭�� �ΰ���ġ���� ����� �� 53�� �� 4�� �� �� 5�׿� ���Ͽ� ������ ���ڹ����� ����� ���Դϴ�.</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<script language="javascript">
<!--
	window.print();
-->
</script>