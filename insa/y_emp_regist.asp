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

  if ad_i_y_emp="N" then
	Alert_url session_m_name &" 님은 거래처 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
 
  m_id		= WORD_CHANGE(request("m_id"),20)
  page		= WORD_CHANGE(request("page"),20)

 	
  strSql = " select m_dealer_code, m_dealer_admin from emp_list "
  strSql = strSql & " where m_id='"&session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code	= objRs("m_dealer_code")
	
  if m_id="" Then


  Else
	strSql = " select m_dealer_code, m_dealer_admin from emp_list "
	strSql = strSql & " where m_id='"&session_m_id&"'"
	Set objRs=objCnn.Execute(strSql)

	m_dealer_admin	= objRs("m_dealer_admin")  

    strSql="select * from emp_list where  m_dealer_code='"&m_dealer_code&"' and m_id='"&m_id&"' " 
	set objRs=objCnn.Execute(strSql)
  	
  	
	If objRs.eof Or objRs.eof Then
		Alert_back " 잘못된 접근 입니다."
		Reponse.end
	Else	
		m_idx			= objRs("m_idx")
		m_name			= objRs("m_name")
		m_dealer_code	= objRs("m_dealer_code")
		m_passwd		= objRs("m_passwd")
		m_jumin1		= objRs("m_jumin1")
		m_jumin2		= objRs("m_jumin2")
		m_zipcode1		= objRs("m_zipcode1")
		m_zipcode2		= objRs("m_zipcode2")
		m_address		= objRs("m_address")
		m_email			= objRs("m_email")
		m_login_ip		= objRs("m_login_ip")
		m_tel1			= objRs("m_tel1")
		m_tel2			= objRs("m_tel2")
		m_bigo			= objRs("m_bigo")
		m_duty			= objRs("m_duty")
		m_position		= objRs("m_position")
		m_bank_cd		= objRs("m_bank_cd")
		m_bank_no		= objRs("m_bank_no")
		m_bank_name		= objRs("m_bank_name")
		m_status		= objRs("m_status")
		m_in_date		= objRs("m_in_date")	  
		m_out_date		= objRs("m_out_date")
		m_pay_type		= objRs("m_pay_type")
	end if  	
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
		<div class="sub_title"><img src="/images/common/sub03_t01.gif"></div>
		
		<form action="y_emp_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_idx" value="<%=m_idx%>">				
		<input type="hidden" name="page" value="<%=page%>">				
		<input type="hidden" name="m_dealer_code" value="<%=m_dealer_code%>">
		<input type="hidden" name="y_chk" value="O">
		<table border="0" cellspacing="0" width="100%" cellpadding="0" id="board_table3">				                
		<tr height='30'> 
			<th width=150>아이디</th>
			<td width=250> 
				<input type="text" class="txtbox" name="m_id" size="16" maxlength="14"  value="<%=m_id%>" style="ime-mode:disabled">
			</td>                  		
			<th width=150>성 명</th>
			<td width=250> 
				<input type="text" class="txtbox" name="m_name" size="10" maxlength="20" value="<%=m_name%>">
			</td>
		</tr>
		<tr height='30'> 
			<th>사원 비밀번호</th>
			<td colspan='3'> 
				<input type="password" name="m_passwd" class="txtbox" value="<%=m_passwd%>" size="20" maxlength="20"   style="ime-mode:disabled;">
			</td>
		</tr>
		<tr height='30'> 
			<th>주민등록번호</th>
			<td> 
				<input type="text" class="txtbox" name="m_jumin1" class="txtbox" value="<%=m_jumin1%>" size="6" maxlength="6"  style="ime-mode:disabled;"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_emp_regist','m_jumin2'); fncNextFocus(this,6,'frm_emp_regist','m_jumin2');">- 
				<input type="password" class="txtbox" name="m_jumin2" value="<%=m_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_emp_regist','m_duty'); fncNextFocus(this,7,'frm_emp_regist','m_duty');">       
			</td>
			<th>부서 코드</th>
			<td> 
				<select name="m_duty" class="txtbox" style="width:100px;">
				<option value="0"  <% if m_duty="0" then %> selected <% end if %>> 선  택</option> 
				<% 
				strSql = " select * from code_duty order by duty_code asc"
				set objRs1=objCnn.Execute(strSql)
				
				Do until objRs1.EOF 
					duty_code	= objRs1("duty_code")
					duty_name	= objRs1("duty_name")
				%>
				<option value="<%=duty_code%>"  <% if m_duty=duty_code then %> selected <% end if %>> <%=duty_name%></option> 
				<%
					objRs1.movenext
				Loop
				objRs1.close
				%>
				</select> 
			</td>
		</tr>
		<tr> 
			<th>직위/직급</th>
			<td colspan='3'> 
				<select name="m_position" style="width:100px;">
				<option value="0" <% if m_position="0" then %> selected <% end if %>>선 택</option>
				<% 
				strSql = " select * from code_position order by position_code asc"
				set objRs1=objCnn.Execute(strSql)
				
				Do until objRs1.EOF 
					position_code		= objRs1("position_code")
					position_name		= objRs1("position_name")
				%>
				<option value="<%=position_code%>"  <% if m_position=position_code then %> selected <% end if %> ><%=position_name%> 
				<%
					objRs1.movenext
				loop
				%>
				</select>
			</td>
		</tr>                
		<tr> 
			<th>은행/계좌/예금주</th>
			<td colspan="3" >                     
				<select name="m_bank_cd" style="width:100px;">
				<option value="0" <% if bank_cd="0" then %> selected <% end if %>> 은행 선택</option> 
				<% 
				strSql= " select board_idx,bank_name from code_bank order by bank_name ASC"
				set objRs1=objCnn.Execute(strSql)

				Do until objRs1.EOF
					bank_board_idx	= objRs1(0)
					bank_name		= objRs1(1)
				%>                      							
				<option value="<%=bank_board_idx%>" <% if bank_board_idx=m_bank_cd then %> selected <% end if %>><%=bank_name%></option>
				<%
					objRs1.movenext
				Loop
				%>
				</select>&nbsp;&nbsp;
				계좌번호 <input type="text" class="txtbox" name="m_bank_no" value="<%=m_bank_no%>" size="20" maxlength="20" style="ime-mode:disabled;"  OnKeyUp="fncOnlyNumber(this); fncReplaceCheck(this,'-'); EnterNextFocus('frm_emp_regist','m_bank_name');" onBlur="BlurColor(this)">
				<font color="#FF3300">'-'빼고 입력</font>&nbsp;&nbsp; 예금주 
				<input type="text" class="txtbox" name="m_bank_name" value="<%=m_bank_name%>"  size="12" onBlur="BlurColor(this)" onKeyUp="EnterNextFocus('frm_emp_regist','m_htel1');">
			</td>
		</tr>
		<tr> 
			<th>주 소(우편번호)</th>
			<td colspan="3"> 
				<input  type="text" class="input" size="6" maxlength="6" id="m_zipcode1" name="m_zipcode1" readonly value="<%=m_zipcode1%>">
				<input class="input" type="text" size="50" maxlength="60" id="m_address" name="m_address"  value="<%=m_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('m_zipcode1','m_address');">
			</td>
		</tr>
		<tr> 
			<th>연락처</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel1" size="20" value="<%=m_tel1%>" style="ime-mode:disabled"  OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
			</td>			
			<th>휴대폰</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel2" size="20" value="<%=m_tel2%>" style="ime-mode:disabled"  OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
			</td>			
		</tr>
		<tr> 
			<th>E-Mail</th>
			<td colspan="3"> 
				<input type="text" class="txtbox"  name="m_email" size="60" style="ime-mode:disabled;"  value="<%=m_email%>"  onKeyUp="EnterNextFocus('frm_emp_regist','m_login_ip');">
			</td>			
		</tr>
		<tr> 
			<th>로그인 IP</th>
			<td colspan="3"> 
				<input type="text" class="txtbox" name="m_login_ip" size="30"  style="ime-mode:disabled;"  value="<%=m_login_ip%>"  onFocus="FocusColor(this);this.select();"> <font color='red'>(Ex)123.123.123.123) 입력하면 특정 아이피만 로그인 가능함.</font>				
			</td>			
		</tr>  
		<tr> 
			<th>급여 적용 타입 </th>
			<td colspan="3"> 
				<INPUT type=radio style="border-style:none;" value="A" name="m_pay_type" <% if m_pay_type="A" Or pay_type="" then %> checked <% end if %>>관리팀 &nbsp;&nbsp;&nbsp;
				<INPUT type=radio style="border-style:none;" value="B" name="m_pay_type" <% if m_pay_type="B" then %> checked <% end if %>>기술팀 &nbsp;&nbsp;&nbsp;
				<INPUT type=radio style="border-style:none;" value="C" name="m_pay_type" <% if m_pay_type="C" then %> checked <% end if %>>영업팀 (실적점수에 따른 급여)&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr> 
			<th> 입사일</th>
			<td>
				<input class="txtbox" type="text" name="m_in_date" size='10' readonly value="<%=m_in_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=m_in_date&code2=&code3=&form_name=frm_emp_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
			<th> 퇴사일</th>
			<td>
				<input class="txtbox" type="text" name="m_out_date" size='10' readonly value="<%=m_out_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=m_out_date&code2=&code3=&form_name=frm_emp_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>		
		</tr>		                		
		<tr> 
			<th>퇴직 여부</th>
			<td colspan="3"> 
				<INPUT type="radio" value="O" name="m_status" <% if m_status="O" Or m_status="" Or IsNull(m_status) then %> checked <% end if %>>
				종사자 
				<INPUT type="radio" value="X" name="m_status" <% if m_status="X" then %> checked <% end if %>>
				퇴사자
				&nbsp;<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('퇴사자로 선택된 사원은 로그인를 할 수 없습니다.');">
				</td>
		</tr>   
		<tr> 
			<th>기타사항</th>
			<td colspan="3"> 
				<textarea wrap="hard" rows="3" name="m_bigo" cols="100" class="txtbox" onBlur="BlurColor(this)"><%=m_bigo%></textarea>
			</td>
		</tr>
		</table>
		
		<div class="button">
			<a href ="/insa/y_emp_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a> 
			<% if m_idx="" then %>
				<% if ad_i_y_emp="W" or ad_i_y_emp="E" or ad_i_y_emp="A" then %>
					<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_emp_regist();" onmouseover="this.style.cursor='hand';">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 거래처 사원 등록권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0" align="absmiddle"></a> 
				<% end if %>						
			<% Else	%>
				<% if ad_i_y_emp="E" or ad_i_y_emp="A" then %>
					<img src="/images/button/btn_save.gif" alt="저장" border="0" align="absmiddle" onClick="send_emp_regist();" onmouseover="this.style.cursor='hand';">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 거래처 사원 수정권한이 없습니다. 관리자에 문의하시기 바랍니다.");'><img src="/images/button/btn_save.gif" alt="저장" border="0" align="absmiddle"></a> 
				<% end if %>
			<% end if %>	
			<% If m_dealer_admin="O" Then %>
			<a href="y_emp_admin_regist.asp?m_id=<%=m_id%>&m_name=<%=m_name%>"><img src="/images/button/btn_right_set.gif" border="0" align="absmiddle"></a>
			<% End If %>
		</div>
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



</body>
</html>