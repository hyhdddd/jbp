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

  article_step1		= WORD_CHANGE(request("article_step1"),20)
  article_step2		= WORD_CHANGE(request("article_step2"),20)
  promise_idx		= WORD_CHANGE(Request("promise_idx"),20)	
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  
  if article_idx<>"" then
  	strSql = " select article_idx,article_name, article_step1 from code_article where article_idx='"&article_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	article_name2		= objRs("article_name")
	article_step1		= objRs("article_step1")

	strSql = " select article_name from code_article where article_idx="&article_step1
	Set objRs=objCnn.Execute(strSql)

	article_name1		= objRs("article_name")
  end if	
  

  If promise_idx<>"" Then
	strSql = " select promise_idx, promise_name,promise_view, promise_policy from code_promise where promise_idx='"&promise_idx&"'"
  	Set objRs=objCnn.Execute(strSql)
  	
  	promise_name		= objRs("promise_name")  
	promise_view		= objRs("promise_view")
	promise_policy		= objRs("promise_policy")
  End if
  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script language="Javascript">
<!--
	function code_promise_del(promise_idx)
	{
		ans=confirm(" �ڵ带 �����Ͻðڽ��ϱ�? \n\n �����ϴ� �ڵ尡 ���������� ������ �ʾƾ� ������ �����մϴ�.");
		if(ans==true)
		{
			location.href="promise_del_ok.asp?promise_idx="+promise_idx
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

		<form name="frm_promise" Method="POST" action="promise_regist_ok.asp">
		<input type="hidden" name="article_idx" value="<%=article_idx%>">
		<input type="hidden" name="article_step1" value="<%=article_step1%>">
		<input type="hidden" name="article_step2" value="<%=article_step2%>">
		<input type="hidden" name="promise_idx" value="<%=promise_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">						
		<% If article_idx<>"" Then %>
		<tr height=30> 
			<th width="130">��з�</th>
			<td width="870"><%=article_name1%></td>	
		</tr>
		<tr height=30> 
			<th>�ߺз�</th>
			<td><%=article_name2%>	
		</tr>
		<tr height=30> 
			<th>���� �̸�</th>
			<td>
				<input type="text" name="promise_name" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=promise_name%>" size=40>	
				&nbsp;&nbsp;
				<input type="radio" name="promise_view" value="Y" <% If promise_view="Y" Or promise_view="" Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
				<input type="radio" name="promise_view" value="N" <% If promise_view="N" Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
		</tr>
		<tr height=30> 
			<th>��åǥ ����</th>
			<td>				
				<input type="radio" name="promise_policy" value="Y" <% If promise_policy="Y"  Then %> checked <% End If %>><span class='red'>����</span>&nbsp;&nbsp;&nbsp;
				<input type="radio" name="promise_policy" value="N" <% If promise_policy="N" Or promise_policy="" Or IsNull(promise_policy) Then %> checked <% End If %>><span class='blue'>������ </span>
				&nbsp;&nbsp;&nbsp; �ϳ��� ��ǰ�ڵ忡 �ϳ��� ������ ����˴ϴ�.&nbsp;&nbsp;&nbsp;
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<a href="promise_list.asp?article_idx=<%=article_idx%>"><img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a>
				<img src="/images/button/btn_save.gif" border="0" onclick="send_promise();" align='absmiddle'>

				<% If promise_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_promise_del('<%=promise_idx%>');" align='absmiddle'>
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%>���� �ڵ� ���������� �����ϴ�.");'><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></a> 
					<% end if %>  
				<% End If %>	

			</td>	
		</tr>
		<% End If %>
		<tr height='30'>
			<td colspan='2' class='con3' style='border-style:none'> 
				<a href="promise_order.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>				
		
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>��  ȣ</td> 
			<td class="head" width=500>�� ǰ ��</td> 
			<td class="head" width=100>��åǥ ����</td> 
			<td class="head" width=100>����/����</td> 
			<td class="head" width=150>���� ���</td> 
		</tr>
  <%
  strSql = " select * from code_article where article_step2=0 "
  strSql = strSql & " order by article_order asc"
  Set objRs=objCnn.Execute(strSql)
	
  if objRs.BOF or objRs.EOF Then
  %>
				<tr height=25>
					<td colspan='4' align='center' class="table_list3">
						�ڵ尡 �������� �ʽ��ϴ�.
					</td>
				</tr>
  <%
  else  		 
  	i = 1
  	Do until objRs.EOF   	
  		article_idx			= objRs("article_idx")
  		article_name		= objRs("article_name")
		article_step1		= objRs("article_step1")
		article_step2		= objRs("article_step2")  
		article_view		= objRs("article_view")


		If article_view="Y" Then 
			article_view="<span class='red'>����</span>"
		Else
			article_view="<span class='blue'>����</span>"
		End If
	%>
		<tr height=30>
			<td class="con5"><%=article_idx%></td>
			<td class="con2">
				&nbsp;<span style="color=#1604fe;">(ȸ��)<%=article_name%></span>
			</td>
			<td class="con4">	</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">&nbsp;</td>
		</tr>
<%
		strSql = " select * from  code_article where article_step2>0 and article_step1="&article_step1&" order by article_order asc"
		Set objRs1=objCnn.Execute(strSql)

		Do Until objRs1.eof

  		article_idx			= objRs1("article_idx")
  		article_name		= objRs1("article_name")
		article_step1		= objRs1("article_step1")
		article_step2		= objRs1("article_step2")
		article_view		= objRs1("article_view")

		If article_view="Y" Then 
			article_view="<span class='red'>����</span>"
		Else
			article_view="<span class='blue'>����</span>"
		End If

%>	
		<tr height=30>
			<td class="con5"><%=article_idx%></td>
			<td class="con2">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span style="color=#fd0315;"> (��ǰ)<%=article_name%></span>
			</td>
			<td class="con4">	</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">
				<a href="promise_list.asp?article_step1=<%=article_step1%>&article_step2=<%=article_step2%>&article_idx=<%=article_idx%>"><img src="/images/button/btn_icon03.gif" align="absmiddle">&nbsp;&nbsp;���� ���</a>
			&nbsp;
			</td>
		</tr>

  <% 
		i=i+1 
		strSql = " select * from code_promise where "
		strSql = strsql & " article_idx="&article_idx&" order by promise_order asc "
		Set objRs2=objCnn.Execute(strSql)

		Do Until objRs2.Eof
			promise_idx			= objRs2("promise_idx")
			promise_name		= objRs2("promise_name")
			promise_view		= objRs2("promise_view")
			promise_policy		= objRs2("promise_policy")

			If promise_policy="Y" Then 
				promise_policy_txt="<span class='red'>����</span>"
			Else
				promise_policy_txt="<span class='blue'>������</span>"
			End if


			If promise_view="Y" Then 
				promise_view="<span class='red'>����</span>"
			Else
				promise_view="<span class='blue'>����</span>"
			End if
  %>
				<tr height=30>
					<td class="con5"><%=promise_idx%></td>
					<td class="con2">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						(����) <a href="promise_list.asp?article_idx=<%=article_idx%>&promise_idx=<%=promise_idx%>">
						<%=promise_name%></a>
					</td>
					<td class="con4"><%=promise_policy_txt%></td>
					<td class="con4"><%=promise_view%></td>
					<td class="con4">&nbsp;</td>
				</tr>

		<%
			objRs2.movenext
			i=i+1
		Loop

		objRs1.movenext
		Loop
   	objRs.MoveNext   		
   	loop
   end if
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>