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
	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if

  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  option_idx		= WORD_CHANGE(Request("option_idx"),20)
  
  if article_idx<>"" then
  	strSql = " select article_idx,article_name, article_step1 from code_article where article_idx='"&article_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	article_name2		= objRs("article_name")
	article_step1		= objRs("article_step1")

	strSql = " select article_name from code_article where article_idx="&article_step1
	Set objRs=objCnn.Execute(strSql)

	article_name1		= objRs("article_name")
  end if	
  

  If option_idx<>"" Then
	strSql = " select option_idx, option_name,option_view,option_set from code_article_option where option_idx='"&option_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	option_name		= objRs("option_name")  
	option_view		= objRs("option_view")
	option_set		= objRs("option_set")
  Else
	option_view		= "Y"
	option_set		= "A"
  End if

  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script language="Javascript">
<!--
	function option_del(option_idx,article_idx)
	{
		ans=confirm(" ��ǰ �ɼ��� �����Ͻðڽ��ϱ�? \n\n �ɼ��� �����Ͻø� ��ǰ������ �ٲ�� ������ �����ϰ� �����ϼ���!");
		if(ans==true)
		{
			location.href="option_del_ok.asp?option_idx="+option_idx+"&article_idx="+article_idx
		}
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

		<form name="frm_option" Method="POST" action="option_regist_ok.asp">
		<input type="hidden" name="option_idx" value="<%=option_idx%>">
		<input type="hidden" name="article_idx" value="<%=article_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">						
		<tr height=30> 
			<th width="130">��з�</th>
			<td width="870"><%=article_name1%></td>	
		</tr>
		<tr height=30> 
			<th>�ߺз�</th>
			<td><%=article_name2%>	
		</tr>
		<tr height=30> 
			<th>�ɼ��̸�</th>
			<td>
				<input type="text" name="option_name" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=option_name%>" size=40>
				
				&nbsp;&nbsp;
				<input type="radio" name="option_view" value="Y" <% If option_view="Y" Or option_view="" Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
				<input type="radio" name="option_view" value="N" <% If option_view="N"  Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;		
			</td>
		</tr>
		<tr height=30> 
			<th>ǥ�� ��Ʈ</th>
			<td>					
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="option_set" value="A" <% If option_set="A" Or option_set="" Then %> checked <% End If %>>�ܵ�&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="option_set" value="B" <% If option_set="B" Then %> checked <% End If %>>����(DPS/TPS)&nbsp;&nbsp;&nbsp;		
				<input type="radio" name="option_set" value="C" <% If option_set="C" Then %> checked <% End If %>>����(�ܵ�/DPS/TPS)&nbsp;&nbsp;&nbsp;		
			</td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<a href="option_list.asp?article_idx=<%=article_idx%>">
				<img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a>
				<img src="/images/button/btn_save.gif" border="0" onclick="send_option();" align='absmiddle'>
				<a href="article_list.asp?article_idx=<%=board_idx%>">
				<img src="/images/button/btn_article_list.gif" border=0 align='absmiddle'></a>							
			</td>	
		</tr>
		</table>				
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>��  ȣ</td>
			<td class="head" width=700>��ǰ �ɼ�</td>
			<td class="head" width=100>��Ʈǥ��</td>
			<td class="head" width=100>ǥ��</td>
			<td class="head" width=80>����</td>
		</tr>

  <% 
  strSql = " select * from code_article_option where article_idx="&article_idx&" order by option_order Asc"
  Set objRs=objCnn.Execute(strSql)
	
  if objRs.BOF or objRs.EOF then
  %>
		<tr height=30>
			<td colspan='3' align='center' class="table_list3">
				�ڵ尡 �������� �ʽ��ϴ�.
			</td>
		</tr>
  <%  		 
  else
	i = 1
	Do until objRs.EOF   	
  		option_idx		= objRs("option_idx")
	  	option_name		= objRs("option_name")
		option_view		= objRs("option_view")
		option_set		= objRs("option_set")

		If option_view="Y" Then 
			option_view="<span class='red'>����</span>"
		Else
			option_view="<span class='blue'>����</span>"
		End If
		
		option_set_txt = fnc_option_set(option_set)
%>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con2">
				<a href="option_list.asp?article_idx=<%=article_idx%>&option_idx=<%=option_idx%>"><%=option_name%></a></td>
			<td class="con4"><%=option_set_txt%></td>
			<td class="con4"><%=option_view%></td>
			<td class="con4">
				<% If ad_c_code="A" Then %>
					<a href="javascript:option_del('<%=option_idx%>','<%=article_idx%>');"> <img src="/images/button/btn_delete.gif" border="0" align='absmiddle'> </a>
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%>���� ���� ������ �����ϴ�. �����ڸ� ���� �Ͻ� �� �ֽ��ϴ�!");'><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></a>
				<% End If %>
			</td>
		</tr>

  <% 
		objrs.MoveNext
		i=i+1 
   	loop
  end if					
  objRs.close
  %>   
		</table>
		</form>
	</td>
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>