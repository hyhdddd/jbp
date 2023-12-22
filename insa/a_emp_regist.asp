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

  if ad_i_a_emp="N" then
	Alert_url session_m_name &" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
 
  m_id				= WORD_CHANGE(request("m_id"),20)
  page				= WORD_CHANGE(request("page"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  board_idx			= WORD_CHANGE(Request("board_idx"),20)
  search_key		= WORD_CHANGE(request("search_key"),20)
  search_txt		= WORD_CHANGE(request("search_txt"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)

  	
  if m_id="" Then
	If chk="P" then
		strSql="select * from dealer_partner_info where board_idx='"&board_idx&"'"  	
		set objRs=objCnn.Execute(strSql)

		If objRs.eof Or objRs.eof Then
			Alert_back " 잘못된 접근 입니다."
			Reponse.end
		Else	
			board_idx			= objRs("board_idx")
			m_id				= objRs("m_id")
			m_name				= objRs("m_name")
			m_passwd			= Trim(objRs("m_passwd"))
			m_jumin1			= objRs("m_jumin1")
			m_jumin2			= objRs("m_jumin2")
			m_zipcode1			= objRs("m_zipcode1")
			m_zipcode2			= objRs("m_zipcode2")
			m_address			= objRs("m_address")
			m_email				= objRs("m_email")
			m_tel1				= objRs("m_tel1")
			m_tel2				= objRs("m_tel2")
			m_bigo				= objRs("m_bigo")
			m_bank_name			= objRs("dealer_bank_name")
			m_bank_cd			= objRs("dealer_bank_cd")
			m_bank_no			= objRs("dealer_bank_no")
		End if
	End if
  else
    strSql="select * from emp_list where m_id='"&m_id&"'"  	
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
		m_dealer_admin	= objRs("m_dealer_admin")
		m_in_date		= objRs("m_in_date")	  
		m_out_date		= objRs("m_out_date")
		m_pay_type		= objRs("m_pay_type")
		m_family_no		= objRs("m_family_no")
		all_decision	= objRs("all_decision")
		duty_decision	= objRs("duty_decision")
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

<script language="javascript">
<!--
	function a_emp_del(code)
	{
		ans=confirm("사용하고 있는 사원은 삭제가 되지 않습니다. \n\n 모든고객 유치 정보, 상담정보, 게시판글 등을 모두 지운후에 삭제가 가능합니다. \n\n 삭제 하시겠습니까? ");
		if(ans==true)
		{
			location.href="a_emp_regist_del_ok.asp?m_id="+code
		}
	}

	function conn_log(m_id)
	{
		NewWindow('/insa/a_emp_conn_log.asp?m_id='+m_id,'conn_log','700','600','yes');
	}

	function dealer_del(m_id,m_idx)
	{
		ans=confirm(" 담당에서 삭제 하시겠습니까?");
		
		if(ans==true)
		{
			location.href="/insa/a_emp_dealer_del_ok.asp?m_id="+m_id+"&m_idx="+m_idx;
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
		<div class="sub_title"><img src="/images/common/sub03_t02.gif"></div>

		<form action="a_emp_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_idx" value="<%=m_idx%>">				
		<input type="hidden" name="page" value="<%=page%>">								
		<input type="hidden" name="y_chk" value="X">				
		<input type="hidden" name="search_key" value="<%=search_key%>">				
		<input type="hidden" name="search_txt" value="<%=search_txt%>">				
		<input type="hidden" name="s_dealer_code" value="<%=s_dealer_code%>">				
		<input type="hidden" name="session_o_code" value="<%=o_code%>">				

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="board_table3">
		<tr height=25> 
			<th width="150">거래처</th>
			<td colspan='3'>                  			
				<select name="m_dealer_code" style="width:150px;">					
					<% 
					strSql = " select * from dealer_info  order by dealer_name asc"
					set objRs1=objCnn.Execute(strSql)
					
					Do until objRs1.EOF 
						dealer_code		= objRs1("dealer_code")
						dealer_name		= objRs1("dealer_name")
					%>
						<option value="<%=dealer_code%>"  <% if dealer_code=m_dealer_code then %> selected <% end if %>> <%=dealer_name%>
					<%
						objRs1.movenext
					Loop
					objRs1.close
					%>
				</select> 
				<input type="checkbox" name="m_dealer_admin" value="O" <% If m_dealer_admin="O" Then %> checked <% End If %>> 하부사장 권한설정 부여 <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('거래처 사원 권한설정 부여 - 이 항목은 거래처사원관리 메뉴에서 사원들의 정보를 수정할 수 있으며, \n\n거래처 사원들이 CMS메뉴를 사용할수 있게 하는 권한을 부여하는 권한을 가지게 됩니다.\n\n 거래처의 대표 에게만 부여 하여 주시기 바랍니다. ');">&nbsp;<span class='red'> ※하부점 사장일 경우 꼭 체크해주세요!!</span>
			</td>
		</tr>
		<tr height='30'> 
			<th>아이디</th>
			<td> 
				<input type="text" class="txtbox" name="m_id" size="16" maxlength="14"  value="<%=m_id%>" style="ime-mode:disabled">
			</td>                  		
			<th>성 명</th>
			<td> 
				<input type="text" class="txtbox" name="m_name" size="10" maxlength="20" value="<%=m_name%>">
				<input type="checkbox" name="all_decision" value="O" <% If all_decision="O" Then %> checked <% End If %>>총 결제권자
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('(사장권한) 총결제권을 선택하시면 업무일지등을 작성했을경우 본사 전체직원들의 업무일지등을 결재 할수 있습니다.');">
			</td>
		</tr>
		<tr height='30'> 
			<th>사원 비밀번호</th>
			<td colspan='3'> 
				<input type="password" name="m_passwd" class="txtbox" value="<%=m_passwd%>"size="20" maxlength="20"   style="ime-mode:disabled;">
			</td>
		</tr>
		<tr height='30'> 
			<th>주민등록번호</th>
			<td> 
				<input type="text" class="txtbox" name="m_jumin1"  value="<%=m_jumin1%>" size="6" maxlength="6"  style="ime-mode:disabled;"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_emp_regist','m_jumin2'); fncNextFocus(this,6,'frm_emp_regist','m_jumin2');">- 
				<input type="text" class="txtbox" name="m_jumin2" value="<%=m_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_emp_regist','m_duty'); fncNextFocus(this,7,'frm_emp_regist','m_duty');">       
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
					<option value="<%=duty_code%>"  <% if m_duty=duty_code then %> selected <% end if %>> <%=duty_name%> </option>
					<%
						objRs1.movenext
					Loop
					objRs1.close
					%>
				</select> 
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('부서코드는 코드관리 - 부서코드관리 메뉴에서 등록/수정 할수 있습니다.');">&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="duty_decision" value="O" <% If duty_decision="O" Then %> checked <% End If %>> 부서 결제권자
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('(팀장권한) 부서 결제권을 선택하시면 업무일지등을 작성했을경우 부서 직원들의 업무일지등을 결재 할수 있습니다.');">
			</td>
		</tr>
		<tr height='30'> 
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
					<option value="<%=position_code%>"  <% if m_position=position_code then %> selected <% end if %> ><%=position_name%> </option>
					<%
						objRs1.movenext
					loop
					%>
				</select>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('직책코드는 코드관리 - 직책코드관리 메뉴에서 등록/수정 할수 있습니다.');">
			</td>
		</tr>                
		<tr height='30'> 
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
					<option value="<%=bank_board_idx%>" <% if Cint(bank_board_idx)=m_bank_cd then %> selected <% end if %>><%=bank_name%></option>
					<%
						objRs1.movenext
					Loop
					%></option>
				</select>&nbsp;&nbsp;
				계좌번호 <input type="text" class="txtbox" name="m_bank_no" value="<%=m_bank_no%>" size="20" maxlength="20" style="ime-mode:disabled;"  OnKeyUp="fncOnlyNumber(this); fncReplaceCheck(this,'-'); EnterNextFocus('frm_emp_regist','m_bank_name');" onBlur="BlurColor(this)">
				<font color="#FF3300">'-'빼고 입력</font>&nbsp;&nbsp; 예금주 
				<input type="text" class="txtbox" name="m_bank_name" value="<%=m_bank_name%>"  size="12" onBlur="BlurColor(this)" onKeyUp="EnterNextFocus('frm_emp_regist','m_htel1');">
			</td>
		</tr>
		<tr height='30'> 
			<th>주 소(우편번호)</th>
			<td colspan="3"> 
				<input  type="text" class="input" size="6" maxlength="6" id="m_zipcode1" name="m_zipcode1" readonly value="<%=m_zipcode1%>">
				<input class="input" type="text" size="50" maxlength="60" id="m_address" name="m_address"  value="<%=m_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('m_zipcode1','m_address');">
			</td>
		</tr>
		<tr height='30'> 
			<th>연락처</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel1" size="20" value="<%=m_tel1%>" style="ime-mode:disabled"  OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
			</td>			
			<th>휴대폰</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel2" size="20" value="<%=m_tel2%>" style="ime-mode:disabled"  OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
			</td>			
		</tr>
		<tr height='30'> 
			<th>E-Mail</th>
			<td colspan="3"> 
				<input type="text" class="txtbox"  name="m_email" size="60" style="ime-mode:disabled;"  value="<%=m_email%>"  onKeyUp="EnterNextFocus('frm_emp_regist','m_login_ip');">
			</td>			
		</tr>
		<tr height='30'> 
			<th>로그인 IP</th>
			<td colspan="3"> 
				<input type="text" class="txtbox" name="m_login_ip" size="30"  style="ime-mode:disabled;"  value="<%=m_login_ip%>"  onFocus="FocusColor(this);this.select();"> <span class='red'> 입력 형식 : 123.123.123.123 </span>
				&nbsp;<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('아이피를 입력하면 입력된 아이피로만 로그인이 가능합니다. \n\n 모든곳에서 로그인이 가능하게 할려면 값을 비워두시면 됩니다.');">
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
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=m_in_date&code2=&code3=&form_name=frm_emp_regist','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
			</td>
			<th> 퇴사일</th>
			<td>
				<input class="txtbox" type="text" name="m_out_date" size='10' readonly value="<%=m_out_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=m_out_date&code2=&code3=&form_name=frm_emp_regist','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
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
				<textarea wrap="hard" rows="3" name="m_bigo" cols="100" class="txtbox" onBlur="BlurColor(this)"><%=m_bigo%></textarea>
			</td>
		</tr>				
		</table>

		<div class="button"> 
			<a href ="/insa/a_emp_list.asp?page=<%=page%>&s_dealer_code=<%=s_dealer_code%>&nowblock=<%=nowblock%>&search_key=<%=search_key%>&search_txt=<%=search_txt%>"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a>

			<% if m_idx="" then %>
				<% if ad_i_a_emp="W" or ad_i_a_emp="E" or ad_i_a_emp="A" then %>
					<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_emp_regist();" onMouseOver="this.style.cursor='hand';">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 사원 등록권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0" align="absmiddle"></a> 
				<% end if %>						
			<% Else	%>
				<% if ad_i_a_emp="E" or ad_i_a_emp="A" then %>
					<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_emp_regist();" onMouseOver="this.style.cursor='hand';">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 사원 수정권한이 없습니다. 관리자에 문의하시기 바랍니다.");'><img src="/images/button/btn_save.gif" border="0" align="absmiddle"></a> 
				<% end if %>

				<span onclick="NewWindow('/sms/sms_batch_regist.asp?sms_chk=insa&m_id=<%=m_id%>','sms_group_add','340','450','no');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_sms.gif" align="absmiddle"></span>

				<% if session_m_step="M" then %>
					<img src="/images/button/btn_delete.gif" border=0 align="absmiddle" onclick="a_emp_del('<%=m_id%>');" onMouseOver="this.style.cursor='hand';">
					<a href="/insa/a_emp_admin_regist.asp?m_id=<%=m_id%>&m_name=<%=m_name%>"><img src="/images/button/btn_right_set.gif" border="0" align="absmiddle"></a>
					<img src="/images/button/btn_conn_log.gif" border=0 align='absmiddle' onclick="conn_log('<%=m_id%>');" onMouseOver="this.style.cursor='hand';">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 마스터 권한이 없습니다. 관리자에 문의하시기 바랍니다.");'><img src="/images/button/btn_right_set.gif" border="0" align="absmiddle"></a> 
				<% end if %>
			<% end if %>	 
		</div>				

		

		<% If m_id<>"" Then %>
		<table width="100%" border="0" cellspacing="1" cellpadding="0"  id="board_table2">
		<tr height='30'>
			<td colspan='3' style="text-align:left;">&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;담당 업체 목록 <span class='red'>(* 고객관리 메뉴에서 담당별 고객관리에서 사용됩니다.)</span> <span class='blue'>(권한설정 : 담당별 권한을 설정하세요) </span></td>
			<td style="text-align:right">
				<a href="a_emp_dealer_regist.asp?m_id=<%=m_id%>"><img src="/images/button/btn_dealer_add.gif" border=0></a>
			</td>
		</tr>
		<tr>
			<td class='head'> NO </td>
			<td class='head'> 업체명 </td>
			<td class='head'> 등록일</td>
			<td class='head'> 삭제</td>
		</tr>
<%
  strSql = "select A.m_idx, B.dealer_name, A.m_writeday from emp_list_dealer A left outer "
  strSql = strSql & "	join dealer_info B On A.m_dealer_code=B.dealer_code "
  strSql = strSql & "		where A.m_id='"&m_id&"' "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  %>
		<tr height='30'>
			<td colspan='4'> 담당업체가 존재하지 않습니다. </td>
		</tr>
  <%
  Else
	i=1
	Do Until objRs.eof 
		m_idx			= objRs("m_idx")
		dealer_name		= objRs("dealer_name")
		m_writeday		= fnc_date_change(objRs("m_writeday"))
		
  %>
		<tr height='30'>
			<td> <%=i%> </td>
			<td> <%=dealer_name%> </td>
			<td> <%=m_writeday%> </td>
			<td> <img src="/images/button/btn_delete.gif" border=0 align="absmiddle" onclick="dealer_del('<%=m_id%>','<%=m_idx%>');" onMouseOver="this.style.cursor='hand';"> </td>
			
		</tr>
  <%
		i=i+1
		objRs.movenext
	Loop
  End If
  %>
		</table>
		<% End If %>

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
