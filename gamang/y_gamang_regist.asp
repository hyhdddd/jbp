  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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

  if ad_g_y_gamang="N" then
 	Alert_URL session_m_name &" ���� ���������� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	

  c_m_gamang_idx	= WORD_CHANGE(Request("c_m_gamang_idx"),20)
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  page				= WORD_CHANGE(Request("page"),20)

  if c_m_gamang_idx<>"" then
  	strSql="select * from customer_gamang where c_m_gamang_idx="&c_m_gamang_idx
  	set objRs=objCnn.Execute(strSql)
  		
  	if objRs.eof or objRs.bof Then
	else
  		c_m_name			= objRs("c_m_name")
  		c_m_sex				= objRs("c_m_sex")
		c_m_course_idx		= objRs("c_m_course_idx")
		c_m_jumin1			= objRs("c_m_jumin1")
		c_m_jumin2			= objRs("c_m_jumin2")
		c_m_zipcode1		= objRs("c_m_zipcode1")
		c_m_zipcode2		= objRs("c_m_zipcode2")
		c_m_address			= objRs("c_m_address")
		c_m_htel1			= objRs("c_m_htel1")
		c_m_mtel1			= objRs("c_m_mtel1")  	
  		c_m_use_goods1		= objRs("c_m_use_goods1")
  		c_m_use_goods2		= objRs("c_m_use_goods2")
  		c_m_use_goods3		= objRs("c_m_use_goods3")
  		c_m_use_goods4		= objRs("c_m_use_goods4")
  		c_m_use_goods1_gita	= objRs("c_m_use_goods1_gita")
  		c_m_use_goods2_gita	= objRs("c_m_use_goods2_gita")
  		c_m_use_goods3_gita	= objRs("c_m_use_goods3_gita")
  		c_m_use_goods4_gita	= objRs("c_m_use_goods4_gita") 	
  		c_m_goods			= objRs("c_m_goods")
  		c_m_content			= objRs("c_m_content")			
  	end if
  Else
	  	c_m_sex		= "M"	
  end if
  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
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
	function board_del_ok(url)
	{
		ans=confirm("�������� �����ϸ� ���� ���� �������� �̷������� ��� �����˴ϴ�. \n\n �����ϰ� �����ϼ���! \n\n����ǰ�� �����Ͻðڽ��ϱ�? ");
		if(ans==true)
		{
			location.replace(url);
		}
	}

	function custom_consult_reply(form_name)
	{
		var frm=eval("document.all."+form_name);

		if(frm.consult_bigo.value=="")
		{
			alert("������ �Է��� �ּ���!");
			frm.consult_bigo.focus();
			return;
		}

		frm.action="y_gamang_consult_ok.asp";
		frm.submit();
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

		<!------------------ ���� ����  ------------------>  

		<div class="sub_title"><img src="/images/common/sub02_t05.gif"></div>

		<form action="y_gamang_regist_ok.asp" method="post" name="frm_gamang"> 
		<input type="hidden" name="c_m_gamang_idx" value="<%=c_m_gamang_idx%>">
		<input type="hidden" name="chk" value="<%=chk%>">
		<input type="hidden" name="c_m_m_id" value="<%=session_m_id%>">
		<table width=100% border=0 id="board_table3">							
		<tr>
			<th width=150> �� �� �� </th>
			<td width=250 colspan='3'> 
				<input type="text" class="txtbox" name="c_m_name" size="15"  value="<%=c_m_name%>"></td>
		</tr>
		<Tr>
			<th> �� �� </th>
			<td> 
				<input type="radio" name="c_m_sex" size="15"  value="M" style="border-style:none;" <% if c_m_sex="M" then %> checked <% end if %>>�� &nbsp;
				<input type="radio" name="c_m_sex" size="15"  value="F" style="border-style:none;" <% if c_m_sex="F" then %> checked <% end if %>>��
			</td>
			<th> �ֹι�ȣ</th>
			<td>
				<input type="text" name="c_m_jumin1" class="txtbox" value="<%=c_m_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_gamang','c_m_jumin2'); fncNextFocus(this,6,'frm_gamang','c_m_jumin2');">- 
				<input type="text" name="c_m_jumin2" class="txtbox" value="<%=c_m_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_gamang','c_m_zipcode1'); fncNextFocus(this,7,'frm_gamang','c_m_zipcode1');">
				</td>	
		</tr>
		<tr>
			<th>��ġ��� </th>
			<td colspan='3'>
				<input type="text" id="c_m_zipcode1" name="c_m_zipcode1" class="txtbox" value="<%=c_m_zipcode1%>" size="6" maxlength="6"  style="ime-mode:disabled;"  readonly>
				<input type="text" class="txtbox" id="c_m_address" name="c_m_address" value="<%=c_m_address%>"  size="60" maxlength="60" onFocus="FocusColor(this);" ><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('c_m_zipcode1','c_m_address');">
			</td>
		</tr>	
		<tr>
			<th> ��&nbsp;&nbsp;&nbsp;&nbsp;ȭ </th>
			<Td> 
				<input type="text" name="c_m_htel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=c_m_htel1%>" ></td>
			<th> �� �� �� </th>
			<Td> 
				<input type="text" name="c_m_mtel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=c_m_mtel1%>" >
			</td>
		</tr>
		<tr> 
			<th>�������<br>��ǰ����</td>
			<td colspan='3'> 
				<table width=100% border=0>
				<Tr>
					<td align='left' class="box">
					��ǰ�� <input type="text" size=15 class="txtbox" name="c_m_use_goods1" value="<%=c_m_use_goods1%>" > 
					����<input type="text" size=40 class="txtbox" name="c_m_use_goods1_gita" value="<%=c_m_use_goods1_gita%>" >
					</td>
				</tr>
				<Tr>
					<td align='left' class="box">��ǰ��
						<input type="text" size=15 class="txtbox" name="c_m_use_goods2" value="<%=c_m_use_goods2%>" >
						����<input type="text" size=40 class="txtbox" name="c_m_use_goods2_gita" value="<%=c_m_use_goods2_gita%>" >
					</td>
				</tr>
				<Tr>
					<td align='left' class="box">��ǰ��
						<input type="text" size=15 class="txtbox"  name="c_m_use_goods3" value="<%=c_m_use_goods3%>" >	
						����<input type="text" class="txtbox" size=40 name="c_m_use_goods3_gita" value="<%=c_m_use_goods3_gita%>" >
					</td>
				</tr>
				<Tr>
					<td align='left' class="box">��ǰ��
						<input type="text" class="txtbox" size=15 name="c_m_use_goods4" value="<%=c_m_use_goods4%>" >
						����<input type="text" class="txtbox"  size=40 name="c_m_use_goods4_gita" value="<%=c_m_use_goods4_gita%>" >
					</td>
				</tr>
				</table>                  				
			</td>
		</tr>
		<tr>
			<th> �� �� ǰ </th>
			<Td colspan='3'> 
				<input type="text" name="c_m_goods" class="txtbox"  size="40" value="<%=c_m_goods%>"  onFocus="FocusColor(this);"></td>
		</tr>
		<tr>
			<th> ��Ÿ ���� </th>
			<Td colspan='3'><textarea name="c_m_content" rows="6" cols="130" class="txtbox"><%=c_m_content%></textarea></td>
		</tr>
		<% If c_m_gamang_idx="" Or IsNull(c_m_gamang_idx) Then %>
		<tr height="30">
			<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;�� �̷� �׸� </td>
		</tr>
		<tr>
			<th>��������</th>
			<td>
				 <input type="text" class="txtbox" name="consult_date" size='10' value="" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=consult_date&code2=&code3=&form_name=frm_gamang','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="consult_date_hour">								 
				<option value="00"  selected >00��</option>
				<option value="01">01��</option>
				<option value="02">02��</option>
				<option value="03">03��</option>
				<option value="04">04��</option>
				<option value="05">05��</option>	
				<option value="06">06��</option>
				<option value="07">07��</option>
				<option value="08">08��</option>
				<option value="09">09��</option>
				<option value="10">10��</option>
				<option value="11">11��</option>
				<option value="12">12��</option>
				<option value="13">13��</option>
				<option value="14">14��</option>
				<option value="15">15��</option>
				<option value="16">16��</option>
				<option value="17">17��</option>
				<option value="18">18��</option>
				<option value="19">19��</option>
				<option value="20">20��</option>
				<option value="21">21��</option>
				<option value="22">22��</option>
				<option value="23">23��</option>
				</select>
				<select name="consult_date_minute">								    
				<option value="00" selected >00��</option>								   
				<option value="10">10��</option>
				<option value="20">20��</option>
				<option value="30">30��</option>
				<option value="40">40��</option>
				<option value="50">50��</option>								  
				</select>
			</td>			
		</tr>
		<tr>
			<th>�̷� ����</th>
			<td colspan='3'>
				<textarea name="consult_bigo" rows=4 class="txtbox" cols=130></textarea>
			</td>
			
		</tr>
		<% End If %>
		</table>
		<div class="button">				
			<% If c_m_gamang_idx<>"" Then %>
				<% if ad_g_y_gamang="E" or ad_g_y_gamang="A" then %>
					<img src="/images/button/btn_save.gif" border="0" align='absmiddle' onClick="p_gamang_regist('frm_gamang');" onmouseover="this.style.cursor='hand';">
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� ���� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif"  border="0"  align='absmiddle'></a>
				<% End If %>
				
				<a href="javascript:board_del_ok('y_gamang_regist_del.asp?c_m_gamang_idx=<%=c_m_gamang_idx%>')"><img src="/images/button/btn_delete.gif"  border="0" align='absmiddle'></a> 

			<% Else %>
				<% if ad_g_y_gamang="W" Or ad_g_y_gamang="E" or ad_g_y_gamang="A" then %>
					<img src="/images/button/btn_save.gif" border="0" align='absmiddle' onClick="p_gamang_regist('frm_gamang');" onmouseover="this.style.cursor='hand';">		
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� ��������� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif"  border="0"  align='absmiddle'></a>
				<% End If %>
			<% End If %>						
			<a href="y_gamang_list.asp?search_key=<%=search_key%>&search_txt=<%=search_txt%>&page=<%=page%>"><img src="/images/button/btn_list.gif" border=0 align='absmiddle'></a>
		</div>

		<% If c_m_gamang_idx<>"" Then %>
		<span id="spanRight" style="border-right: 1px solid #C7C7C7;width:1000;height:180;overflow-y:scroll;">
		<table width=100% border=0 cellspacing="1" cellpadding="0" id="board_table2">
		<tr height="30">
			<td colspan='6' class='con9' style='text-align:left;'>&nbsp;&nbsp; * �� �̷� </b></td>
		</tr>
		<tr>
			<td class='head' width='30'>No.</td>
			<td class='head' width='80'>����</td>
			<td class='head' width='100'>�ۼ���</td>
			<td class='head' width='500'>����</td>
			<td class='head' width='100'>��������</td>
			<td class='head' width='100'>�ۼ���</td>
		</tr>
<%
  strSql = " select A.consult_idx, A.c_m_gamang_idx, A.consult_type, A.consult_date, A.consult_bigo, A.consult_writeday, "
  strSql = strSql & " B.m_name as m_name "
  strSql = strSql & "		from customer_gamang_consult A left outer "
  strSql = stRSql & "			join emp_list B ON A.consult_m_id=B.m_id "
  strSql = strSql & "				where A.c_m_gamang_idx='"&c_m_gamang_idx&"'"
  strSql = strSql & "						order by A.consult_idx desc "
  'Response.write strSQl
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height='30'>
			<td class='con5' colspan='6'>��ϵ� �̷��� �������� �ʽ��ϴ�.</td>			
		</tr>		
  <%	
  else

	i = 1				
	Do until objRs.EOF 	
		consult_idx			= objRs("consult_idx")
		consult_type		= objRs("consult_type")
		consult_date		= objRs("consult_date")

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
		End if

		m_name				= objRs("m_name")		
		consult_type_txt	= fnc_consult_txt(consult_type)
		consult_bigo		= objRs("consult_bigo")
		consult_writeday	= objRs("consult_writeday")
		consult_writeday	= left(consult_writeday,10)&"&nbsp;"&Hour(consult_writeday)&":"&Minute(consult_writeday)

%>	
		<tr height="25">
			<td class='con5'><%=i%></td>
			<td class='con4'><%=consult_type_txt%>&nbsp;</td>
			<td class="con4"><%=m_name%></td>
		    <td class='con2'><%=consult_bigo%></td>
			<td class="con4"><%=consult_date%></td>
			<td class="con4"><%=consult_writeday%></td>
		</tr>
	
  <% 
			objrs.MoveNext
			i=i+1 
		loop
		objRs.close
  End if			
	%>	

		</table>
		</span>

		<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table2" style="border-top: 1px solid #C7C7C7;">
		<tr height="30">
			<td colspan='5' class='head' style='text-align:left;'>&nbsp;&nbsp; * �̷� ��� </b></td>
		</tr>
		<tr>
			<td class='head' width='100'>��㱸��</td>
			<td class='con1'  width='350'>
				<select name="consult_type">
					<option value="A"> ���޸� </option>
					<option value="F"> ó������ </option>
				</select>
			</td>
			<td class='head'  width='100'>��������</td>
			<td class='con1'  width='350'>
				 <input type="text" class="txtbox" name="consult_date" size='10' value="" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=consult_date&code2=&code3=&form_name=frm_gamang','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="consult_date_hour">								 
				<option value="00"  selected >00��</option>
				<option value="01">01��</option>
				<option value="02">02��</option>
				<option value="03">03��</option>
				<option value="04">04��</option>
				<option value="05">05��</option>	
				<option value="06">06��</option>
				<option value="07">07��</option>
				<option value="08">08��</option>
				<option value="09">09��</option>
				<option value="10">10��</option>
				<option value="11">11��</option>
				<option value="12">12��</option>
				<option value="13">13��</option>
				<option value="14">14��</option>
				<option value="15">15��</option>
				<option value="16">16��</option>
				<option value="17">17��</option>
				<option value="18">18��</option>
				<option value="19">19��</option>
				<option value="20">20��</option>
				<option value="21">21��</option>
				<option value="22">22��</option>
				<option value="23">23��</option>
				</select>
				<select name="consult_date_minute">								    
				<option value="00" selected >00��</option>								   
				<option value="10">10��</option>
				<option value="20">20��</option>
				<option value="30">30��</option>
				<option value="40">40��</option>
				<option value="50">50��</option>								  
				</select>
			</td>
			<td rowspan='2' class='con4' width="100"> 
				<span onclick="custom_consult_reply('frm_gamang');"><img src="/images/button/btn_consult_regist.gif" align='absmiddle'></span>
			</td>
		</tr>
		<tr>
			<td class='head'>����</td>
			<td class='con1' colspan='3'>
				<textarea name="consult_bigo" rows=4 class="txtbox" cols=130></textarea>
			</td>
			
		</tr>
		</table>
		<% End If %>
							
		</form>
		<!------------------ ���� ����  ------------------>        	
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
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>

