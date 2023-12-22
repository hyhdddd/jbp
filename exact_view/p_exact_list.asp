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
  if ad_r_p_exact="N" then
 	Alert_back session_m_name &" 님은 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	

  tname		= "board_data2"
  search_key = WORD_CHANGE(request("search_key"),20)
  search_txt = WORD_CHANGE(request("search_txt"),20)

   
  timerStartTimer = Timer()
  PageSize=15
  	
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 


  strSql = " Select m_dealer_code from emp_list where m_id='"&Session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code		= objRs(0)
  objRs.close

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
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		
		<!------------------ 내용 시작  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">개인 정산내역서</li>
		</ul>
		</div>

		<table width="100%" cellspacing=1 cellpadding=0 border=0>
		<tr height=28>             
			<td align='left' colspan='3'>
				<table width="100%" cellspacing=0 cellpadding=0 border=0  id="board_table3">
				<form name='frm_board' method='post' action='y_exact_list.asp'>
				<input type="hidden" name="tname" value="<%=tname%>">
				<tr height=30> 
					<td align="left"  class="table_header2">
						<select name="search_key" valign='absmiddle' cols='10'>
							<option value="e_title"> 제목 </option>				
							<option value="e_contents"> 내용 </option>				
						</select>
						<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><span onClick="board_search('frm_board');"><img src="/images/button/btn_search01.gif" align='absmiddle' border=0></span>
					</td>	
				</tr>
				</form>	
					</table>
			</td>			
		</tr>
		</table>

		<table width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td width=50  class="head">No</td>
			<td width=350 class="head">제  목</td>
			<td width=150 class="head">정산기간</td>
			<td width=60  class="head">파일</td>
			<td width=60 class="head">계산서</td>
			<td width=80  class="head">정산요청</td>
			<td width=100 class="head">등록일</td>
		</tr>
  <% 
  strSql = " select A.e_exact_idx, A.e_m_id, A.e_title, A.e_contents, A.e_writeday, A.s_dealer_code, B.dealer_name, "
  strSql = strSql & "  A.exact_passwd, A.tax_chk,  A.tax_price_n, A.charge_gita1, A.charge_gongje, "
  strSql = strSql & " A.e_charge_chk, e_exact_date1, e_exact_date2, A.e_fname2_excel, A.e_fname1 from exact_list A left outer "
  strSql = strSql & "		join dealer_info B ON A.s_dealer_code=B.dealer_code "
  strSql = stRSql & "		where (A.s_yuchi_m_id='"&session_m_id&"') "
  strSql = strSql & "			order by A.e_exact_idx desc"  
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
		<tr height=30>
			<td class="con5" colspan='8'> 글이 존재하지 않습니다.</td>	
		</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		e_exact_idx		= objRs("e_exact_idx") 
		e_m_id			= objRs("e_m_id")
  		e_title			= objRs("e_title")
  		e_contents		= objRs("e_contents")
  		e_writeday		= objRs("e_writeday")
  		e_fname1		= objRs("e_fname1")
		s_dealer_code	= objRs("s_dealer_code")
		e_exact_date1	= objRs("e_exact_date1")
		e_exact_date2	= objRs("e_exact_date2")
		dealer_name		= objRs("dealer_name")
		e_charge_chk	= objRs("e_charge_chk")
  		e_fname2		= objRs("e_fname2_excel")
		exact_passwd	= objRs("exact_passwd")

		tax_chk			= objRs("tax_chk")

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
		End If
		
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
		End If
		
  		
  		'파일명에서 확장자 뽑기
  		if len(e_fname1)>0 then
			filepath1	= o_code&"/exact/"&left(e_fname1, InstrRev(e_fname1,"/"))  
  	    	filename1	= mid(e_fname1, InstrRev(e_fname1,"/")+1)  
  			strExt		= ucase(Mid(e_fname1,Instr(e_fname1,".")+1))
			Ext_img		= file_strExt_chk(strExt)
  		end If	

		if DateDiff("h",e_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end If


  		'파일명에서 확장자 뽑기
  		if len(e_fname2)>0 then
			filepath2	= o_code&"/exact/"&left(e_fname2, InstrRev(e_fname2,"/"))  
  	    	filename2	= mid(e_fname2, InstrRev(e_fname2,"/")+1)  
  			strExt2		= ucase(Mid(e_fname2,Instr(e_fname2,".")+1))
			Ext_img2	= file_strExt_chk(strExt2)
  		end If	
		
		
  %>			  
		<tr height=30>
			<td class="con5"><%=i%></td>	
			<td class="con2"><a href="p_exact_regist.asp?e_exact_idx=<%=e_exact_idx%>"><%=e_title%> <%=new1%></a></td>	
			<td class="con4"><%=e_exact_date1%> ~ <%=e_exact_date2%></td>	
			<td class="con4">
				<% if len(e_fname2)>0 then %>
				<span onmouseover="this.style.cursor='hand';" onclick='alert("내용보기에서 다운받을수 있습니다.");'><img src="<%=Ext_img2%>"></span>
				<% else %>&nbsp;<% end if %></td>	
			<td class="con4"><%=tax_chk_txt%></td>	
			<td class="con4"><%=e_charge_chk%></td>	
			<td class="con4"><%=Left(e_writeday,10)%></td>	
		</tr>	          
  <% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
  objRs.close
  %>		  
		</table>

		<div class="pagelist">
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "y_exact_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
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
