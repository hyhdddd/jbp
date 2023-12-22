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
  article_idx1		= WORD_CHANGE(Request("s_article_idx1"),20)
  article_idx2		= WORD_CHANGE(Request("s_article_idx2"),20)


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
  

  If article_idx1="" Or article_idx1="0" then
	   strSql = " select * from code_article where article_step2=0 and article_view='Y' order by article_order asc "
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
	  Else
		's_article_idx2		= objRs(0)
		article_idx1		= objRs("article_step1")
		'article_step2		= objRs("article_step2")
	  End If
  
	  strSql = " select * from code_article where article_step1="&article_idx1&" and article_step2>0 and article_view='Y' "
	  strSql = strSql & " order by article_order asc "
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
	  Else
		article_idx2		= objRs(0)
		's_article_idx1		= objRs("article_step1")
		article_step2		= objRs("article_step2")
	  End If

  End If
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/custom_goods.asp"></SCRIPT>

<script language="javascript">
<!--
function change_article()
{
	var frm=document.all.frm_sale
	frm.action="charge_sale.asp";
	frm.submit();
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

		<form name="frm_sale" Method="POST" action="charge_sale_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>&nbsp;&nbsp;
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		<tr height='30'>
			<th width='150'>정책 일자	</th>
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
			<td width='850' colspan='3'><%=group_name%></td>
		</tr>
		<tr height='30'>
			<th width='150'>회사 선택	</th>
			<td width='850' colspan='3'>
				<select name="s_article_idx1" style="width:120px;" onblur="BlurColor(this);" onFocus="FocusColor(this);"
				onchange="s_article_change(this,'frm_sale',this.selectedIndex);">
				<option value="0" <% if article_idx="0" then %> selected <% end if %>> 회사선택           
				<% 
				strSql = " select * from code_article where article_step2=0 and article_view='Y' "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else						 
				i = 1
				Do until objRs.EOF   	
					c_article_idx			= objRs("article_idx")
					c_article_name		= objRs("article_name")
				%>	
					<option value="<%=c_article_idx%>" <% if CInt(article_idx1)=c_article_idx then %> selected <% end if %>><%=c_article_name%></option>
				<% 
					objrs.MoveNext
					i=i+1 
				Loop
				End if
			%>	
			</select><select name="s_article_idx2" style="width:110px;font-size:11px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="change_article();">
					<option value="" <% if article_idx2="" then %> selected <% end if %>> 상품선택 
					<% 
					If article_idx1<>"" then

					strSql = " select * from code_article where article_step1="&article_idx1&" and article_step2>0 and article_view='Y' "
					strSql = strSql & " order by article_order Asc"
					Set objRs=objCnn.Execute(strSql)

					if objRs.BOF or objRs.EOF then
					else							 
						i = 1
						Do until objRs.EOF   	
							d_article_idx		= objRs("article_idx")
							d_article_name	= objRs("article_name")
						%>	
							<option value="<%=d_article_idx%>" <% if CInt(article_idx2)=d_article_idx then %> selected <% end if %>><%=d_article_name%></option>
						<% 
							objrs.MoveNext
							i=i+1 
						Loop
						End If
					End if
				%>	
				</select>
			</td>
		</tr>
		</table>	

	
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width="300">상 품 명</td> 
			<td class="head" width="200">할인탭</td> 
			<td class="head">단독(차감액)</td> 
			<td class="head">DPS(차감액)</td> 
			<td class="head">TPS(차감액)</td> 

		</tr>
 
  <% 
		i=i+1 
		strSql = " select * from code_article_option where "
		strSql = strsql & " article_idx="&article_idx2&" and option_view='Y' order by option_order asc "
		Set objRs1=objCnn.Execute(strSql)

		Do Until objRs1.Eof
			option_idx		= objRs1("option_idx")
			option_name		= objRs1("option_name")

			
  %>
		<tr height=30>
			<td class="con1">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				(옵션) <%=option_name%>
			</td>
			
			<td class="con4" colspan='4'></td>
		</tr>
		<%
			strSql = " select * from code_sale where article_idx="&article_idx2&" and sale_view='Y' "
			strSql = strSql & " order by sale_order asc "
			Set objRs2=objcnn.Execute(strSql)

			Do Until objRs2.eof
				sale_idx		= objRs2("sale_idx")
				sale_name		= objRs2("sale_name")


				strSql = " select top 1 sale_charge,sale_charge_dps, sale_charge_tps from charge_sale "
				strSql = strSql & " where policy_idx="&policy_idx&" "
				strsql = strSql & " and option_idx="&option_idx&" and sale_idx="&sale_idx&" "
				Set objRs3=objCnn.Execute(strSQl)

				If objRs3.eof Or objRs3.bof Then
						sale_charge		= ""
						sale_charge_dps	= ""
						sale_charge_tps	= ""
				Else
						sale_charge		= objRs3("sale_charge")
						sale_charge_dps	= objRs3("sale_charge_dps")
						sale_charge_tps	= objRs3("sale_charge_tps")
				End if

		%>
		<tr height='30'>
			<td class='con1'></td>
			<td class="con4"><%=sale_name%></td>
			<td class='con4'>
				<input type="text" class='txtbox' name="<%=sale_idx%>_<%=option_idx%>" size='8' maxlength='6' onKeyUp="fncOnlyNumber(this);" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();" value="<%=sale_charge%>"></td>
			<td class='con4'>			
				<input type="text" class='txtbox' name="<%=sale_idx%>_<%=option_idx%>_dps" size='8' maxlength='6' onKeyUp="fncOnlyNumber(this);" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();" value="<%=sale_charge_dps%>"></td>
			<td class='con4'>
				<input type="text" class='txtbox' name="<%=sale_idx%>_<%=option_idx%>_tps" size='8' maxlength='6' onKeyUp="fncOnlyNumber(this);" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();" value="<%=sale_charge_tps%>"></td>
		</tr>
		<%
				objRs2.movenext
			Loop
			
			objRs1.movenext
			i=i+1
		Loop
			
   objRs.close
  %>   
		<tr>
			<td colspan='3' align='right'>		
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
