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
  if ad_i_a_company="N" then
	Alert_url session_m_name &" 님은 거래처등록 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
  
  board_idx			= WORD_CHANGE(request("board_idx"),20)
  
 
  strSql = " select * from dealer_partner_info where board_idx="&board_idx
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.bof Then
  Else
	dealer_name			= objRs("dealer_name")
	dealer_com_yn		= objRs("dealer_com_yn")
	dealer_com_no		= objRs("dealer_com_no")
'	dealer_bank_name	= objRs("dealer_bank_name")			' 은행 예금주
'	dealer_bank_cd		= CStr(objRs("dealer_bank_cd"))		' 은행 코드
'	dealer_bank_no		= objRs("dealer_bank_no")			' 은행 계좌번호
	dealer_zipcode1		= objRs("dealer_zipcode1")			' 회사 우편번호1
	dealer_zipcode2		= objRs("dealer_zipcode1")			' 회사 우편번호2
	dealer_address		= objRs("dealer_address")			' 회사 주소			

	board_idx			= objRs("board_idx")
	m_id				= objRs("m_id")
	m_name				= objRs("m_name")
	m_passwd			= Trim(objRs("m_passwd"))
'	m_jumin1			= objRs("m_jumin1")
'	m_jumin2			= objRs("m_jumin2")
	m_zipcode1			= objRs("m_zipcode1")
	m_zipcode2			= objRs("m_zipcode2")
	m_address			= objRs("m_address")
	m_email				= objRs("m_email")
	m_tel1				= objRs("m_tel1")
	m_tel2				= objRs("m_tel2")
	m_bigo				= objRs("m_bigo")
'	m_bank_name			= objRs("dealer_bank_name")
'	m_bank_cd			= objRs("dealer_bank_cd")
'	m_bank_no			= objRs("dealer_bank_no")
	dealer_tel1			= objRs("dealer_tel1")
	dealer_tel2			= objRs("dealer_tel2")
'	dealer_com_jumin	= m_jumin1&"-"&m_jumin2
  End if

 If dealer_com_yn="Y" Then
	business_chk1 = "checked"
 Else
	business_chk2 = "checked"
 End If


 if len(dealer_file1)>0 then
	filepath1="/file_data/"& o_code &"/partner_info/"	
 end If
 if len(dealer_file2)>0 Then
	filepath2="/file_data/"& o_code &"/partner_info/"	
