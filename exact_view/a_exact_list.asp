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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->  
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
  end if	

  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
  s_charge_chk		= WORD_CHANGE(Request("s_charge_chk"),20)

   
  timerStartTimer = Timer()
  PageSize=15
  	
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
function board_search(form_name)
{
	var frm=eval("document.all."+form_name);
	//alert(frm.search_key.value);
	
	if(frm.search_txt.value=="")
	{
		alert("검색어를 입력해 주세요");
		return;
	}
	
	frm.submit();
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
			<li class="txt">전체 정산내역서</li>
		</ul>
		</div>

		<table width="100%" cellspacing=1 cellpadding=0 border=0>

		<tr height=28>             
			<td align='left' colspan='3'>
				<table width="100%" cellspacing=0 cellpadding=0 border=0  class="table_css">
				<form name='frm_board' method='post' action='a_exact_list.asp'>
				<input type="hidden" name="tname" value="<%=tname%>">
				<tr height=30> 
					<td align="left">
						<select name="search_key" valign='absmiddle' cols='20'>
						<option value="e_title"> 제목 </option>				
						<option value="e_contents"> 내용 </option>	
						<option value="dealer_name"> 거래처 </option>								
						<option value="m_name"> 사원명 </option>
						</select>
						<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><span onClick="board_search('frm_board');"><img src="/images/button/btn_search01.gif" align='absmiddle' border=0></span>
					</td>	
					<td>
						<select name="s_dealer_code" style="width:110px;" onchange="submit();">
						<option value="">:: 거래처 선택::
						<%
						strSql = " select * from dealer_info where dealer_insu='Y' and dealer_view='Y' "
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

						<select name="s_charge_chk" style="width:110px;" onchange="submit();">
						<option value=""  <% If s_charge_chk="" Then %> selected <% End If %>>::정산상태::</option>
						<option value="A" <% If s_charge_chk="A" Then %> selected <% End If %>>미요청</option>
						<option value="B" <% If s_charge_chk="B" Then %> selected <% End If %>>재요청</option>
						<option value="C" <% If s_charge_chk="C" Then %> selected <% End If %>>정산요청</option>
						<option value="D" <% If s_charge_chk="D" Then %> selected <% End If %>>재발송</option>
						<option value="E" <% If s_charge_chk="E" Then %> selected <% End If %>>정산완료</option>
						<option value="F" <% If s_charge_chk="F" Then %> selected <% End If %>>지급보류</option>
						</select>
					</td>
				</tr>
				</form>	
				</table>
			</td>			
		</tr>
		</table>

		<table width="100%" cellspacing=1 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th width=30  class="head_Gray_TLB">No.</th>
			<th width=200 class="head_Gray_TLB">제  목</th>
			<th width=100 class="head_Gray_TLB">정산기간</th>
			<th width=50 class="head_Gray_TLB">종류</th>
			<th width=120 class="head_Gray_TLB">정산업체</th>
			<th width=80 class="head_Gray_TLB">사원</th>
			<th width=50  class="head_Gray_TLB">파일</th>
			<th width=60  class="head_Gray_TLB">정산금액</th>
			<th width=60 class="head_Gray_TLB">계산서</th>
			<th width=70  class="head_Gray_TLB">정산상태</th>
			<th width=70 class="head_Gray_TLB">등록일</th>
		</tr>
  <% 
  
  strSql = " select A.e_exact_idx, A.e_fname2_excel, A.tax_chk, A.e_title, A.e_contents, A.e_writeday, A.s_dealer_code,"
  strSql = strSql & " A.e_exact_type, C.m_name, "
  strSql = strSql & " A.tax_price_n, A.charge_gita1, A.charge_gongje, "
  strSql = strSql & "  B.dealer_name, e_charge_chk, e_exact_date1, e_exact_date2, A.e_fname1 "
  strSql = strSql & "	from exact_list A left outer "
  strSql = strSql & "		join dealer_info B ON A.s_dealer_code=B.dealer_code "
  strSql = strSql & "		left join emp_list C ON A.s_yuchi_m_id=C.m_id "
  strSql = stRSql & "		where 1=1 "

  if search_txt<>"" Then
	  If search_key="dealer_name" Then
		  strSql = stRSql & "	and (B."&search_key&" like '%"&search_txt&"%') "
	  ElseIf search_key="m_name" then
		  strSql = stRSql & "	and (C."&search_key&" like '%"&search_txt&"%') "
	  else
		  strSql = stRSql & "	and (A."&search_key&" like '%"&search_txt&"%') "
	  End if
  else            	
	  If s_dealer_code<>"" Then
		strSql = stRSql & "		and (A.s_dealer_code='"& s_dealer_code &"') "
	  End If
	  
	  If s_charge_chk<>"" Then
		strSql = stRSql & "		and (A.e_charge_chk='"& s_charge_chk &"') "
	  End If
	  
  end If



  strSql = strSql & "			order by A.e_exact_idx desc"  
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
		<tr height=30>
			<td class="list_LBR_center" colspan='11'> 글이 존재하지 않습니다.</td>	
		</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		e_exact_idx		= objRs("e_exact_idx") 
  		e_title			= objRs("e_title")
  		e_contents		= objRs("e_contents")
  		e_writeday		= objRs("e_writeday")
  		e_fname1		= objRs("e_fname1")
  		e_fname2		= objRs("e_fname2_excel")
		s_dealer_code1	= objRs("s_dealer_code")
		e_exact_date1	= objRs("e_exact_date1")
		e_exact_date2	= objRs("e_exact_date2")
		e_charge_chk	= objRs("e_charge_chk")
		tax_chk			= objRs("tax_chk")
		e_exact_type	= objRs("e_exact_type")						'정산종류 (협력점(Y), 개인정산(P))

		dealer_name		= objRs("dealer_name")
		m_name			= objRs("m_name")

		If e_exact_type="P" Then
			e_exact_type="<span class='blue'>개인</span>"
		Else
			e_exact_type="<span class='red'>업체</span>"
		End if
		
		tax_price_n		= money_chk(objRs("tax_price_n"))
		charge_gita1	= money_chk(objRs("charge_gita1"))
		charge_gongje	= money_chk(objRs("charge_gongje"))

		charge_price	= tax_price_n + charge_gita1

		If tax_chk="Y" Then
			tax_chk_txt		= "<span class='red'> 발행 </span>"
			charge_tax		= Fix(charge_price*0.1)
			charge_price	= Fix(charge_price+charge_tax)

		ElseIf tax_chk="P" Then
			tax_chk_txt		= "<span class='blue'> 원천세 </span>"
			charge_tax		= Fix(charge_price*0.033)			
			charge_price	= Fix(charge_price-charge_tax)
		Else
			tax_chk_txt		= "<span class='black'> 미발행 </span>"
			charge_price	= charge_price
		End if
		
		charge_price		= charge_price + charge_gongje

		If e_charge_chk = "A" Then
			e_charge_chk ="<span class='gray'>미요청</span>"
		ElseIf e_charge_chk="B" then
			e_charge_chk ="<span class='red'>재요청</span>"
		ElseIf e_charge_chk="C" then
			e_charge_chk ="<span class='blue'>정산요청</span>"
		ElseIf e_charge_chk="D" then
			e_charge_chk ="<span class='blue'>재발송</span>"
		ElseIf e_charge_chk="E" then
			e_charge_chk ="<span class='green'>정산완료</span>"
		ElseIf e_charge_chk="F" then
			e_charge_chk ="<span class='red'>지급보류</span>"
		End If
  		
  		'파일명에서 확장자 뽑기
  		if len(e_fname1)>0 then
			filepath1	= o_code&"/exact/"&left(e_fname1, InstrRev(e_fname1,"/"))  
  	    	filename1	= mid(e_fname1, InstrRev(e_fname1,"/")+1)  
  			strExt1		= ucase(Mid(e_fname1,Instr(e_fname1,".")+1))
			Ext_img1	= file_strExt_chk(strExt)
  		end If	


  		'파일명에서 확장자 뽑기
  		if len(e_fname2)>0 then
			filepath2	= o_code&"/exact/"&left(e_fname2, InstrRev(e_fname2,"/"))  
  	    	filename2	= mid(e_fname2, InstrRev(e_fname2,"/")+1)  
  			strExt2		= ucase(Mid(e_fname2,Instr(e_fname2,".")+1))
			Ext_img2	= file_strExt_chk(strExt2)
  		end If	

		if DateDiff("h",e_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if
  %>			  
		<tr height=30>
			<td class="list_LB_center"><%=i%></td>	
			<td class="list_LB_center">
				<a href="a_exact_regist.asp?e_exact_idx=<%=e_exact_idx%>&s_dealer_code=<%=s_dealer_code%>&page=<%=page%>&s_charge_chk=<%=s_charge_chk%>"><b><%=e_title%></b> <%=new1%></a></td>	
			<td class="list_LB_center"><%=e_exact_date1%> ~ <%=e_exact_date2%></td>	
			<td class="list_LB_center"><%=e_exact_type%></td>	
			<td class="list_LB_center"><%=dealer_name%></td>	
			<td class="list_LB_center"><%=m_name%></td>	
			<td class="list_LB_center">
				<% if len(e_fname2)>0 then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>"><img src="<%=Ext_img2%>" border=0></a>
				<% else %>&nbsp;<% end if %></td>	
			<td class="list_LB_center"><span class='red'><%=money_change(charge_price)%></span></td>	
			<td class="list_LB_center"><%=tax_chk_txt%></td>	
			<td class="list_LB_center"><%=e_charge_chk%></td>	
			<td class="list_LBR_center"><%=Left(e_writeday,10)%></td>	
		</tr>	          
  <% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
  %>		  
		</table>

		<div class="pagelist">
			<%
			mychoice=10
			link_url = "a_exact_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&s_dealer_code="&s_dealer_code&"&s_charge_chk="&s_charge_chk&"&"
			%>
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
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>