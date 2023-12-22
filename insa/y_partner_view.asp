  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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

  board_idx		= WORD_CHANGE(Request("board_idx"),20)

  strSql="select * from dealer_partner_info where  board_idx='"&board_idx&"'"  	
  set objRs=objCnn.Execute(strSql)
  	
  If objRs.eof Or objRs.eof Then
	Alert_back " 잘못된 접근 입니다."
	Reponse.end
  Else	
	board_idx			= objRs("board_idx")
	m_id				= objRs("m_id")
	m_name				= objRs("m_name")
	m_passwd			= objRs("m_passwd")
	m_jumin1			= objRs("m_jumin1")
	m_jumin2			= objRs("m_jumin2")
	m_zipcode1			= objRs("m_zipcode1")
	m_zipcode2			= objRs("m_zipcode2")
	m_address			= objRs("m_address")
	m_email				= objRs("m_email")
	m_tel1				= objRs("m_tel1")
	m_tel2				= objRs("m_tel2")
	m_bigo				= objRs("m_bigo")

	dealer_name			= objRs("dealer_name")
	dealer_com_yn		= objRs("dealer_com_yn")
	dealer_com_no		= objRs("dealer_com_no")
	dealer_bank_name	= objRs("dealer_bank_name")
	dealer_bank_cd		= objRs("dealer_bank_cd")
	dealer_bank_no		= objRs("dealer_bank_no")
	dealer_zipcode1		= objRs("dealer_zipcode1")
	dealer_zipcode2		= objRs("dealer_zipcode2")
	dealer_address		= objRs("dealer_address")
	dealer_tel1			= objRs("dealer_tel1")
	dealer_tel2			= objRs("dealer_tel2")
  end if
  %>  	
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<% If https_chk="off" Then %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<% Else %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<% End If %>