end If
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
		<div class="sub_title"><img src="/images/common/sub03_t05.gif"></div>
		
		<form name="frm_dealer" Method="POST" action="y_partner_batch_ok.asp" ENCTYPE="MULTIPART/FORM-DATA">
		<input type="hidden" name="partner_idx" value="<%=board_idx%>">
		<input type="hidden" name="m_dealer_admin" value="O">

		<input type="hidden" name="m_idx" value="<%=m_idx%>">				
		<input type="hidden" name="page" value="<%=page%>">								
		<input type="hidden" name="y_chk" value="X">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
			<td colspan='4' class="description"> 
				* 회사와 거래하는 모든 거래처의 정보를 입력하는 페이지 입니다.  <br>
				* 거래처 정보는 '거래처 사원관리 , 고객 인수/인계처리 및 정산관리등에 사용될 수 있습니다. <br>
				<span class='red'>* 한번 저장된 거래처 코드/ID는 수정이 불가능 합니다. <br>
				* 거래처 정보를 정확히 입력하시고 저장하시기 바랍니다. <br></span>
			</td>
		</tr>
		<tr height="35"> 
			<td colspan='4'><img src="/images/common/partner_com_title.gif" align="absmiddle"></td>
		</tr>
		<tr height=30> 
			<th width="130">거래처 상호</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_name" maxlength="20" size="20"  value="<%=dealer_name%>"  maxlength="30">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio"  name="dealer_com_yn" value="Y" <%=business_chk1%>>사업자&nbsp;&nbsp;	
				<input type="radio"  name="dealer_com_yn" value="N" <%=business_chk2%>>개  인
			</td>
			<th width="130">거래 구분</th>
			<td width="370">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox"  name="dealer_insu" value="Y"  checked >협력점&nbsp;&nbsp;	
				<input type="checkbox"  name="dealer_ingea" value="Y">상부점
			</td>
		</tr>
		<tr height=25>
			<th width="130">사업자번호</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_com_no" maxlength="12" size="20" value="<%=dealer_com_no%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">&nbsp;
				<font color="blue">* 000-00-00000 </font>
			</td>
			<th> E-Mail </th>
			<Td> 
				<input type="text" name="dealer_email" class="txtbox" maxlength="30" size="20" style="ime-mode:disabled;" value="<%=m_email%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_service1');">
			</td>
		</tr>
		<tr>
			<th>업태</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_service1" maxlength="20" size="20" value="<%=dealer_service1%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_service2');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('회사 업태(최대8자)를 입력해 주는 란 입니다.');">		
			</td>
			<th>종목</th>
			<Td> 
				<input type="text" name="dealer_service2" class="txtbox" maxlength="20" size="20" value="<%=dealer_service2%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_bank_cd');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('회사 종목(최대8자)를 입력해 주는 란 입니다.');">
			</td>
		</tr>
		<tr> 
			<th>거래은행</th>
			<td>
				<select name="dealer_bank_cd" class="txtbox">
				<option value="0" <% if dealer_bank_cd="0" then %> selected <% end if %>> 은행 선택 
			<% 
			strSql= " select board_idx,bank_name from code_bank order by bank_name ASC"
			set objRs1=objCnn.Execute(strSql)

			Do until objRs1.EOF
				bank_board_idx	= objRs1(0)
				bank_name		= objRs1(1)
			%>                      							
				<option value="<%=bank_board_idx%>" <% if Cstr(bank_board_idx)=dealer_bank_cd then %> selected 
				<% end if %>><%=bank_name%></option>
			<%
				objRs1.movenext
			Loop
			%>
				</select>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('거래처 은행을 입력해 주는 란 입니다.');">
			</td>
			<th>계좌번호</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_bank_no" maxlength="20" size="20"  value="<%=dealer_bank_no%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_tel1');">&nbsp;
				<font color="blue">* 000-000-000000 </font>
			</td>
		</tr>
		
		<tr>
			<th> 대표전화 </th>
			<Td> 
				<input type="text" name="dealer_tel1" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel1%>" 
				OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_tel2');">&nbsp
				<font color="blue">* 02-000-0000 </font>
			</td>				
			<th> 팩스번호 </th>
			<Td> 
				<input type="text" name="dealer_tel2" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">&nbsp;
				<font color="blue">* 010-000-0000 </font>
			</td>
		</tr>
		<tr height=25>
			<th> 회사 주소</th>
			<td colspan='3' class="table_list2">
				<input  type="text" class="txtbox" size="6" maxlength="6" id="dealer_zipcode1" name="dealer_zipcode1" readonly value="<%=dealer_zipcode1%>">
				<input class="txtbox" type="text" size="70" maxlength="70" id="dealer_address" name="dealer_address" readonly value="<%=dealer_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('dealer_zipcode1','dealer_address');">
			</td>
		</tr>
		<tr> 
			<th>정산그룹설정</th>
			<td>
				<select name="dealer_group_code" class="txtbox">
				<option value="0" <% if dealer_group_code="0" then %> selected <% end if %>> 그룹 선택 
				<% 
				strSql= " select group_code,group_name from code_group order by group_name ASC"
				set objRs1=objCnn.Execute(strSql)

				Do until objRs1.EOF
					group_code		= objRs1(0)
					group_name		= objRs1(1)
				%>                      							
				<option value="<%=group_code%>" <% if dealer_group_code=group_code then %> selected <% end if %>><%=group_name%></option>
				<%
					objRs1.movenext
				Loop
				%>
				</select>
			</td>
			<th>  </th>
			<td>  </td>
		</tr>	
		<tr> 
			<th>첨부파일1</th>
			<td colspan='3'> 
				<input type="file" name="dealer_file1" size="62" class="txtbox" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(dealer_file1)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=dealer_file1%>&fpath=<%=filepath1%>"><%=dealer_file1%></a>
				<% End If %>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('거래처의 사업자 사본/통장 사본/주민등록증 사본 등을 저장할수 있습니다.(파일이름은 최대20자)');">
			</td>
		</tr>
		<tr> 
			<th>첨부 파일2</th>
			<td colspan='3'> 
				<input type="file" name="dealer_file2" size="62" class="txtbox" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(dealer_file2)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=dealer_file1%>&fpath=<%=filepath2%>"><%=dealer_file2%></a>
				<% End If %>

			</td>
		</tr>

		
		<tr>
			<td colspan='4' class='con2'><br>&nbsp;</td>
		</tr>
		<tr height="35"> 
			<td colspan='4'><img src="/images/common/total_staff_title.gif" align="absmiddle"></td>
		</tr>
		<tr height='30'> 
			<th class='con9'>아이디</th>
			<td> 
				<input type="text" class="txtbox" name="m_id" size="16" maxlength="14"  value="<%=m_id%>" style="ime-mode:disabled">				
			</td>
			<th>사원 비밀번호</th>
			<td> 
				<input type="password" name="m_passwd" class="txtbox" value="<%=m_passwd%>" size="20" maxlength="20"   style="ime-mode:disabled;">
			</td>
		</tr>
		<tr height='30'> 
			<th>성 명</th>
			<td> 
				<input type="text" class="txtbox" name="m_name" size="10" maxlength="20" value="<%=m_name%>">
			</td>
			<th></th>
			<td>  
			</td>
		</tr>
		<tr height='30'> 
			<th>부서 코드</th>
			<td> 
				<select name="m_duty" class="txtbox" style="width:100px;">
					<option value="0"  <% if m_duty="0" then %> selected <% end if %>> 선  택 
					<% 
					strSql = " select * from code_duty order by duty_code asc"
					set objRs1=objCnn.Execute(strSql)
					
					Do until objRs1.EOF 
						duty_code	= objRs1("duty_code")
						duty_name	= objRs1("duty_name")
					%>
						<option value="<%=duty_code%>"  <% if m_duty=duty_code then %> selected <% end if %>> 
						<%=duty_name%> 
					<%
						objRs1.movenext
					Loop
					objRs1.close
					%>
				</select> 
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('부서코드는 코드관리 - 부서코드관리 메뉴에서 등록/수정 할수 있습니다.');">&nbsp;&nbsp;&nbsp;				
			</td>
			<th>직위/직급</th>
			<td> 
				<select name="m_position" style="width:100px;">
					<option value="0" <% if m_position="0" then %> selected <% end if %>>선 택
					<% 
					strSql = " select * from code_position order by position_code asc"
					set objRs1=objCnn.Execute(strSql)
					
					Do until objRs1.EOF 
						position_code		= objRs1("position_code")
						position_name		= objRs1("position_name")
					%>
						<option value="<%=position_code%>"  <% if m_position=position_code then %> selected <% end if %> >
						<%=position_name%> 
					<%
						objRs1.movenext
					loop
					%>
				</select>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('직책코드는 코드관리 - 직책코드관리 메뉴에서 등록/수정 할수 있습니다.');">
			</td>
		</tr>              
		<tr height='30'> 
			<th>주 소(우편번호)</th>
			<td colspan="3"> 
				<input  type="text" class="txtbox" size="6" maxlength="6" id="m_zipcode1" name="m_zipcode1" readonly value="<%=m_zipcode1%>">
				<input class="txtbox" type="text" size="60" maxlength="60" id="m_address" name="m_address" readonly value="<%=m_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('m_zipcode1','m_address');">
			</td>
		</tr>
		<tr height='30'> 
			<th>연락처</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel1" size="20" value="<%=m_tel1%>" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_dealer','m_tel2');">
			</td>			
			<th>휴대폰</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel2" size="20" value="<%=m_tel2%>" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_dealer','m_email');">
			</td>			
		</tr>
		<tr height='30'> 
			<th>E-Mail</th>
			<td colspan="3"> 
				<input type="text" class="txtbox"  name="m_email" size="25" style="ime-mode:disabled;"  value="<%=m_email%>"  onKeyUp="EnterNextFocus('frm_dealer','m_login_ip');">
			</td>			
		</tr>
		<tr height='30'> 
			<th>로그인 IP</th>
			<td colspan="3"> 
				<input type="text" class="txtbox" name="m_login_ip" size="25"  style="ime-mode:disabled;"  value="<%=m_login_ip%>" > <span class='red'> 입력 형식 : 123.123.123.123 (로그인 IP를 등록해 놓으면 특정 컴퓨터에서만 접속이 됩니다.) </span>
				&nbsp;<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('IP 입력하면 입력된 IP 만 로그인이 가능합니다. \n\n 모든곳에서 로그인이 가능하게 할려면 IP 입력를 하지 마십시요!');">
			</td>			
		</tr>  
		<tr height='30'> 
			<th>급여 적용 타입 </th>
			<td colspan="3"> 
				<INPUT type=radio style="border-style:none;" value="A" name="m_pay_type" <% if m_pay_type="A" Or pay_type="" then %> checked <% end if %>>관리팀 &nbsp;&nbsp;&nbsp;
				<INPUT type=radio style="border-style:none;" value="B" name="m_pay_type" <% if m_pay_type="B" then %> checked <% end if %>>기술팀 &nbsp;&nbsp;&nbsp;
				<INPUT type=radio style="border-style:none;" value="C" name="m_pay_type" <% if m_pay_type="C" then %> checked <% end if %>>영업팀 (실적점수에 따른 급여)&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr height='30'> 
			<th> 입사일</th>
			<td>
				<input class="txtbox" type="text" name="m_in_date" size='10' readonly value="<%=m_in_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=m_in_date&code2=&code3=&form_name=frm_dealer','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
			</td>
			<th> 퇴사일</th>
			<td>
				<input class="txtbox" type="text" name="m_out_date" size='10' readonly value="<%=m_out_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=m_out_date&code2=&code3=&form_name=frm_dealer','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
			</td>		
		</tr>		                		
		<tr height='30'> 
			<th>퇴직 여부</th>
			<td> 
				<INPUT type="radio" value="O" name="m_status" <% if m_status="O" Or m_status="" Or IsNull(m_status) then %> checked <% end if %>>
				종사자 
				<INPUT type="radio" value="X" name="m_status" <% if m_status="X" then %> checked <% end if %>>
				퇴사자
				&nbsp;<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('퇴사자로 선택된 사원은 로그인를 할 수 없습니다.');">
				</td>
			<th>부양 가족수</th>
			<td> 
				<select name="m_family_no">
				<option value="1" <% If m_family_no="1" Then %> selected <% End If %>> 1명 </option>
				<option value="2" <% If m_family_no="2" Then %> selected <% End If %>> 2명 </option>
				<option value="3" <% If m_family_no="3" Then %> selected <% End If %>> 3명 </option>
				<option value="4" <% If m_family_no="4" Then %> selected <% End If %>> 4명 </option>
				<option value="5" <% If m_family_no="5" Then %> selected <% End If %>> 5명 </option>
				<option value="6" <% If m_family_no="6" Then %> selected <% End If %>> 6명 </option>
				<option value="7" <% If m_family_no="7" Then %> selected <% End If %>> 7명 </option>
				<option value="8" <% If m_family_no="8" Then %> selected <% End If %>> 8명 </option>
				<option value="9" <% If m_family_no="9" Then %> selected <% End If %>> 9명 </option>
			</td>
		</tr>   
		<tr height='30'> 
			<th>기타사항</th>
			<td colspan="3"> 
				<textarea wrap="hard" rows="3" name="m_bigo" cols="100" class="txtbox"><%=m_bigo%></textarea>
			</td>
		</tr>
		<tr height=30> 
			<td colspan='4' align='right'>
				<% if ad_i_a_company="W" or ad_i_a_company="E" or ad_i_a_company="A" then %>
					<a href ="y_partner_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a>
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>님은 거래처 등록권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_i_a_company="W" or ad_i_a_company="E" or ad_i_a_company="A" then %>
					<img src="/images/button/btn_save.gif" border=0 align="absmiddle" onclick="partner_dealer_all();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 거래처 등록권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %> 								
			</td>	
		</tr>
		</table>
		</form>
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

