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
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	

  policy_idx		= WORD_CHANGE(request("policy_idx"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2	= WORD_CHANGE(Request("s_article_idx2"),20)
  g_code_area		= WORD_CHANGE(Request("g_code_area"),20)

  If policy_idx="" Then 
	Alert_back "잘못된 접근 입니다. \n\n 관리자에 문의하세요!"
  End If


  If policy_idx<>"" then
  strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
  strSql = strSql & "	from charge_policy  A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code"
  strSql = strSql & "			where A.policy_idx="&policy_idx
  Set objRs=objCnn.Execute(strSql)

  group_code	= objRs("group_code")
  group_name	= objRs("group_name")
  policy_date	= fnc_date_change(objRs("policy_date"))
  End If
  
  If s_article_idx1="" Or s_article_idx1="0" Then
	  strSql = " select * from code_article where article_step2=0 and article_view='Y' order by article_order asc "
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
	  Else
		's_article_idx2		= objRs(0)
		s_article_idx1		= objRs("article_step1")
		'article_step2		= objRs("article_step2")
	  End If
  
	  strSql = " select * from code_article where article_step1="&s_article_idx1&" and article_step2>0 and article_view='Y' "
	  strSql = strSql & " order by article_order asc "
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
	  Else
		s_article_idx2		= objRs(0)
		's_article_idx1		= objRs("article_step1")
		article_step2		= objRs("article_step2")
	  End If

	  
  End If
  
  If g_code_area="" Or IsNull(g_code_area) then
	  strSql = " select * from code_area where article_idx="&s_article_idx1&" and area_view='Y' order by area_order asc "
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
		alert_url "지역코드가 존재하지 않습니다. 지역 코드를 확인해 주세요!","/charge/group_list.asp?policy_idx="&policy_idx
	  Else
		g_code_area	= objRs("area_idx")
	  End if
  End if

  strSql = " select count(*) from code_promise where promise_view='Y' "
  strSql = strSql & " and article_idx="&s_article_idx2
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

  promise_cnt1=objRs(0)

  If promise_cnt1=0 Then
	Alert_url "약정코드가 존재하지 않아 설정을 할 수가 없습니다. 코드관리에서 약정코드를 정확히 만들어 주세요!","/charge/group_list.asp?policy_idx="&policy_idx
  End if
  Dim promise_idx(50)
  Dim promise_name(50)
  Dim promise_charge(50)

  strSql = " select * from code_promise where promise_view='Y' "
  strSql = strSql & " and article_idx="&s_article_idx2& " order by promise_order asc"
  Set objRs=objCnn.Execute(strSql)

  i=1
  Do Until objRs.eof
		promise_idx(i)		= objRs("promise_idx")
		promise_name(i)		= objRs("promise_name")
		objRs.movenext	
		i=i+1
  loop
  

  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/custom_goods.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/area_change.asp"></SCRIPT>
<script language="javascript">
<!--
function change_article()
{
	var frm=document.all.frm_group;

	if (frm.s_article_idx2.value=="0" || frm.g_code_area.value=="0")
	{
	}
	else
	{
		frm.action="charge_promise.asp";
		frm.submit();
	}
}


function charge_del_ok(url)
{
	ans=confirm("정책을 삭제하시겠습니까?");
	if(ans==true)
	{
		location.replace(url);
	}
}

-->
</script>

<body>
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr height='400' valign='top'> 
	<td>
		<!------------------ 내용 시작  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">수수료 정책</li>
		</ul>
		</div>


		<form name="frm_group" Method="POST" action="charge_promise_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		<input type="hidden" name="area_idx" value="<%=g_code_area%>">
		<input type="hidden" name="article_idx1" value="<%=s_article_idx1%>">
		<input type="hidden" name="article_idx2" value="<%=s_article_idx2%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'><!--#include virtual="/include/asp/charge_menu_list.asp"--></td>
		</tr>
		<tr height='30'>
			<th width='150'>
				정책 일자
			</th>
			<td width='850' colspan='3'><%=policy_date%>
				&nbsp;&nbsp;&nbsp;	
				<a href="/charge/charge_promise.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 약정수수료</span></a>
				<a href="/charge/charge_sale.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 할인탭</span></a>
				<a href="/charge/charge_bundle.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 번들수수료</span></a>
				<a href="/charge/charge_document.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 미비서류</span></a>
				<a href="/charge/charge_buga.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 부가서비스</span></a>
				<a href="/charge/charge_combine.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 결합수수료</span></a>
				<a href="javascript:charge_del_ok('policy_del_ok.asp?policy_idx=<%=policy_idx%>')"><span class="btn_m_white01"> 정책삭제</span></a> 
			</td>
		</tr>
		<tr height='30'>
			<th width='150'>정책 그룹명	</th>
			<td width='850' colspan='3'><%=group_name%>	</td>
		</tr>
		<tr height='30'>
			<th width='150'>회사 선택</th>
			<td width='850' colspan='3'>
				<select name="s_article_idx1" style="width:120px;font-size:12px;" onchange="s_article_change(this,'frm_group',this.selectedIndex);area_change(this,'frm_group',this.selectedIndex);">
				<option value="0" <% if s_article_idx1="0" then %> selected <% end if %>>::회사 선택::           
				<% 
				strSql = " select * from code_article where article_step2=0 and article_view='Y' "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else						 
				i = 1
				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
					<option value="<%=article_idx%>" <% if CInt(s_article_idx1)=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
					i=i+1 
				Loop
				End if
				%>	
				</select>				
				<select name="s_article_idx2" style="width:110px;font-size:12px;" onchange="change_article();">
				<option value="0" <% if s_article_idx2="0" then %> selected <% end if %>>::상품 선택:: 
				<% 
				If s_article_idx1<>"0" then

				strSql = " select * from code_article where article_step1="&s_article_idx1&" and article_step2>0 and article_view='Y' "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else							 
					i = 1
					Do until objRs.EOF   	
						article_idx		= objRs("article_idx")
						article_name	= objRs("article_name")
					%>	
						<option value="<%=article_idx%>" <% if CInt(s_article_idx2)=article_idx then %> selected <% end if %>><%=article_name%></option>
					<% 
						objrs.MoveNext
						i=i+1 
					Loop
					End If
				End if
				%>	
				</select>
				<select name="g_code_area" style="width:150px;"  onchange="change_article();">
				<option value="0" selected> ::지역 선택:: </option>
				<%
				strSql = " select area_idx, area_name from code_area where "
				strSql = strSql & " (area_view='Y') and article_idx="&s_article_idx1&"  "
				strSql = strSql & " order by area_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else
					i = 1
					Do until objRs.EOF  
						area_idx		= objRs("area_idx")
						area_name		= objRs("area_name")
				%>	
				<option value="<%=area_idx%>" <% if CInt(area_idx)=CInt(g_code_area) then %> selected <% end if %>><%=area_name%></option>
				<% 
						objrs.MoveNext
						i=i+1 
					Loop
				End If
				%>
				</select>
			</td>
		</tr>
		</table>	

	
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width="300">상 품 명</td> 
			<% For i=1 To promise_cnt1 %>
			<td class="head"><%=promise_name(i)%></td> 
			<% Next %>
		</tr>
  <% 
		i=i+1 
		strSql = " select * from code_article_option where "
		strSql = strsql & " article_idx="&s_article_idx2&" and option_view='Y' order by option_order asc "
		Set objRs1=objCnn.Execute(strSql)

		Do Until objRs1.Eof
			option_idx		= objRs1("option_idx")
			option_name		= objRs1("option_name")

			For j=1 To promise_cnt1				
				strSql = "select promise_charge from charge_promise where option_idx="& option_idx &" and policy_idx="&policy_idx&" "
				strSql = strSql & "		and area_idx="&g_code_area & " "
				strSql = strSql & "		and promise_idx="&promise_idx(j) & " "
				Set objRs2=objCnn.Execute(strSql)

				If objRs2.eof Or objRs.bof Then
					promise_charge(j)	= 0
				Else
					promise_charge(j)	= objRs2(0)
				End if


			Next
    



  %>
		<tr height=30>
			<td class="con1">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				(옵션) <%=option_name%>
			</td>
			<% For i=1 To promise_cnt1 %>
			<td class="con4"><input type="text" class='txtbox' name="<%=promise_idx(i)%>_<%=option_idx%>" size='8' maxlength='8' value="<%=promise_charge(i)%>" onKeyUp="fncOnlyNum(this);" onFocus="FocusColor(this);this.select();"></td>
			<% Next %>
		</tr>

		<%
			objRs1.movenext
			i=i+1
		Loop

  %>   
		<tr>
			<td colspan='<%=promise_cnt1+1%>' align='right'>		
			<img src="/images/button/btn_save.gif" onclick="submit();">
			</td>
		</tr>
		</table>
		</form>
		
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
<tr>
	<td>
		<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
