  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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

  if ad_c_code="N" then
	Alert_url session_m_name&" ���� ���������ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if
  
  gaetong_idx		= WORD_CHANGE(request("gaetong_idx"),20)
  
  if gaetong_idx<>"" then
  	strSql = " select gaetong_idx,gaetong_code, gaetong_name, gaetong_color, gaetong_writeday from code_gaetong "
	strSql = strSql & " where gaetong_idx="&gaetong_idx&" "
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		gaetong_code	= ""
	else
	gaetong_idx				= objRs("gaetong_idx")
  	gaetong_code			= objRs("gaetong_code")
  	gaetong_name			= objRs("gaetong_name")
	gaetong_color			= objRs("gaetong_color")
  	gaetong_writeday		= objRs("gaetong_writeday")
	End If
	
	objRs.close
  end if	
  
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
function code_gaetong_del(code)
{
	ans=confirm("�ڵ� ����ñ� ���ؼ��� �������� �ش��ϴ� �ڵ尡 ����� �մϴ�. \n\n �ڵ带 ����ðڽ��ϱ�? ");
	if(ans==true)
	{
		location.href="gaetong_del_ok.asp?gaetong_idx="+code
	}
}


function status_submit(form_name)
{
	var frm			= document.getElementById(form_name);
	var goods_idx	= document.getElementsByName("gaetong_default")


	chk="";
	for( var i=0; i<goods_idx.length; i++) 
	{
		if(goods_idx[i].checked==true)
		{
			chk="O";
		}
	}	
					
	if(chk=="O")
	{
		var ans=confirm(" ������ �ڵ带 ���� ó�� �Ͻðڽ��ϱ�?");

		if(ans==true)
		{
			frm.action="gaetong_status_ok.asp";
			frm.submit();
		}
	}
	else
	{
		alert(" �ڵ带 �Ѱ� �̻� ������ �ּ���!");
		return;
	}	
}


// �������� �ڵ� ���    
function send_gaetong1(form_name) 
{
	var frm			= document.getElementById(form_name);

	if(frm.gaetong_name.value.length==0)
	{
		alert("�������� �ڵ� ���� �Է��� �ּ���!");
		frm.gaetong_name.focus();
		return;
	}	
	if(frm.gaetong_color.value=="")
	{
		alert("������� ǥ�û����� ������ �ּ���!");
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
<tr bgcolor="#FFFFFF"  height='400'> 
	<td valign='top' align='center'>

		<!------------------ ���� ����  ------------------>    				

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">�ڵ���� </li>
		</ul>
		</div>

		<!--#include virtual="/include/asp/code_menu_list.asp"-->

		<form id="frm_gaetong" name="frm_gaetong" Method="POST" action="gaetong_regist_ok.asp">
		<input type="hidden" name="gaetong_idx" value="<%=gaetong_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
			<td colspan='2' class="description"><br>
				* ���������ڵ带 ���/���� �� �� �ִ� �޴� �Դϴ�.  <br>
				* ���������ڵ�� �������� ���� ���������� Ȯ���Ҽ� �ִ� ��Ͽ� ��Ÿ���ϴ�.<br>
			</td>
		</tr>				
		<tr height=30> 
			<th width='130'>�������� ��</th>
			<td width='870'>
				<input type="Text" class="txtbox" name="gaetong_name" size="30"  value="<%=gaetong_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);"></td>
		</tr>
		<tr height=30> 
			<th>ǥ�û���</th>
			<td>
				<input type="Text" class="txtbox" name="gaetong_color" size="30"  value="<%=gaetong_color%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);">
				<img src="/images/button/btn_color.gif" align='absmiddle' onclick="NewWindow('/include/asp/color_select.asp?code1=gaetong_color&form_name=frm_gaetong','color_select',400,380,'no');">
			</td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="gaetong_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>	
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>���� �������� �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_gaetong1('frm_gaetong');">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>���� �������� �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>       								
	
				<% If gaetong_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_gaetong_del('<%=gaetong_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%>���� �ڵ� ���������� �����ϴ�.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
				</td>	
		</tr>
		</table>				
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>��  ȣ</td>
			<td class="head" width=550>�������� ��</td>
			<td class="head" width=100>�������� ����</td>
			<td class="head" width=150>�ű����� �⺻����</td>
			<td class="head" width=150>��¼���</td>
			<td class="head" width=100>������</td>
		</tr>
  <%

  strSql = " select * from code_gaetong order by gaetong_order Asc"
  Set objRs = objCnn.Execute(strSql)
  
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td colspan='4' align='center' class="table_list3">
				�ڵ尡 �������� �ʽ��ϴ�.
			</td>
		</tr>
  <%
  else      		 

  	i = 1
  	Do until objRs.EOF 
  		gaetong_idx				= objRs("gaetong_idx")
  		gaetong_code			= objRs("gaetong_code")
  		gaetong_name			= objRs("gaetong_name")
  		gaetong_color			= objRs("gaetong_color")
  		gaetong_default			= objRs("gaetong_default")
		gaetong_order			= objRs("gaetong_order")
  		gaetong_writeday		= Left(objRs("gaetong_writeday"),10)
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con2">&nbsp;&nbsp;
				<a href="gaetong_list.asp?gaetong_idx=<%=gaetong_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=gaetong_name%></a></td>
			<td class="con4"><b><span style='color:<%=gaetong_color%>;'><%=gaetong_color%></span></b></td>
			<td class="con4">
				<input type="radio" name="gaetong_default" value="<%=gaetong_code%>" <% If gaetong_default="Y" Then %> checked <% End If %>></td>
			<td class="con4">
				<a href="gaetong_order_ok.asp?gaetong_idx=<%=gaetong_idx%>&gaetong_order=<%=gaetong_order%>&chk=U&page=<%=page%>"><img src='/images/button/btn_up.gif' border=0 align='absmiddle'></a>
				&nbsp;|&nbsp;
				<a href="gaetong_order_ok.asp?gaetong_idx=<%=gaetong_idx%>&gaetong_order=<%=gaetong_order%>&chk=D&page=<%=page%>"><img src='/images/button/btn_down.gif' border=0 align='absmiddle'></a>
			</td>
			<td class="con4"><%=gaetong_writeday%></td>
		</tr>

  <% 
		objRs.MoveNext
   		i=i+1 
    loop
  %>							
  <%
   end if					
%>   
		<tr height=30>
			<td class="con4"></td>
			<td class="con4"></td>
			<td class="con4"></td>
			<td class="con4"><img src="/images/button/btn_apply.gif" onclick="status_submit('frm_gaetong');"></td>
			<td class="con4"></td>
			<td class="con4"></td>
		</tr>
		</table>

		</form>
		<!------------------ ���� ����  ------------------>
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