<script language="javascript">
<!--
	function board_del(url1)
	{
		ans=confirm(" 파트너 신청을 삭제하시겠습니까?");
		if(ans==true)
		{
			location.href=url1;
		}
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub03_t04.gif"></div>
		<table border="0" cellspacing="0" width="100%" cellpadding="0" id="board_table3">			
		<tr height='30'> 
			<th width="150">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아이디</th>
			<td width="250"> 
				<input type="text" class="txtbox" name="m_id" size="16" maxlength="14"  value="<%=m_id%>" style="ime-mode:disabled"></td>                  		
			<th width="150">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 입력</th>
			<td width="250"> 
				<input type="text" name="m_passwd" class="txtbox" value="<%=m_passwd%>"size="15" maxlength="15"   style="ime-mode:disabled;">
			</td>
		</tr>
		<tr height='30'>
			<th>성 명</th>
			<td> 
				<input type="text" class="txtbox" name="m_name" size="10" maxlength="20" value="<%=m_name%>">
			</td>				
			<th>주민등록번호</th>
			<td> 
				<input type="text" class="txtbox" name="m_jumin1" class="txtbox" value="<%=m_jumin1%>" size="6" maxlength="6"  style="ime-mode:disabled;"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_emp_regist','m_jumin2'); fncNextFocus(this,6,'frm_emp_regist','m_jumin2');">- 
				<input type="text" class="txtbox" name="m_jumin2" value="<%=m_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_emp_regist','m_address'); fncNextFocus(this,7,'frm_emp_regist','m_address');">      
			</td>
		</tr>
		<tr height='30'> 
			<th>주 소(우편번호)</th>
			<td colspan="3"> 
				<input  type="text" class="txtbox" size="6" maxlength="6" id="m_zipcode1" name="m_zipcode1" readonly value="<%=m_zipcode1%>">
				<input class="txtbox" type="text" size="55" maxlength="60" id="m_address" name="m_address" value="<%=m_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('m_zipcode1','m_address');">				
			</td>
		</tr>
		<tr>
			<th> 연락처 </th>
			<Td> 
				<input type="text" name="m_tel1" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=m_tel1%>" 
				OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_emp_regist','m_tel2');">
			</td>				
			<th> 핸드폰 </th>
			<Td> 
				<input type="text" name="m_tel2" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=m_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
			</td>
		</tr>
		<tr height='30'> 
			<th>E-Mail</th>
			<td colspan="3"> 
				<input type="text" class="txtbox"  name="m_email" size="60" style="ime-mode:disabled;"  value="<%=m_email%>"  onKeyUp="EnterNextFocus('frm_emp_regist','dealer_name');">
			</td>			
		</tr>
		<tr height='30'> 
			<th colspan='4'>회사정보</th>
		</tr>
		<tr height=30> 
			<th> 회 사 명</th>
			<td colspan='3'>
				<input type="Text" class="txtbox" name="dealer_name" size="30"  value="<%=dealer_name%>"  maxlength="30" onKeyUp="EnterNextFocus('frm_emp_regist','dealer_bank_name');">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio"  name="dealer_com_yn" value="Y" checked>사업자&nbsp;&nbsp;	
				<input type="radio"  name="dealer_com_yn" value="N" <%=business_chk2%>>개  인
			</td>
			
		</tr>
		<tr height=25>							
			<th>대표자명</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_bank_name" size="30" value="<%=dealer_bank_name%>">		
			</td>
			<th>사업자번호</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_com_no" size="30" value="<%=dealer_com_no%>"></td>
		</tr>
		<tr height=25> 
			<th>거래은행</th>
			<td>
				<select name="dealer_bank_cd" class="txtbox">
				<option value="0" <% if dealer_bank_cd="0" then %> selected <% end if %>> 은행 선택</option> 
			<% 
			strSql= " select board_idx,bank_name from code_bank order by bank_name ASC"
			set objRs1=objCnn.Execute(strSql)

			Do until objRs1.EOF
				bank_board_idx	= objRs1(0)
				bank_name		= objRs1(1)
			%>                      							
			<option value="<%=bank_board_idx%>" <% if bank_board_idx=dealer_bank_cd then %> selected <% end if %>><%=bank_name%></option>
			<%
				objRs1.movenext
			Loop
			%>
		</select>
			</td>
			<th>계좌번호</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_bank_no" size="30"  value="<%=dealer_bank_no%>">		
			</td>
		</tr>
		<tr height=25>
			<th> 회사 주소</th>
			<td colspan='3' class="table_list2">
				<input  type="text" class="txtbox" size="6" maxlength="6" id="dealer_zipcode1" name="dealer_zipcode1" readonly value="<%=dealer_zipcode1%>">
				<input class="txtbox" type="text" size="55" maxlength="60" id="dealer_address" name="dealer_address" readonly value="<%=dealer_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('dealer_zipcode1','dealer_address');">	
			</td>
		</tr>
		<tr>
			<th> 대표전화 </th>
			<Td> 
				<input type="text" name="dealer_tel1" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel1%>" 
				OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_emp_regist','dealer_tel2');">
			</td>				
			<th> 팩스번호 </th>
			<Td> 
				<input type="text" name="dealer_tel2" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
			</td>
		</tr>
		<tr>
			<th>비고 </th>
			<td colspan='3'>
				<textarea class="txtbox" rows="3" name="m_bigo" cols="100"><%=m_bigo%></textarea>
			</td>
		</tr>
		</table>
		<div class="button">
			
			<a href ="y_partner_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a>
			<a href ="y_partner_batch.asp?board_idx=<%=board_idx%>"><img src="/images/button/btn_partner_info.gif" border=0 align="absmiddle"></a>
			<!--
			<a href="a_company_list.asp?chk=P&board_idx=<%=board_idx%>"><img src="/images/button/btn_partner_info.gif" border=0 align="absmiddle"></a>
			<a href="a_emp_regist.asp?chk=P&board_idx=<%=board_idx%>"><img src="/images/button/btn_partner_emp.gif" border=0 align="absmiddle"></a>-->
			<a href="javascript:board_del('y_partner_view_del.asp?board_idx=<%=board_idx%>');"><img src="/images/button/btn_delete.gif" border=0 align="absmiddle"></a>
		</div>
		<!------------------ 내용 종료  ------------------>		
	</td>		
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>



</body>
</html>
