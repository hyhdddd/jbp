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
	Alert "세금계산서는 세금계산서 항목중 '발행' 항목에 체크되어 있어야 출력할 수 있습니다."
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
  		
  o_com_name		= objRs("o_com_name")				'회사 명
  o_office_no1		= objRs("o_office_no1")				'회사 사업자 번호1
  o_office_no2		= objRs("o_office_no2")				'회사 사업자 번호2
  o_office_no3		= objRs("o_office_no3")				'회사 사업자 번호3
  o_name			= objRs("o_name")					'회사 대표자명
  o_address			= objRs("o_address")				'회사 주소
  o_type1			= objRs("o_type1")					'회사 업태
  o_type2			= objRs("o_type2")					'회사 종목
  o_dojang			= objRs("o_dojang")					'회사 직인
 

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
        alert("회사 직인을 입력해 주세요!");
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
			<td colspan='3' style="text-align:left;font-size:12px;">&nbsp;(별지 제 11호 서식)</td>
		</tr>
		<tr>
			<td colspan='3'>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:12px;">
				<tr height="40">
					<td align="center">
						<b><span class="red" style="font-size:16px;">세&nbsp;금&nbsp;계&nbsp;산&nbsp;서</span></td>
					<td align="center">
						<b><span class="red">( 공급자 보관용 ) </span></td>
					<td align="center">승인번호</td>
					<td align="center">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=e_exact_idx%> 호</td>
				</tr>
				</table>
		</tr>
		</tr>
			<td colspan='3'>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:12px;">
				<tr>
					<td align="center" width="3%" rowSpan="4"><br>공<br><br><br><br>급<br><br><br><br>자<br></td>
					<td align="center" width="10%">등&nbsp;록<br>번&nbsp;호</td>
					<td height="40" colSpan="3">&nbsp;<B><%=dealer_com_no%></b></td>
					<td align="center" width="3%" rowSpan="4"><br>공<br><br>급<br><br>받<br><br>는<br><br>자<br></td>
					<td align="center" width="10%">등&nbsp;록<br>번&nbsp;호</td>
					<td align="center" colSpan="3">&nbsp;<%=o_office_no1%>-<%=o_office_no2%>-<%=o_office_no3%></td>
				</tr>
				<tr>
					<td align="center" width="10%">상&nbsp;호<br>(법인명)</td>
					<td align="center"><%=dealer_name%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td align="center" width="3%">성명</td>
					<td align="center"><%=dealer_bank_name%>&nbsp;&nbsp;&nbsp;&nbsp;(인)</td>
					<td align="center" width="10%">상&nbsp;호<br>(법인명)</td>
					<td align="center"><%=o_com_name%></td>
					<td align="center" width="3%">성명</td>
					<td align="center"><%=o_name%>&nbsp;&nbsp;(인)</td>
				</tr>
				<tr height="30">
					<td align="center" width="10%">사업장<br>주&nbsp;&nbsp;소</td>
					<td align="center" colSpan="3"><%=dealer_address%>&nbsp;&nbsp;</td>
					<td align="center" width="10%">사업장<br>주&nbsp;&nbsp;소</td>
					<td colSpan="3" width="40%"><%=o_address%>&nbsp;&nbsp;</td>
				</tr>
				<tr height="30">
					<td align="center" width="10%">업&nbsp;태</td>
					<td align="center"><%=dealer_service1%>&nbsp;</td>
					<td align="center" width="3%">종목</td>
					<td align="center"><%=dealer_service2%>&nbsp;</td>
					<td align="center" width="10%">업&nbsp;태</td>
					<td align="center"><%=o_type1%>&nbsp;</td>
					<td align="center" width="3%">종목</td>
					<td align="center"><%=o_type2%>&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='3'>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-size:12px;"> 
				<tr height="30">
					<td align="center" colSpan="3" bgcolor="#f8ebf5">작&nbsp;&nbsp;성</td>
					<td align="center" colSpan="12" bgcolor="#f8ebf5">공&nbsp;&nbsp;급&nbsp;&nbsp;가&nbsp;&nbsp;액</td>
					<td align="center" colSpan="10" bgcolor="#f8ebf5">세&nbsp;&nbsp;&nbsp;&nbsp;액</td>
					<td align="center" bgcolor="#f8ebf5">비&nbsp;고</td>
				</tr>
				<tr height="30">
					<td width="5%">년</td>
					<td width="5%">월</td>
					<td width="5%">일</td>
					<td width="6%">공란수</td>
					<td width="3%">백</td>
					<td width="3%">십</td>
					<td width="3%">억</td>
					<td width="3%">천</td>
					<td width="3%">백</td>
					<td width="3%">십</td>
					<td width="3%">만</td>
					<td width="3%">천</td>
					<td width="3%">백</td>
					<td width="3%">십</td>
					<td width="3%">일</td>
					<td width="3%">십</td>
					<td width="3%">억</td>
					<td width="3%">천</td>
					<td width="3%">백</td>
					<td width="3%">십</td>
					<td width="3%">만</td>
					<td width="3%">천</td>
					<td width="3%">백</td>
					<td width="3%">십</td>
					<td width="3%">일</td>
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
					<td width="4%" bgcolor="#f8ebf5">월</td>
					<td width="4%" bgcolor="#f8ebf5">일</td>
					<td width="20%" bgcolor="#f8ebf5">품목 및 규격</td>
					<td width="10%" bgcolor="#f8ebf5">수량</td>
					<td width="12%" bgcolor="#f8ebf5">단가</td>
					<td width="14%" bgcolor="#f8ebf5">공급가액</td>
					<td width="14%" bgcolor="#f8ebf5">세액</td>
					<td width="10%" bgcolor="#f8ebf5">비고</td>
				</tr>
				<tr height="30">
					<td align="center"><%=month(e_writeday)%>&nbsp;</td>
					<td align="center"><%=day(e_writeday)%>&nbsp;</td>
					<td align="left">유치 수수료&nbsp;</td>
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
					<td width="30%" align="center" bgcolor="#f8ebf5">합계금액</td>
					<td width="13%" align="center">현금</td>
					<td width="13%" align="center">수표</td>
					<td width="13%" align="center">어음</td>
					<td width="13%" align="center">외상미수금</td>
					<td rowSpan="2" width="18%" align="center">이 금액을&nbsp;<b>영수</b>함</td>
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
					<td  align="left" style="text-align:left;font-size:12px;">22226-28131 96.2.27 개정</td>
					<td  align="right" style="text-align:right;font-size:12px;">182㎜x128㎜ 인쇄용지특급 34g/㎡</td>
				</tr>
				<tr height='30'>
					<td colspan="2"  style="text-align:left;font-size:12px;">※ 본 세금계산서는 부가가치세법 시행령 제 53조 제 4항 및 제 5항에 의하여 발행한 전자문서를 출력한 것입니다.</td>
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