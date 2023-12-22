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
  

  If s_article_idx1="" Or s_article_idx1="0" then
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
	frm.action="charge_document.asp";
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


		<form name="frm_sale" Method="POST" action="charge_document_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		<input type="hidden" name="article_idx" value="<%=s_article_idx1%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>&nbsp;&nbsp;
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		<tr height='30'>
			<th width='150'>정책 일자 </th>
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
			<th width='150'>
				회사 선택
			</th>
			<td width='850' colspan='3'>
				<select name="s_article_idx1" style="width:120px;font-size:11px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="change_article();">
					<option value="0" <% if s_article_idx1="0" then %> selected <% end if %>>회사선택           
					<% 
					strSql = " select * from code_article where article_view='Y' and article_step2=0 "
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
			</td>
		</tr>
		</table>	
	
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width="420">미비서류</td> 
			<td class="head" width="150">차감금액</td> 
		</tr>
  <%
  strSql = " select * from code_document A left outer "
  strSql = strSql &	"	Join code_article B ON A.article_idx=B.article_idx "
  strSql = strSql & "			and A.article_idx=B.article_idx and B.article_step2=0 "
  strSql = strSql & "		where B.article_idx="&s_article_idx1&" "
  strSql = strSql & "			and A.document_view='Y' order by document_order asc "
  Set objRs=objCnn.Execute(strSql)
	
  if objRs.BOF or objRs.EOF Then
  %>
				<tr height=25>
					<td colspan='4' align='center' class="table_list3">
						코드가 존재하지 않습니다.
					</td>
				</tr>
  <%
  else  		 
  	i = 1
  	Do until objRs.EOF   	
  		document_idx			= objRs("document_idx")
  		document_name			= objRs("document_name")  

		strSql = "select top 1 * from charge_document where policy_idx="&policy_idx&" "
		strSql = strSql & " and article_idx="&s_article_idx1
		strSql = strSql & " and document_idx="&document_idx

		Set objRs1=objCnn.Execute(strSql)
		
		If objRs1.eof  Or objRs1.bof then
			document_charge = ""
		Else
			document_charge = objRs1("document_charge")
		End if
		
%>	
		<tr height=30>
			<td class="con1">&nbsp;&nbsp;<%=document_name%></td>
			<td class='con4'>
				<input type="text" class='txtbox' name="document_<%=document_idx%>" size='8' maxlength='6' onKeyUp="fncOnlyNum(this);" value="<%=document_charge%>"></td>			
		</tr>
  <%
   	objRs.MoveNext   		
   	loop
   end if					
   objRs.close
  %>   
		<tr>
			<td colspan='4' align='right'>		
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
