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
  StartTimer = Timer()
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)

  if ad_b_a_custom="N" then
	Alert_URL session_m_name &" 님은 고객 상담관리 권한이 없습니다. 관리자에게 문의하시기 바랍니다.","/main.asp"
	Response.end
  End If
  
  consult_type		= WORD_CHANGE(Request("consult_type"),20)
  today_chk			= WORD_CHANGE(Request("today_chk"),20)
  consult_status	= WORD_CHANGE(Request("consult_status"),20)

  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If

  If list_cnt="" Then	list_cnt="15"  End If

  %>   
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr height="400"> 
	<td valign='top' align='center'>
		
		<!------------------ 내용 시작  ------------------>
		
		<div class="sub_title"><img src="/images/common/sub01_t07.gif"></div>
		
		<form id="frm_custom_regist" name="frm_custom_regist" action="a_custom_goods_consult_list.asp" METHOD="POST"> 

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">	
		<tr>
			<td colspan='6' style="text-align:left;border-style:none;">
				<select name="Search_key">
				<option value="consult_bigo"> 상담내용 </option>
				<option value="m_name" > 상담자 </option>
				<option value="c_name" > 고객명 </option>
				</select>
				<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle' OnKeyUp="auto_enter_send('frm_custom_regist');"><img src="/images/button/btn_search01.gif" onClick="Search('frm_custom_regist');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
			</td>
			<td class='con3'>
				<select name="consult_type" onchange="submit();">
				<option value=""> 모두표시 </option>
				<option value="A" <% If consult_type="A" Then %> selected <% End If %>> 고객메모 </option>
				<option value="G" <% If consult_type="G" Then %> selected <% End If %>> 관리메모 </option>
				<option value="H" <% If consult_type="H" Then %> selected <% End If %>> 상부메모 </option>
				<option value="B" <% If consult_type="B" Then %> selected <% End If %>> 회신요청 </option>
				<option value="C" <% If consult_type="C" Then %> selected <% End If %>> 회신답변 </option>
				<option value="D" <% If consult_type="D" Then %> selected <% End If %>> 회신완료 </option>
				<option value="I" <% If consult_type="I" Then %> selected <% End If %>> 상부요청 </option>
				<option value="J" <% If consult_type="J" Then %> selected <% End If %>> 상부답변 </option>
				<option value="K" <% If consult_type="K" Then %> selected <% End If %>> VOC발생 </option>
				</select>
			</td>
		</tr>
		<tr height=30>             
			<td class="head" width="30">번호</td>
			<td class="head" width="80">상담자</td>
			<td class='head' width='100'>구분</td>
			<td class="head" width="80">고객명</td>
			<td class="head" width="600">상담/이력 내용</td>
			<td class="head" width="120">추진일정</td>
			<td class="head" width="120">상담일자</td>
		</tr>

  <%
  top_cnt = page * list_cnt
  strSql = " select  TOP " &top_cnt& " A.consult_idx, A.g_goods_idx, A.consult_type, C.c_name, " 
  strSql = strSql & "  A.consult_bigo, A.consult_date, A.consult_writeday , B.m_name "
  strSql1 = ""
  strSql1 = strSql1 & "		from customer_goods_consult A Left outer "
  strSql1 = strSql1 & "			join emp_list B ON A.consult_m_id=B.m_id" 
  strSql1 = strSql1 & "			Join customer_goods C ON A.g_goods_idx=C.g_goods_idx " 
  strSql1 = strSql1 & "				Where 1=1 "

  If Today_chk<>"" Then
	strSql1 = strSql1 & "					and year(A.consult_date)='"&Year(today_chk)&"'  "
	strSql1 = strSql1 & "					and month(A.consult_date)='"&Month(today_chk)&"'  "
	strSql1 = strSql1 & "					and day(A.consult_date)='"&Day(today_chk)&"'"
  End If
  
  If consult_type<>"" Then 
	strSql1 = strSql1 & "					and A.consult_type='"&consult_type&"'"				
  End If

  If search_txt<>"" Then
  
	If search_key="m_name" Then
		strSql1 = strSql1 & "				and (B.m_name like '%"&search_txt&"%')"
	End If

	If search_key="c_name" Then
		strSql1 = strSql1 & "				and (C.c_name like '%"&search_txt&"%')"
	End If
	
	If search_key="consult_bigo" Then
		strSql1 = strSql1 & "				and  A.consult_bigo like '%"&search_txt&"%'"
	End If

  End If
  
  strSql2 = ""
  strSql2 = strSql2 & "						order by A.consult_idx desc "
  strSql = strSql & strSql1 & strSql2
  'response.write strSql
  objRs.PageSize = list_Cnt
  objRs.Open strSql, objCnn, 1
	
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=25>
			<td class="con5"  colspan="7" align='center'>
				상담글이 존재하지 않습니다.
			</td>
		</tr>
  <%
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page
  recordcount	= objRs.recordcount  
  		 
  i = 1
  Do until objRs.EOF Or i>objRs.PageSize   
  		consult_idx			= objRs("consult_idx")
		g_goods_idx			= objRs("g_goods_idx")
	  	emp_name			= objRs("m_name")
  		consult_type1		= objRs("consult_type")
  		consult_bigo		= objRs("consult_bigo")
		consult_date		= objrs("consult_date")
  		consult_writeday	= objRs("consult_writeday")
		c_name				= objRs("c_name")


		If Len(Minute(consult_date))=1 Then
			consult_date_minute = "0"&Minute(consult_date)
		Else
			consult_date_minute = Minute(consult_date)		
		End If
		
		If Len(Hour(consult_date))=1 Then
			consult_date_Hour = "0"&Hour(consult_date)
		Else
			consult_date_Hour = Hour(consult_date)		
		End If
		
		If consult_date<>"" then
			consult_date		= left(consult_date,10)&"&nbsp;"&consult_date_Hour&":"&consult_date_minute
		Else
			consult_date = ""
		End If
		
		consult_type_txt	= fnc_consult_txt(consult_type1)

		if DateDiff("h",consult_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end If
		
%>			  
		<tr height=28>
			<td class="con5"><%=i%></td>
			<td class="con4"><%=emp_name%></a></td>
			<td class='con4'><%=consult_type_txt%>&nbsp;</td>
			<td class="con4">
				<a href="/customer/a_custom_goods_regist.asp?g_goods_idx=<%=g_goods_idx%>"><%=Left(c_name,3)%></a></td>
			<td class="con2"> <%=consult_bigo%><%=new1%>	</td>			
			<td class="con4"><%=consult_date%>&nbsp;</td>
			<td class="con4"><%=Left(consult_writeday,10)%>&nbsp;<%=Hour(consult_writeday)%>:<%=Minute(consult_writeday)%></td>
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
			
			strSql = "select count(A.g_goods_idx) " & strSql1
			Set objRs=objCnn.Execute(strSql)

			recordcount = objRs(0) 

			totalpage = int((recordCount-1)/list_Cnt)+1

			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "a_custom_goods_consult_list.asp?today_chk="& today_chk &"&consult_type="&consult_type&"&search_key="&search_key&"&search_txt="&search_txt&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> 건 ] </span></b>
  <% 
  endTimer = Timer() 
  runtimer = endTimer - StartTimer
  response.write "&nbsp;&nbsp;&nbsp;&nbsp;<span style='color:white;font-size:11px;'>["& FormatNumber(runtimer, 3)&" sec] </span>" 
  %> 
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>