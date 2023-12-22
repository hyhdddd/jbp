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
  StartTimer = Timer()
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	    

  search_txt			= WORD_CHANGE(Request("search_txt"),20)
  search_key			= WORD_CHANGE(Request("search_key"),20)  
  s_dealer_code			= WORD_CHANGE(Request("s_dealer_code"),20)	' 선택된 거래처 
  s_dealer_code1		= WORD_CHANGE(Request("s_dealer_code1"),20)
  s_gaetong_code		= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("s_date_end"),20)
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
  s_set					= WORD_CHANGE(Request("s_set"),20)
  date_chk				= WORD_CHANGE(Request("date_chk"),20)
  s_group_code			= WORD_CHANGE(Request("s_group_code"),20)
  s_yuchi_m_id			= WORD_CHANGE(Request("s_yuchi_m_id"),20)
  list_cnt				= WORD_CHANGE(Request("list_cnt"),20)			'출력 갯수
  s_code_area			= WORD_CHANGE(money_chk(Request("s_code_area")),20)
  s_code_service		= WORD_CHANGE(Request("s_code_service"),20)
  g_goods_idx_chk		= WORD_CHANGE(Request("g_goods_idx"),20)

  If list_cnt="" Then	list_cnt="30"  End If

  If date_chk=""		Then	date_chk="0"			End If  
  If s_code_area=""		Then	s_code_area="0"			End If  
 
  If date_chk="0" Then
  	s_date_start=""
	s_date_end=""
  End If

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  s_link_txt ="search_key="& search_key &"&search_txt="& search_txt &"&s_gaetong_code="& s_gaetong_code &"&s_dealer_code="& s_dealer_code 
  s_link_txt = s_link_txt &"&date_chk="& date_chk &"&s_date_start="& s_date_start &"&s_date_end="& s_date_end &"&s_article_idx1="& s_article_idx1 
  s_link_txt = s_link_txt &"&s_article_idx2="& s_article_idx2 &"&s_option_idx="& s_option_idx &"&s_set="& s_set 
  s_link_txt = s_link_txt &"&s_dealer_code1="& s_dealer_code1 &"&s_group_code="& s_group_code &"&list_cnt="& list_cnt &"&s_yuchi_m_id="& s_yuchi_m_id 
  s_link_txt = s_link_txt &"&s_code_area="& s_code_area &"&s_code_service="& s_code_service
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/include/js/custom_goods.asp"></SCRIPT>
<SCRIPT type="text/javascript" src="/include/js/emp_select.asp"></SCRIPT>
<SCRIPT type="text/javascript" src="/include/js/group_change.asp"></SCRIPT>
<SCRIPT type="text/javascript" src="/include/js/area_change.asp"></SCRIPT>
<SCRIPT type="text/javascript" src="/include/js/service_change.asp"></SCRIPT>
<script type="text/javascript">

function toggle_img(src)
{
	var allchecked=document.getElementById("allcheck").value;

	var charge_idx = document.getElementsByName("g_charge_idx")
	
	if(allchecked==0)
	{
		document.getElementById('allcheck').value="1";
		document.getElementById('toggle_img1').src = "/images/button/cancel.gif";
		document.getElementById('toggle_img2').src = "/images/button/cancel.gif";
		
		for( var i=0; i<charge_idx.length; i++) 
			{
				charge_idx[i].checked=true;
			}	

	}	
	else
	{
		document.getElementById('allcheck').value="0";
		document.getElementById('toggle_img1').src = "/images/button/select.gif";
		document.getElementById('toggle_img2').src = "/images/button/select.gif";

		for( var i=0; i<charge_idx.length; i++) 
			{
				charge_idx[i].checked=false;
			}	

	}
}	


function exact_submit(form_name)
{
	var frm = document.getElementById(form_name);
	var charge_idx = document.getElementsByName("g_charge_idx")

	mail_del_chk="";
	for( var i=0; i<charge_idx.length; i++) 
		{
			if(charge_idx[i].checked==true)
			{
				mail_del_chk="O";
			}
		}	
			
		if(mail_del_chk=="O")
		{
			var ans=confirm(" 선택한 고객을 일괄 정산 처리 하시겠습니까?");
			if(ans==true)
			{
				
				NewWindow('a_charge_batch.asp','a_exact','1000','600','no');
				frm.target="a_exact";
				frm.action="a_charge_batch.asp";
				frm.submit();
			}
			else
			{
				return;
			}	        		
		}
		else
		{
			alert(" 고객을 한명이상 선택해 주세요!");
			return;
		}	
}


function fnc_batch_del(form_name)
{
	var frm			= document.getElementById(form_name);
	var del_idx		= document.getElementsByName("g_charge_idx")

	del_chk			= ""
	for(var i=0; i<del_idx.length; i++)
	{
		if(del_idx[i].checked==true)
		{
			del_chk	="O"
		}
	}

	if(del_chk=="O")
	{
		var ans	= confirm("선택한 고객을 일괄 삭제 처리하시겠습니까?");
		if (ans == true)
		{

			frm.action ="a_exact_del_batch_ok.asp";
			frm.submit();
		}
		else
		{
			return;
		}
	}
	else
	{
		alert("삭제 처리할 고객을 한명이상 선택해주세요.");
		return;
	}
}

