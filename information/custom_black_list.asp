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

  if ad_c_black="N" then
	Alert_url session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if
  
  black_idx			= WORD_CHANGE(Request("black_idx"),20)
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  
  if black_idx<>"" then
  	strSql = " select black_name, black_jumin1, black_jumin2, black_type, black_bigo,black_tel1 from customer_goods_black "
	strSql = strSql & " where black_idx="&black_idx&" "
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		course_code	= ""
	else
		black_name			= objRs("black_name")
		black_jumin1		= objRs("black_jumin1")
		black_jumin2		= objRs("black_jumin2")
		black_tel1			= objRs("black_tel1")
		black_type			= objRs("black_type")
		black_bigo			= objRs("black_bigo")
	End If
	
	objRs.close
  Else
	black_type = "A"
  end if	
  
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function black_del(code)
	{
		ans=confirm("블랙리스트 고객을 지우시겠습니까? ");
		if(ans==true)
		{
			location.href="custom_black_del_ok.asp?black_idx="+code
		}
	}

	function black_search(form_name)
	{
		var frm=eval("document.all."+form_name);

		if(frm.search_txt.value=="")
		{
			alert("검색어를 입력해 주세요!")
			return;
		}
		
		search_key = frm.search_key.value;
		search_txt = frm.search_txt.value;

		location.href="custom_black_list.asp?search_txt="+search_txt+"&search_key="+search_key;
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
		
		<div class="sub_title"><img src="/images/common/sub15_t01.gif"></div>

		<form name="frm_black" Method="POST" action="custom_black_regist_ok.asp">
		<input type="hidden" name="black_idx" value="<%=black_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
			<td colspan='2' class="description">
				* 고객 블랙리스트를 관리 하는 메뉴 입니다. <br>
				* 고객명과 주민등록번호를 이용해서 관리할 수 있습니다. <br>
				<span class='red'>* 주의, 경고 등급은 고객등록은 되나, 주의/경고 표시가 되며, 불량고객은 고객등록이 거부됩니다. (주민번호 비교) </span> <br>
			</td>
		</tr>
		<tr height=25> 
			<th width="130">고객명</th>
			<td width="870">
					<input type="text" class="txtbox" maxlength=4 name="black_name"  onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=black_name%>">	
		</tr>
		<tr height=30> 
			<th>주민번호</th>
			<td>
				<input type="text" name="black_jumin1" class="txtbox" value="<%=black_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_black','black_jumin2'); fncNextFocus(this,6,'frm_black','black_jumin2');" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();">-<input type="text" name="black_jumin2" class="txtbox" value="<%=black_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();">
			</td>
		</tr>
		<tr height=30> 
			<th>전화번호</th>
			<td>
				<input type="text" name="black_tel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=black_tel1%>" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">
				<font color="blue"> * 010-000-0000 </font>
			</td>
		</tr>
		<tr height=30> 
			<th>등급</th>
			<td>
				<select name="black_type">
					<option value="A" <% If black_type="A" Then %> selected <% End If %>>::주의::</option>
					<option value="B" <% If black_type="B" Then %> selected <% End If %>>::경고::</option>
					<option value="C" <% If black_type="C" Then %> selected <% End If %>>::불량::</option>
				</select>
			</td>
		</tr>
		<tr height='30'>
			<th> 사유 </th>
			<td>
				<textarea name="black_bigo" rows=4 class="txtbox" cols=130><%=black_bigo%></textarea>
			</td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_black="W" or ad_c_black="E" or ad_c_black="A" then %>
					<a href="custom_black_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
				<% else %>
					<a href ='javascript:alert("<%=session_name%> 님은 접수경로 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_c_black="W" or ad_c_black="E" or ad_c_black="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_black();">
				<% else %>
					<a href ='javascript:alert("<%=session_name%> 님은 접수경로 코드 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>       	
	
				<% If black_idx<>"" Then %>
					<% if ad_c_black="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="black_del('<%=black_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> 님은 접수경로코드 삭제권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>				
				</td>	
		</tr>
		</table>				
	
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height="30"> 
			<td colspan='6' class='con2' style='border-style:none'>		  					
				<select name="search_key" valign='absmiddle' class="txtbox" >
					<option value="black_name"> 고객명 </option>	
					<option value="black_tel1"> 전화번호 </option>								
					<option value="black_jumin1"> 주민번호(앞) </option>								
					<option value="black_jumin2"> 주민번호(뒤) </option>								
				</select><input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><img src="/images/button/btn_search01.gif" onClick="black_search('frm_black');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
			</td>
		</tr>
		<tr height=30>             
			<td class="head" width=50>번  호</td>
			<td class="head" width=200>고객명</td>
			<td class="head" width=250>주민번호</td>
			<td class="head" width=200>전화번호</td>
			<td class="head" width=200>종류</td>
			<td class="head" width=200>작성일</td>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select * from customer_goods_black where 1=1 "


  If search_txt<>"" then
	strSql = strSql & "			and  "&search_key&" like '%"&search_txt&"%'"
  End If

  strSql = strSql & "  order by black_idx desc "
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
  
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td colspan='5' align='center'>
				고객이 존재하지 않습니다.
			</td>
		</tr>
  <%
  else      		 
    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount

  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
  		black_idx			= objRs("black_idx")
  		black_name			= objRs("black_name")
  		black_jumin1		= objRs("black_jumin1")
  		black_jumin2		= objRs("black_jumin2")
  		black_tel1			= objRs("black_tel1")
  		black_type			= objRs("black_type")
		black_type_txt1		= black_type_txt(black_type)
  		black_writeday		= Left(objRs("black_writeday"),10)
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con4">
				<a href="custom_black_list.asp?black_idx=<%=black_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=black_name%></a></td>
			<td class="con4"><%=black_jumin1%>-<%=black_jumin2%></td>
			<td class="con4"><%=black_tel1%></td>
			<td class="con4"><%=black_type_txt1%></td>
			<td class="con4"><%=black_writeday%></td>
		</tr>
  <% 
		objRs.MoveNext
   		i=i+1 
    loop
   end if					
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
			link_url = "custom_black_list.asp?"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> 건 ] </span></b>
		</div>
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>