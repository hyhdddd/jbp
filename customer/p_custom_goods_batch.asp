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
 
  g_goods_idx		=WORD_CHANGE(request("g_goods_idx"),20)

  If g_goods_idx="" Then
	Response.end
  End If
  
  strSql = "select g_file1, g_file2, g_file3, g_file4 from customer_goods where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  If objrs.eof Or objRs.bof Then
	Alert "잘못된 접근입니다. 관리자에 문의하세요!"
	Response.End
  Else
		g_file1				= objRs("g_file1")		
		g_file2				= objRs("g_file2")
		g_file3				= objRs("g_file3")
		g_file4				= objRs("g_file4")

		if len(g_file1)>0 then
			filepath1 = o_code &"/customer/"&left(g_file1, InstrRev(g_file1,"/"))  
  	    	filename1 = mid(g_file1, InstrRev(g_file1,"/")+1)  
  		end If
		if len(g_file2)>0 Then
			filepath2 = o_code &"/customer/"&left(g_file2, InstrRev(g_file2,"/"))  
  	    	filename2 = mid(g_file2, InstrRev(g_file2,"/")+1)  
  		end If
		if len(g_file3)>0 Then
			filepath3 = o_code &"/customer/"&left(g_file3, InstrRev(g_file3,"/"))  
  	    	filename3 = mid(g_file3, InstrRev(g_file3,"/")+1)  
  		end If
		if len(g_file4)>0 then
			filepath4 = o_code &"/customer/"&left(g_file4, InstrRev(g_file4,"/"))  
  	    	filename4 = mid(g_file4, InstrRev(g_file4,"/")+1)  
  		end If
  End if

  %>
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function batch_submit(form_name)
	{
		var frm=eval("document.all."+form_name);

		if(frm.g_file1.value=="" && frm.g_file2.value=="" && frm.g_file3.value=="" && frm.g_file4.value=="")
		{
			alert(" 첨부파일 하나 이상을 선택해 주세요!");
			return;
		}
		ans=confirm("저장하시겠습니까?")
		if(ans==true)
		{
			frm.submit();
		}
	}
-->
</script>

<div class="sub_title"><img src="/images/common/sub01_t10.gif"></div>

<form id="frm_custom" name="frm_custom" action="p_custom_goods_batch_ok.asp" METHOD="POST"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST"> 
<input type="hidden" name="g_goods_idx" value="<%=g_goods_idx%>">

<table width=400 border=0 cellspacing="0" cellpadding="0" id="board_table3">

		<tr> 
			<th width="100">첨부파일1</th>
			<td width="300"> 
				<input type="file" name="g_file1" size="30" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);this.select();"><Br>
				<% If Len(g_file1)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
				<% End If %>
			</td>
		</tr>
		<tr> 
			<th> 첨부 파일2 </th>
			<td> 
				<input type="file" name="g_file2" size="30" class="txtbox" onBlur="BlurColor(this)" 
			onFocus="FocusColor(this);this.select();"><Br>
				<% If Len(g_file2)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>"><%=filename2%></a>
				<% End If %>
			</td>
		</tr>
		<tr> 
			<th> 첨부 파일3 </th>
			<td> 
				<input type="file" name="g_file3" size="30" class="txtbox" onBlur="BlurColor(this)" 
			onFocus="FocusColor(this);this.select();"><Br>
				<% If Len(g_file3)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename3%>&fpath=<%=filepath3%>"><%=filename3%></a>
				<% End If %>

			</td>
		</tr>
		<tr> 
			<th> 첨부 파일4 </th>
			<td> 
				<input type="file" name="g_file4" size="30" class="txtbox" onBlur="BlurColor(this)" 
			onFocus="FocusColor(this);this.select();"><Br>
				<% If Len(g_file4)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename4%>&fpath=<%=filepath4%>"><%=filename4%></a>
			<% End If %>
			</td>
		</tr>
<tr height="30">
	<td colspan='2' align='center'>
		<img src="/images/button/btn_save.gif" border=0 onclick="batch_submit('frm_custom');">
	</td>
</tr>
</tr>				
</table>