</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1500" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr bgcolor="#FFFFFF" height='400'> 
	<td valign='top'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title" style="background:url(/images/common/sub_t_end.gif) top repeat-x;width:100%;"><img src="/images/common/sub06_t04.gif"></div>

		<form id='frm_exact1' name='frm_exact1' method='post' action='a_exact_list.asp'>
		<table width="100%" cellspacing=1 cellpadding=0 border=0>
		<tr height=50>
			<td colspan='2'><nobr>
				<select name="s_group_code" class="txtbox" style="width:80px;" onchange="s_group_change(this,'frm_exact1',this.selectedIndex);">
				<option value="">정산그룹</option>
				<% 	
				strSql = " select group_code,group_name from code_group order by group_name ASC"
				set objRs1=objCnn.Execute(strSql)

				Do until objRs1.EOF
					group_code		= objRs1(0)
					group_name		= objRs1(1)
				%>                      							
				<option value="<%=group_code%>" <% If s_group_code=group_code Then %> selected <% End If %>><%=group_name%></option>
				<%
				objRs1.movenext
				Loop
				%>
				</select>
				<select name="s_dealer_code" class="txtbox" style="width:85px;" onchange="s_change_emp_select(this,'frm_exact1',this.selectedIndex);">
				<option value="">::협력점::
				<%
				strSql = " select * from dealer_info where (dealer_insu='Y' and dealer_view='Y')"

				If s_group_code<>"" Then
				strSql = strSql & " and dealer_group_code='"&s_group_code&"' "
				End if

				strSql = strSql & " order by dealer_name asc"
				set objRs=objCnn.Execute(strSql)
					
				Do until objRs.EOF 
					dealer_code		= objRs("dealer_code")
					dealer_name		= objRs("dealer_name")
				%>
				<option value="<%=dealer_code%>"  <% if s_dealer_code=dealer_code then %> selected <% end if %>> <%=dealer_name%> 
				<%
					objRs.movenext
				Loop
				objRs.close
				%>
				</select>
				<select name="s_yuchi_m_id" class="txtbox" style="width:70px;">
				<option value="">유치자</option>
				<% 
				strSql= " select m_id, m_name,m_status from emp_list where "
				strSql = strSql & " m_dealer_code='"&s_dealer_code&"' and m_status='O' order by m_name ASC"
				set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF
					m_id			= objRs("m_id")
					m_name			= objRs("m_name")						
				%>
				<option value="<%=m_id%>" <% if UCase(s_yuchi_m_id)=UCase(m_id) then %> selected <% end if %>><%=m_name%></option>
				<%
					objRs.movenext
				Loop
				%>			
				</select>
				<select name="s_dealer_code1" class="txtbox" style="width:95px;">
				<option value="">::상부점::</option>                  							
				<% 
				strSql = " select dealer_code, dealer_name from dealer_info "
				strSql = strSql & " where (dealer_ingea='Y' and dealer_view='Y') order by dealer_name ASC"
				set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF
					dealer_code1=objRs(0)
					dealer_name1=objRs(1)
				%>                      	
				<option value="<%=dealer_code1%>" <% if UCase(dealer_code1)=UCase(s_dealer_code1) then %> selected <% end if %>><%=dealer_name1%></option>
				<%
					objRs.movenext
				Loop
				objRs.close
				%>
				</select>
				<select name="s_article_idx1" class="txtbox" style="width:90px;" onchange="s_article_change(this,'frm_exact1',this.selectedIndex);s_area_change(this,'frm_exact1',this.selectedIndex);">
				<option value="0" <% if s_article_idx1="0" then %> selected <% end if %>>::회사선택::</option>           
				<% 
				strSql = " select * from code_article where article_step2=0 and article_view='Y' order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
				<option value="<%=article_idx%>" <% if CInt(s_article_idx1)=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
				Loop
				objRs.close
				%>	
				</select>
				<select name="s_article_idx2" class="txtbox" style="width:90px;" onchange="s_option_change(this,'frm_exact1',this.selectedIndex);s_code_service_change(this,'frm_exact1',this.selectedIndex);">
				<option value="0" <% if s_article_idx2="0" then %> selected <% end if %>>::상품선택::</option> 
				<% 
				If s_article_idx1<>"0" then
				strSql = " select * from code_article where article_step1="&s_article_idx1&" and article_step2>0 "
				strSql = strSql & " and article_view='Y' "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					article_idx		= objRs("article_idx")
					article_name	= objRs("article_name")
				%>	
				<option value="<%=article_idx%>" <% if CInt(s_article_idx2)=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
				Loop
				objRs.close
				End if
				%>	
				</select>
				<select name="s_option_idx" class="txtbox" style="width:110px;">
				<option value="0" <% if s_option_idx="0" then %> selected <% end if %>> ::상품옵션:: </option>
				<% 
				If s_option_idx<>""  then
				
				strSql = " select * from code_article_option where article_idx=" & s_article_idx2 & " "
				strSql = strSql & " order by option_order Asc"
				Set objRs=objCnn.Execute(strSql)							
				
				Do until objRs.EOF   	
					option_idx			= objRs("option_idx")
					option_name			= objRs("option_name")
				%>	
				<option value="<%=option_idx%>" <% if s_option_idx=CStr(option_idx) then %> selected <% end if %>><%=option_name%></option>
				<% 
					objRs.MoveNext
				Loop
				End if
				%>	
				</select>
				<select name="s_code_service" class="txtbox" style="width:150px;">
				<option value="0" <% if s_code_service="0" then %> selected <% end if %>> ::부가서비스::</option>           
				<% 
				If s_article_idx2<>"0" then
				strSql = " select * from code_service where (service_view='Y') and article_idx="&s_article_idx2&" order by service_order Asc"
				'Response.write strSql
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF  
					service_idx			= objRs("service_idx")
					service_name		= objRs("service_name")
				%>	
				<option value="<%=service_idx%>" <% if CStr(service_idx)=s_code_service then %> selected <% end if %>><%=service_name%></option>
				<% 
					objrs.MoveNext
				Loop
				objRs.close
				End If
				%>	
				</select>
				<select name="s_code_area" class="txtbox" style="width:80px;">
				<option value="0" <% If s_code_area="" Or s_code_area="0" Then %> selected <% End If %>> ::지역:: </option>
				<%
				If s_article_idx1<>"0" Then 
				strSql = " select area_idx, area_name from code_area where (area_view='Y') and article_idx="&s_article_idx1&" order by area_order Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF  
					s_area_idx		= objRs("area_idx")
					s_area_name		= objRs("area_name")
				%>	
				<option value="<%=s_area_idx%>" <% if CInt(s_area_idx)=CInt(s_code_area) then %> selected <% end if %>><%=s_area_name%></option>
				<% 
					objrs.MoveNext
				Loop
				End if
				objRs.close
				%>
				</select>
				<select name="s_set" class="txtbox" style="width:60px;">
				<option value="" <% If s_set="" Then %>selected <% End If %>>::셋트::</option>
				<option value="A" <% If s_set="A" Then %>selected <% End If %>> 단독 </option>
				<option value="B" <% If s_set="B" Then %>selected <% End If %>> DPS  </option>
				<option value="C" <% If s_set="C" Then %>selected <% End If %>> TPS </option>
				<option value="D" <% If s_set="D" Then %>selected <% End If %>> 셋추1 </option>
				<option value="E" <% If s_set="E" Then %>selected <% End If %>> 셋추2 </option>

				</select>
				<select name="s_gaetong_code" class="txtbox" style="width:90px;">
				<option value="" <% if s_gaetong_code="" then %> selected <% end if %>>::개통상태::</option>          
				<% 
				strSql = " select * from code_gaetong order by gaetong_order Asc"
				Set objRs0=objCnn.Execute(strSql)

				Do until objRs0.EOF   	
					gaetong_code		= objRs0("gaetong_code")
					gaetong_name		= objRs0("gaetong_name")
				%>	
				<option value="<%=gaetong_code%>" <% if s_gaetong_code=gaetong_code then %> selected <% end if %>><%=gaetong_name%></option>
				<% 
					objrs0.MoveNext
				Loop
				%>	
				</select>
				<select name="date_chk" class="txtbox" style="width:120px;">
				<option value="0" <% If date_chk="0" Then %> selected <% End If %>>::검색조건::</option>
				<option value="1" <% If date_chk="1" Then %> selected <% End If %>>접수일</option>
				<option value="2" <% If date_chk="2" Then %> selected <% End If %>>개통일</option>
				<option value="3" <% If date_chk="3" Then %> selected <% End If %>>해약일</option>
				<option value="4" <% If date_chk="4" Then %> selected <% End If %>>정산예정</option>
				<option value="5" <% If date_chk="5" Then %> selected <% End If %>>정산완료</option>
				<option value="6" <% If date_chk="6" Then %> selected <% End If %>>정산예정(미완료)</option>
				</select>
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_exact1','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">~<input type="text" class="txtbox" name="s_date_end" size='9' value="<%=s_date_end%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_exact1','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
				
				<select name="date_gigan" style="width:60px;" onchange="fncDateCalculator('frm_exact1',this,'s_date_start','s_date_end');">
				<option value="">기간</option>
				<option value="A">오늘</option>
				<option value="B">어제</option>
				<option value="C">이번달</option>
				<option value="D">지난달</option>
				</select>

				<img src="/images/button/btn_search01.gif" align='absmiddle' border=0 onClick="result_customer_search('frm_exact1');" onMouseOver="this.style.cursor='hand';"></nobr>
			</td>			
		</tr>
		<tr>	
			<td align='left' colspan='2' style='border-style:none;'>
				<select name="search_key" valign='absmiddle' class="txtbox">
				<option value="c_name"> 고객명 </option>				
				<option value="m_name"> 유치자 </option>				
				<option value="g_goods_idx"> 고객번호 </option>				
				</select><input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle' OnKeyUp="auto_enter_send('frm_exact1');"><img src="/images/button/btn_search01.gif" onClick="Search('frm_exact1');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

				<select name="list_cnt" class="txtbox" onchange="submit();">
				<option value="15" <% If list_cnt="15" Then %> selected <% End If %>>15개 출력</option>
				<option value="30" <% If list_cnt="30" Then %> selected <% End If %>>30개 출력</option>
				<option value="50" <% If list_cnt="50" Then %> selected <% End If %>>50개 출력</option>
				<option value="70" <% If list_cnt="70" Then %> selected <% End If %>>70개 출력</option>
				</select>
				
				<a href="/charge/policy_list.asp"><span class="btn_m_white01"> 수수료설정</span></a>
				<a href="a_exact_excel.asp?<%=s_link_txt%>"><span class="btn_m_white01"> 엑셀저장</span></a>
				<a href="a_exact_partner_list.asp?<%=s_link_txt%>"><span class="btn_m_white01"> 거래처정산</span></a>
				<a href="a_exact_personal_list.asp?<%=s_link_txt%>"><span class="btn_m_white01"> 개인별정산</span></a>	
			</td>
		</tr>
		</table>
		</form>	

		<form id="frm_exact2" name="frm_exact2" method="post" action="a_exact_list.asp">
		<input type="hidden" id="allcheck" name="allcheck" value="0">
		<input type="hidden" name="s_link_txt" value="<%=s_link_txt%>">
							
		<table width=2200  cellspacing=1 cellpadding=0 border=0  id="board_table2">  
		<tr height="30">
			<th class="head" rowspan='2'>선택</th> 
			<Th class="head" rowspan='2'>정산</th>
			<th class="head" rowspan='2'>고객명</th>        
			<th class="head" rowspan='2'>접수일</th>
			<th class="head" rowspan='2'>협력점</th>
			<th class="head" rowspan='2'>유치자</th>
			<th class="head" rowspan='2'>회사명</th>        
			<th class="head" rowspan='2'>상품명</th>        
			<Th class="head" rowspan='2'>옵션명</th>
			<Th class="head" rowspan='2'>할인탭</th>
			<Th class="head" rowspan='2'>부가서비스</th>
			<Th class="head" rowspan='2'>결합</th>
			<Th class="head" rowspan='2'>셋트</th>

			<th class="head" rowspan='2'>개통일</th>
			<th class="head" rowspan='2'>개통상태</th>
			<th class="head" rowspan='2'>약정</th>
			<th class="head" rowspan='2'>주소/정책지역</th>

			<th class="head" rowspan='2'>약정금액</th>
			<th class="head" colspan='5'>차감항목</th>
			
			<th class="head" rowspan='2'>번들수수료</th>
			<th class="head" rowspan='2'>부가서비스</th>
			<th class="head" rowspan='2'>결합수수료</th>
			<th class="head" rowspan='2'>정산금액</th>
			<th class="head" rowspan='2'>정산예정</th>
			<th class="head" rowspan='2'>정산완료</th>
			<Th class="head" rowspan='2'>상부점</th>
			<Th class="head" rowspan='2'>본사사은품</th>
			<Th class="head" rowspan='2'>사은품 금액</th>
			<Th class="head" rowspan='2'>지급처</th>			
			<Th class="head" rowspan='2'>지급완료</th>

		</tr>
		<tr>
			<th class="head" width='80'>본사사은품</th>
			<th class="head" width='80'>사은품</th>
			<th class="head" width='80'>할인탭</th>
			<th class="head" width='80'>미비서류</th>
			<th class="head" width='80'>기타</th>
		</tr>
		
  <%
  strSql = " select ISNULL(sum(g_charge_promise),0) as t_charge_promise ,  "
  strSql = strSql & "	ISNULL(sum(g_charge_sp),0) as t_charge_sp ,  "
  strSql = strSql & "	ISNULL(sum(g_charge_sp_top),0) as t_charge_sp_top ,  "
  strSql = strSql & "	ISNULL(sum(g_charge_sale),0) as t_charge_sale ,  "
  strSql = strSql & "	ISNULL(sum(g_charge_document),0) as t_charge_document ,  "
  strSql = strSql & "	ISNULL(sum(g_charge_gita),0) as t_charge_gita ,  "
  strSql = strSql & "	ISNULL(sum(g_charge_bundle),0) as t_charge_bundle, " 
  strSql = strSql & "	ISNULL(sum(g_charge_combine),0) as t_charge_combine, " 
  strSql = strSql & "	ISNULL(sum(g_charge_buga),0) as t_charge_buga " 
  strSql = strSql & "		from customer_goods A "
  strSql = strSql & " 		Full join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx"
  strSql = strSql & "		left join dealer_info G ON  A.g_trans_in_dealer=G.dealer_code"
  strSql = strSql & "				where 1=1 "

  If search_txt<>"" Then
	If search_key="m_name" Then
		strSql = strSql & "			and (A.g_yuchi_m_id in (select m_id from emp_list "
		strSql = strSql & "				where m_name like '%"&search_txt&"%'))"
	Else
		strSql = strSql & "			and  A."&search_key&" like '%"&search_txt&"%'"
	End If		
  Else
	'회사
	If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	End If
	
	'상품
	If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	End If

	'옵션
	If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	End If


	'셋트유형
	If s_set<>"" Then
		If s_set="D" then	'셋추1
			strSql = strSql &"		and (A.goods_settop1_chk='O') "
		ElseIf s_set="E" Then
			strSql = strSql &"		and (A.goods_settop2_chk='O') "
		else
		strSql = strSql &"			and (A.g_set='"& s_set & "') "
		End if
	End If

	'개통
	If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	End If

	'협력점
	If s_dealer_code<>"" then
		strSql = strSql & "			and (A.g_trans_in_dealer='"&s_dealer_code&"') "	
	End If

	'유치자
	If s_yuchi_m_id<>"" Then
		strSql = strSql & "			and (A.g_yuchi_m_id='"&s_yuchi_m_id & "') "
	End If

	'상부점
	If s_dealer_code1<>"" then
		  strSql = strSql & "		and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
	End If

	'정산그룹별 검색
	If s_group_code<>""  Then
		strSql = strSql & "			and G.dealer_group_code='"&s_group_code&"'"
	End if

	'부가서비스 검색
	If s_code_service<>"" And s_code_service<>"0"  Then
		strSql = strSql & "			and A.g_code_service="&s_code_service&" "
	End If
	
	'지역 검색
	If s_code_area<>"0"  Then
		strSql = strSql & "			and A.g_code_area= "&s_code_area&" "
	End If
	
	'접수일
	If date_chk="1" Then
		'strSql = strSql & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
		'strSql = strSql & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "	
		
		strSql = strSql & "			and  (convert(varchar(100),g_date_yuchi,25)>='"&s_date_start&" 00:00:00' "
		strSql = strSql & "						and convert(varchar(100),g_date_yuchi,25)<='"&s_date_end&" 23:59:59') "


	End If

	'개통일
	If date_chk="2" Then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	End If

	'해약일
	If date_chk="3" Then
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
	End If

	'정산예정일
	If date_chk="4" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
	End If

	'정산완료일
	If date_chk="5" Then
		strSql = strSql & "			and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
	End If


	'정산예정일 + 미완료
	If date_chk="6" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		

		strSql = strSql & "			and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
	End If

  End If
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

	t_charge_promise	= money_chk(objRs("t_charge_promise"))
	t_charge_sp_top		= money_chk(objRs("t_charge_sp_top"))				'본사 사은품
	t_charge_sp			= money_chk(objRs("t_charge_sp"))
	t_charge_sale		= money_chk(objRs("t_charge_sale"))
	t_charge_document	= money_chk(objRs("t_charge_document"))
	t_charge_gita		= money_chk(objRs("t_charge_gita"))
	t_charge_bundle		= money_chk(objRs("t_charge_bundle"))
	t_charge_buga		= money_chk(objRs("t_charge_buga"))
	t_charge_combine	= money_chk(objRs("t_charge_combine"))
	t_charge_sum		= CDbl(t_charge_promise-cdbl(t_charge_sp_top+t_charge_sp+t_charge_sale+t_charge_document+t_charge_gita)+t_charge_bundle + t_charge_buga + t_charge_combine)

	t_charge_promise	= money_change(t_charge_promise)
	t_charge_sp_top		= money_change(t_charge_sp_top)					'본사 사은품
	t_charge_sp			= money_change(t_charge_sp)
	t_charge_sale		= money_change(t_charge_sale)
	t_charge_document	= money_change(t_charge_document)
	t_charge_gita		= money_change(t_charge_gita)
	t_charge_bundle		= money_change(t_charge_bundle)
	t_charge_buga		= money_change(t_charge_buga)
	t_charge_combine	= money_change(t_charge_combine)
	t_charge_sum		= money_change(t_charge_sum)

  objRs.close
  
  top_cnt = page * list_cnt
  strSql = " Select  TOP " &top_cnt& " H.g_charge_type, A.g_goods_idx, A.g_article_idx1, H.g_charge_idx, A.c_jumin1, A.c_jumin2, "
  strSql = strSql & " A.g_yuchi_m_id, A.g_date_yuchi, A.g_date_gaetong, A.g_article_cnt, B.m_tel2, A.g_goods_ref, A.goods_settop1_chk, A.goods_settop2_chk,  "
  strSql = strSql & " A.g_writeday, G.dealer_name, B.m_name as yuchi_name, A.g_service_no, A.c_tel2, A.c_address, "
  strSql = strSql & " H.g_charge_promise, H.g_charge_sp_top, H.g_charge_sp, H.g_charge_sale, H.g_charge_document, " 
  strSql = strSql & " H.g_charge_bundle, H.g_charge_buga, H.g_charge_combine, H.g_charge_bigo, H.g_charge_date1, H.g_charge_date1, H.g_charge_date2, "
  strSql = strSql & " H.g_charge_bigo_doc, H.g_charge_gita, " 
  strSql = strSql & " A.g_sp_name, A.g_sp_price, A.g_sp_name_top, A.g_sp_price_top, A.g_sp_give_type, A.g_sp_date_start, L.area_name, "
  strSql = strSql & " A.g_sp_date_end, C.article_name, D.article_name as article_name1, M.dealer_name as dealer_name1,   "
  strSql = strSql & " E.gaetong_name, E.gaetong_color, A.c_name, O.service_name, G.dealer_tel1 as dealer_tel2, "
  strSql = strSql & " I.promise_name, J.sale_name , K.option_name, A.g_set, P.combine_name "

  strSql = strSql & "		from customer_goods A full  "
  strSql = strSql & "			 join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx"
  strSql = strSql & " 		left join emp_list B ON A.g_yuchi_m_id=B.m_id "
  strSql = strSql & "		left join code_article  C on A.g_article_idx1=C.article_idx "
  strSql = strSql & "		left join code_article  D on A.g_article_idx2=D.article_idx "
  strSql = strSql & "		left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
  strSql = strSql & "		left join dealer_info G ON A.g_trans_in_dealer=G.dealer_code"
  strSql = strSql & "		left join code_promise I on A.g_code_promise=I.promise_idx"
  strSql = strSql & "		left join code_sale J on A.g_code_sale=J.sale_idx"
  strSql = strSql & "		left join code_article_option K on A.g_option_idx=K.option_idx"
  strSql = strSql & "		left join code_area L ON A.g_code_area=L.area_idx"
  strSql = strSql & "		left join dealer_info M ON A.g_trans_out_dealer=M.dealer_code"
  strSql = strSql & "		left join code_service O ON A.g_code_service=O.service_idx"
  strSql = strSql & "		left join code_combine P ON A.g_code_combine=P.combine_idx"

  strSql = strSql & "				where 1=1 "

  If search_txt<>"" Then
	If search_key="m_name" Then
		strSql = strSql & "			and (B.m_name like '%"&search_txt&"%') "
	Else
		strSql = strSql & "			and  A."&search_key&" like '%"&search_txt&"%'"
	End If		
  Else
	'회사
	If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	End if

	'상품
	If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	End If

	'옵션
	If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	End If

	'셋트유형
	If s_set<>"" Then
		If s_set="D" then	'셋추1
			strSql = strSql &"		and (A.goods_settop1_chk='O') "
		ElseIf s_set="E" Then
			strSql = strSql &"		and (A.goods_settop2_chk='O') "
		else
		strSql = strSql &"			and (A.g_set='"& s_set & "') "
		End if
	End If

	'개통
	If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	End If

	'협력점
	If s_dealer_code<>"" then
		strSql = strSql & "			and (A.g_trans_in_dealer='"&s_dealer_code&"') "	
	End If

	'유치자
	If s_yuchi_m_id<>"" Then
		strSql = strSql & "			and (A.g_yuchi_m_id='"&s_yuchi_m_id & "') "
	End If

	'상부점
	If s_dealer_code1<>"" then
		  strSql = strSql & "			and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
	End If

	'정산그룹별 검색
	If s_group_code<>""  Then
		strSql = strSql & "			and G.dealer_group_code='"&s_group_code&"'"
	End If

	'부가서비스 검색
	If s_code_service<>"" And s_code_service<>"0"  Then
		strSql = strSql & "			and A.g_code_service="&s_code_service&" "
	End If
	
	'지역 검색
	If s_code_area<>"0"  Then
		strSql = strSql & "			and A.g_code_area= "&s_code_area&" "
	End If

	'접수일
	If date_chk="1" Then
		strSql = strSql & "			and  (convert(varchar(100),g_date_yuchi,25)>='"&s_date_start&" 00:00:00' "
		strSql = strSql & "					and convert(varchar(100),g_date_yuchi,25)<='"&s_date_end&" 23:59:59') "	
	End If

	'개통일
	If date_chk="2" Then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	End If

	'해약일
	If date_chk="3" Then
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
	End If

	'정산예정일
	If date_chk="4" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
	End If

	'정산완료일
	If date_chk="5" Then
		strSql = strSql & "			and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
	End If


	'정산예정일 + 미완료
	If date_chk="6" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		

		strSql = strSql & "			and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
	End If
	
  End If 

  strSql = strSql & "						order by  A.g_date_yuchi Desc,A.g_goods_idx desc "

  'Response.write strSql		
  objCnn.CommandTimeout=30
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = list_cnt
	
  recordcount	= objRs.recordcount
  %>

  <%
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td class='con5' colspan='28'> 고객 검색 상품이 없습니다. </td>
		</tr>
  <%
  Else
  %>

  <%
    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount  	
  		 
	i = 1
	chk=1
	Do until objRs.EOF Or i>objRs.PageSize 
		g_goods_idx				= objRs("g_goods_idx")
		g_goods_ref				= objRs("g_goods_ref")
		article_name			= objRs("article_name")
		article_name1			= objRs("article_name1")
		c_name					= objRs("c_name")								'고객명		
		g_charge_type_txt		= fnc_charge_type(objRs("g_charge_type"))		'정산종류(G,A)
		g_charge_idx			= objRs("g_charge_idx")

		c_jumin1				= objRs("c_jumin1")
		c_jumin2				= objRs("c_jumin2")
		c_tel2					= objRs("c_tel2")
		c_address				= objRs("c_address")
		
		g_date_gaetong			= Left(objRs("g_date_gaetong"),10)

		option_name				= objRs("option_name")
		dealer_name				= objRs("dealer_name")	
		dealer_name1			= objRs("dealer_name1")							'상부점
		g_set					= fnc_g_set(objRs("g_set"))						'셋트유형
		yuchi_name				= objRs("yuchi_name")

		g_charge_promise		= money_chk(objRs("g_charge_promise"))
		g_charge_sp_top			= money_chk(objRs("g_charge_sp_top"))
		g_charge_sp				= money_chk(objRs("g_charge_sp"))
		g_charge_sale			= money_chk(objRs("g_charge_sale"))
		g_charge_document		= money_chk(objRs("g_charge_document"))
		g_charge_gita			= money_chk(objRs("g_charge_gita"))
		g_charge_bundle			= money_chk(objRs("g_charge_bundle"))
		g_charge_buga			= money_chk(objRs("g_charge_buga"))
		g_charge_combine		= money_chk(objRs("g_charge_combine"))
		g_charge_sum			= CDbl(g_charge_promise-CDBL(g_charge_sp_top+g_charge_sp+g_charge_sale+g_charge_document+g_charge_gita)+g_charge_bundle+g_charge_buga + g_charge_combine)

		g_charge_promise		= money_change(g_charge_promise)
		g_charge_sp_top			= money_change(g_charge_sp_top)
		g_charge_sp				= money_change(g_charge_sp)
		g_charge_sale			= money_change(g_charge_sale)
		g_charge_document		= money_change(g_charge_document)
		g_charge_gita			= money_change(g_charge_gita)
		g_charge_bundle			= money_change(g_charge_bundle)
		g_charge_buga			= money_change(g_charge_buga)
		g_charge_combine		= money_change(g_charge_combine)
		g_charge_sum			= money_change(g_charge_sum)


		g_charge_bigo			= objRs("g_charge_bigo")							'정산 비고
		g_charge_bigo_doc		= objRs("g_charge_bigo_doc")					'미비서류 비고
		g_charge_date1			= objRs("g_charge_date1")							'정산 예정일
		g_charge_date2			= objRs("g_charge_date2")							'정산 완료일

		gaetong_name			= objRs("gaetong_name")
		gaetong_color			= objRs("gaetong_color")
			
		g_sp_name				= objRs("g_sp_name")							'사은품 명
		g_sp_name_top			= objRs("g_sp_name_top")						'사은품 명
		g_sp_price				= money_change(objRs("g_sp_price"))				'사은품 금액
		g_sp_price_top			= money_change(objRs("g_sp_price_top"))			'본사 사은품 금액
		g_sp_give_type			= objRs("g_sp_give_type")						'사은품 지급처
		
		g_sp_give_type_txt		= fnc_g_sp_give_type(g_sp_give_type,"A")

		g_sp_date_start			= objRs("g_sp_date_start")						'사은품 예정
		g_sp_date_end			= objRs("g_sp_date_end")						'사은품 지급완료

		promise_name			= objRs("promise_name")							'상품 약정
		sale_name				= objRs("sale_name")							'할인탭
		service_name			= objRs("service_name")	
		combine_name			= objRs("combine_name")	
		
		dealer_tel2				= objRs("dealer_tel2")							'협력점 전화
		sp_bg_txt				= ""
		area_name				= objRs("area_name")							'지역


		goods_settop1_chk	= objRs("goods_settop1_chk")
		goods_settop2_chk	= objRs("goods_settop2_chk")

		If goods_settop1_chk="O" Then
			g_set			= "셋추1"
		End If

		If goods_settop2_chk="O" Then
			g_set			= "셋추2"
		End If


		If g_sp_give_type="A" Or g_sp_give_type="E" Then
			If g_charge_sp<>0 Then
				sp_bg_txt		= "style='background-color:yellow';"
			End If
		Else
			If g_charge_sp<>g_sp_price Then
				sp_bg_txt		= "style='background-color:yellow';"
			End If			
		End if		
		
		sp_top_bg				= ""

		If g_charge_sp_top<> g_sp_price_top Then
			sp_top_bg			= "style='background-color:yellow';"
		End if		

		g_article_cnt			= objRs("g_article_cnt")						'회선수
		g_service_no			= objRs("g_service_no")							'가입서비스번호
		m_tel2					= objRs("m_tel2")
		g_writeday				= fnc_date_change(objRs("g_writeday"))
		g_date_yuchi			= fnc_date_change(objRs("g_date_yuchi"))
		
		If g_goods_idx="" Or isnull(g_goods_idx)=true Then  g_goods_idx="" End if
		If g_goods_idx_chk	= CStr(g_goods_idx) Then
			bg_txt = "style='background-color:#CEE3F6'"
		Else
			bg_txt = ""		
		End if		
		
		If i=1 then
	%>
		<tr height=30>				
			<td class='con5' colspan='3'>		
				<img id="toggle_img1" src="/images/button/select.gif" valign='abmiddle' onClick="toggle_img(this.src);">
				<a href="javascript:exact_submit('frm_exact2');"><img src="/images/button/apply.gif"></a>&nbsp;
				
			</td>
			<td class='con4' colspan='14'><b><span class='blue'>정산 합계 총액</span></b></td>
			<td class="con4"><span class='blue'><%=t_charge_promise%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_sp_top%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_sp%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_sale%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_document%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_gita%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_bundle%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_buga%></span></td>
			<td class="con4"><span class='blue'><%=t_charge_combine%></span></td>
			<td class="con4"><span class='red'><%=t_charge_sum%></span></td>
			<td class="con4" colspan='13'>&nbsp;</td>
		</tr>		
		<% End If %>
		<!--#include virtual="/include/asp/customer_marking.asp"-->
		<tr height="30" <%=bg_txt%> onmouseover="style.backgroundColor='#CEE3F6';this.style.cursor='hand';" onmouseout="style.backgroundColor='white'">
			<td class="con5"><input type="checkbox" id="g_charge_idx" name="g_charge_idx" value="<%=g_charge_idx%>:<%=g_goods_idx%>"></td>
			<td class="con4">
				<span onclick="NewWindow('a_charge_regist.asp?g_goods_idx=<%=g_goods_idx%>&g_charge_idx=<%=g_charge_idx%>','top_exact','1000','600','yes');" class="btn_s_white01"><b><%=g_charge_type_txt%></b></span></td>
			<td class="con4"><a href="a_exact_regist.asp?g_goods_idx=<%=g_goods_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>"><b><%=Left(c_name,3)%></b></a></td>       
			<td class="con4"><span title="최초등록일:<%=g_writeday%>"><%=g_date_yuchi%></span></td>
			<td class="con4"><span class='blue' title="<%=dealer_name%>, Tel.<%=dealer_tel2%>"><%=Left(dealer_name,4)%></span></td>
			<td class="con4"><span title="<%=yuchi_name%> , Tel. <%=m_tel2%>"><%=Left(yuchi_name,3)%></span></td>
			<td class="con4"><span title="<%=article_name%>"><%=Left(article_name,6)%></span></td>
			<td class="con4"><span title="<%=article_name1%>"><%=Left(article_name1,6)%></span></td>
			<td class="con2"><span class='red' title='<%=option_name%>'><%=Left(option_name,10)%> </span></td>
			<td class="con4"><span title="<%=sale_name%>"><%=Left(sale_name,10)%></span></td>
			<td class="con4"><%=service_name%></td>
			<td class="con4"><%=combine_name%></td>

			<td class="con4"><span title="회선 : <%=g_article_cnt%>"><%=g_set%></span></td>
			<td class="con4"><%=g_date_gaetong%></td>
			<td class="con4"><b><span style='color:<%=gaetong_color%>;'><%=gaetong_name%></span></b></td>
			<td class="con4"><span title="<%=promise_name%>"><%=Left(promise_name,2)%></span></td>
			<td class="con4"><span title="<%=c_address%>"><%=Left(c_address,2)%></span> / <span class='red'><%=area_name%></span></td>
			<td class="con4"><b><%=g_charge_promise%></b></td>
			<td class="con4" <%=sp_top_bg%>><b><%=g_charge_sp_top%></b></td>
			<td class="con4" <%=sp_bg_txt%>><b><%=g_charge_sp%></b></td>
			<td class="con4"><b><%=g_charge_sale%></b></td>
			<td class="con4"><b><%=g_charge_document%></b></td>
			<td class="con4"><b><%=g_charge_gita%></b></td>
			
			<td class="con4"><b><span><%=g_charge_bundle%></span></b></td>
			<td class="con4"><b><span><%=g_charge_buga%></span></b></td>
			<td class="con4"><b><span><%=g_charge_combine%></span></b></td>
			<td class="con4"><span class='red' title="<%=g_charge_bigo%>"><%=g_charge_sum%></span></td>
			<td class="con4"><span class='blue' ><%=g_charge_date1%></span></td>
			<td class="con4"><span class='red' ><%=g_charge_date2%></span></td>
			
			<td class="con4"><span title="<%=dealer_name1%>"><%=Left(dealer_name1,6)%></span></td>
			<td class="con4" <%=sp_top_bg%>><span class='red' title="<%=g_sp_name_top%>"><%=g_sp_price_top%></span></td>
			<td class="con4" <%=sp_bg_txt%>><span class='red' title="<%=g_sp_name%>"><%=g_sp_price%></span></td>
			<td class="con4"><%=g_sp_give_type_txt%></td>
			<td class="con4"><span class='red'><%=g_sp_date_end%></span></td>
		</tr>   
  <% 
    i=i+1
	objRs.movenext
  Loop
  objRs.close
  
  End if
