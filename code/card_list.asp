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
  if ad_c_code="N" then
	Alert_back session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if
  
  board_idx		= WORD_CHANGE(Request("board_idx"),20)
  
  if board_idx<>"" then
  	strSql = " select * from code_card where board_idx="&board_idx&" "
  	set objRs=objCnn.Execute(strSql)

	If objRs.eof or objRs.bof Then
		board_idx		= ""
	Else	
	  	card_name		= objRs("card_name")
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
	function code_card_del(code)
	{
		ans=confirm("�ڵ� ����ñ� ���ؼ��� ������ / �λ���� ������ ���õ� �ڵ带 ����ϰ� ���� �ʾƾ� �մϴ�. \n\n �ڵ带 ����ðڽ��ϱ�? ");
		if(ans==true)
		{
			location.href="card_del_ok.asp?board_idx="+code
		}
	}

	function send_card() 
	{
		frm=document.all.frm_card;

		if(frm.card_name.value=="")
		{
			alert("ī��縦 �Է��� �ּ���!");
			frm.card_name.focus();
			return false;
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


		<form name="frm_card" Method="POST" action="card_regist_ok.asp">
		<input type="hidden" name="board_idx" value="<%=board_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'> 
			<td colspan='2' class="description">
				&nbsp;&nbsp;* CMS���� ����ϴ� ī��� ���� ���/���� �� �� �ִ� �޴� �Դϴ�.   ������/�λ���� ��� ����ϰ� ������ ������ ���� �ʽ��ϴ�.
			</td>
		</tr>
		<tr height=30> 
			<th width="130">ī �� �� </th>
			<td width="870">
				<input type="Text" class="txtbox" name="card_name" size="30"  value="<%=card_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);">						
				</td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="card_list.asp">	
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'>
				<% end if %>      									
					<img src="/images/button/btn_new.gif" border="0"></a> 

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_card();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� �ڵ� ��� ������ �����ϴ�.");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>  

				<% If board_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_card_del('<%=board_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> ���� �ڵ� ���������� �����ϴ�.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>


			</td>	
		</tr>
		</table>				

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=100>��  ȣ</td>
			<td class="head" width=600>�� �� ��</td>
		</tr>

  <%

  strSql = " select * from code_card  order by card_name Asc"
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
		board_idx			= objRs("board_idx")
  		card_name			= objRs("card_name")
  %>	
		<tr height=30>             
			<td class="con5"><%=i%></td>
			<td class="con2">
				<a href="card_list.asp?board_idx=<%=board_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=card_name%></a></td>
		</tr>

  <% 
   		objrs.MoveNext
   		i=i+1 
   	loop
  end if	
  %>   
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