%>		
		

		</table>
		<div style="margin:5px 0 0 10px;text-align:left;">
			<img id="toggle_img2" src="/images/button/select.gif" valign='abmiddle' onClick="toggle_img(this.src);">
			<a href="javascript:exact_submit('frm_exact2');"><img src="/images/button/apply.gif"></a>&nbsp;
			<% If session_m_step="M" Then %>
			<a href="javascript:fnc_batch_del('frm_exact2');"><img src="/images/button/batch_del.gif"></a>
			<% End If %>
		</div>

  <%
  strSql = "select count(A.g_goods_idx) " 
  strSql = strSql & "		from customer_goods A full  "
  strSql = strSql & "			 join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx"
  strSql = strSql & " 		left join emp_list B ON A.g_yuchi_m_id=B.m_id "
  strSql = strSql & "		left join dealer_info G ON A.g_trans_in_dealer=G.dealer_code"
  strSql = strSql & "				where 1=1 "


  If search_txt<>"" Then
	If search_key="m_name" Then
		strSql = strSql & "			and (B.m_name like '%"&search_txt&"%') "
	Else
		strSql = strSql & "			and  A."&search_key&" like '%"&search_txt&"%'"
	End If		
  Else
	'회사
	If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	End if

	'상품
	If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	End If

	'옵션
	If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	End If


	'셋트유형
	If s_set<>"" Then
		If s_set="D" then	'셋추1
			strSql = strSql &"		and (A.goods_settop1_chk='O') "
		ElseIf s_set="E" Then
			strSql = strSql &"		and (A.goods_settop2_chk='O') "
		else
		strSql = strSql &"			and (A.g_set='"& s_set & "') "
		End if
	End If

	'개통
	If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	End If

	'협력점
	If s_dealer_code<>"" then
		strSql = strSql & "			and (A.g_trans_in_dealer='"&s_dealer_code&"') "	
	End If

	'유치자
	If s_yuchi_m_id<>"" Then
		strSql = strSql & "			and (A.g_yuchi_m_id='"&s_yuchi_m_id & "') "
	End If

	'상부점
	If s_dealer_code1<>"" then
		  strSql = strSql & "			and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
	End If

	'정산그룹별 검색
	If s_group_code<>""  Then
		strSql = strSql & "			and G.dealer_group_code='"&s_group_code&"'"
	End If

	'부가서비스 검색
	If s_code_service<>"" And s_code_service<>"0"  Then
		strSql = strSql & "			and A.g_code_service="&s_code_service&" "
	End If
	
	'지역 검색
	If s_code_area<>"0"  Then
		strSql = strSql & "			and A.g_code_area= "&s_code_area&" "
	End If

	'접수일
	If date_chk="1" Then
		strSql = strSql & "			and  (convert(varchar(100),g_date_yuchi,25)>='"&s_date_start&" 00:00:00' "
		strSql = strSql & "					and convert(varchar(100),g_date_yuchi,25)<='"&s_date_end&" 23:59:59') "	
	End If

	'개통일
	If date_chk="2" Then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	End If

	'해약일
	If date_chk="3" Then
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
	End If

	'정산예정일
	If date_chk="4" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
	End If

	'정산완료일
	If date_chk="5" Then
		strSql = strSql & "			and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
	End If


	'정산예정일 + 미완료
	If date_chk="6" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		

		strSql = strSql & "			and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
	End If		
  End If 
  
  Set objRs=objCnn.Execute(strSql)
  recordcount = objRs(0)
  totalpage = int((recordCount-1)/list_Cnt)+1
  mychoice=10
  link_url = "a_exact_list.asp?"&s_link_txt&"&"
  %>
		<div class="pagelist">
			<!--#include virtual="/include/asp/list_paging.asp"-->
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
  <%
  DBClose()
  %>