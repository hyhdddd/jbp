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

  article_step1			= WORD_CHANGE(request("article_step1"),20)
  article_step2			= WORD_CHANGE(request("article_step2"),20)
  
  If article_step1="" And article_step2="" Then
	chk="A"			'��з� ���
  End If
  
  If article_step1<>"" And article_step2="0" Then
	chk="B"			'��з� ����
  End If

  If article_step1<>"" And article_step2="" Then
	chk="C"			'�ߺз� ���

	strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
	strSql = strSql & "	from code_article "
	strsql = strsql & "		where article_step1="& article_step1&" "
	strSql = strsql & "			and article_step2=0"
	Set objRs=objCnn.Execute(strSql)

	article_name1	= objRs("article_name")

  End If

  If article_step1<>"" And (article_step2<>"" And article_step2<>"0") Then
	chk="D"			'�ߺз� ����

	strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
	strSql = strSql & "	from code_article "
	strsql = strsql & "		where article_step1="& article_step1&" "
	strSql = strsql & "			and article_step2=0"
	Set objRs=objCnn.Execute(strSql)

	article_name1	= objRs("article_name")

  End If
  



  if article_step1<>"" Then
	If article_step2<>"" then
		strSql = " select article_idx, article_name, article_step1, article_step2, article_view "
		strSql = strSql & "	from code_article "
		strsql = strsql & "		where article_step1="& article_step1&" "
		strSql = strsql & "			and article_step2="& article_step2
		Set objRs=objCnn.Execute(strSql)
		
		If objRs.eof Or objRs.bof Then
			article_step1		= ""
			article_step2		= ""
		else
			article_idx			= objRs("article_idx")
			article_name		= objRs("article_name")
			article_view		= objRs("article_view")
		End If
	Else

	End if
  end if	
  

  %>

<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function article_del(article_idx)
	{
		ans=confirm("��ǰ�� ����ñ� ���ؼ��� �ɼ��� ��� ������ �� ���� �ֽñ� �ٶ��ϴ�. \n\n ��ǰ�� ����ðڽ��ϱ�? ");
		if(ans==true)
		{
			location.href="article_del_ok.asp?article_idx="+article_idx
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
		

		<form name="frm_article" Method="POST" action="article_regist_ok.asp">
		<input type="hidden" name="article_step1" value="<%=article_step1%>">
		<input type="hidden" name="article_step2" value="<%=article_step2%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">						
		<Tr>
			<td colspan='4' class="description"><br> 
				* ��ǰ�ڵ带 ���/����/���� �� �� �ִ� �޴� �Դϴ�.  <br>
				* ��ǰ�����ڵ�� �������� ���� ��ǰ������ Ȯ���Ҽ� �ִ� ��Ͽ� ��Ÿ���ϴ�. <br>

			</td>
		</tr>

		<% If chk="A" Or chk="B" Then %>
		<tr>
			<th width="130"> ��з� ��� </th>
			<td width="870"> 
				<input type="text" name="article_name" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=article_name%>" size=20>	
					
				&nbsp;&nbsp;
				<input type="radio" name="article_view" value="Y" <% If article_view="Y" Or article_view="" Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
				<input type="radio" name="article_view" value="N" <% If article_view="N"  Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;	
			</td>
		</tr>
		<% Else %>
		<tr>
			<th width="130">��з� ���</th>
			<td width="870"><%=article_name1%></td>
		</tr>
		<tr height=30> 
			<th width="130">�ߺз� ���</th>
			<td width="870">
				<input type="text" name="article_name" class="txtbox" onBlur="BlurColor(this)" onFocus="FocusColor(this);" value="<%=article_name%>" size=20>	
					
				&nbsp;&nbsp;
				<input type="radio" name="article_view" value="Y" <% If article_view="Y" Or article_view="" Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
				<input type="radio" name="article_view" value="N" <% If article_view="N"  Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;	</td>
		</tr>
		<% End If %>

		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="article_list.asp"><img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a>
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� ����ǰ �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_new.gif" border="0" align='absmiddle'></a> 
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_article();" align='absmiddle'>
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� ����ǰ �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif" border="0" align='absmiddle'></a> 
				<% end if %>    

				<% If article_step1<>"" And (article_step2<>"" And article_step2<>"0") Then %>
				<a href="option_list.asp?article_idx=<%=article_idx%>">
				<img src="/images/button/btn_option.gif" border=0 align='absmiddle'></a>
				<% End If %>

				<% If article_step1<>"" Then %>
					<% If ad_c_code="A"  Then %>
						<img src="/images/button/btn_delete.gif" border=0 align='absmiddle' onclick="article_del('<%=article_idx%>');">
					<% Else %>
						<a href ='javascript:alert("<%=session_m_name%> ���� ���� ������ �����ϴ�. �����ڸ� ���� �Ͻ� �� �ֽ��ϴ�!");'><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></a>
					<% End If %>
				<% End If %>
			</td>
		</tr>
		<tr height='30'>
			<td colspan='2' class='con3' style='border-style:none'> 
				<A href="article_order.asp"><img src="/images/button/btn_order1.gif" align="absmiddle"></a> 
				<a href="article_order1.asp"><img src="/images/button/btn_order2.gif" align="absmiddle"></a>
				<a href="article_order2.asp"><img src="/images/button/btn_order3.gif" align="absmiddle"></a>&nbsp;&nbsp;</td>
		</tr>
		</table>				
			
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>��  ȣ</td> 
			<td class="head" width=500>�� ǰ ��</td> 
			<td class="head" width=100>ǥ��</td> 
			<td class="head" width=100>��Ʈ�з� ǥ��</td> 
			<td class="head" width=150>�ߺз� ���</td> 
		</tr>
  <%
  strSql = " select * from code_article where article_step2=0  order by article_order asc"
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
				&nbsp;<span style="color=#1604fe;">
				(ȸ��)</span> <a href="article_list.asp?article_step1=<%=article_step1%>&article_step2=<%=article_step2%>"><span style="color=#1604fe;"><%=article_name%></span></a> 
			</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">&nbsp;</td>
			<td class="con4">
				<a href="article_list.asp?article_step1=<%=article_step1%>&article_step2="><img src="/images/button/btn_icon03.gif" align="absmiddle">&nbsp;&nbsp;�ߺз� ���</a>
			</td>
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
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color=#fd0315;"> 
				(��ǰ)</span> <a href="article_list.asp?article_step1=<%=article_step1%>&article_step2=<%=article_step2%>"><span style="color=#fd0315;"><%=article_name%></span></a>
			</td>
			<td class="con4">
				<%=article_view %>
			</td>
			<td class="con4">&nbsp;</td>
			<td class="con4">&nbsp;</td>
		</tr>

  <% 

		i=i+1 
		strSql = " select * from code_article_option where "
		strSql = strsql & " article_idx="&article_idx&" order by option_order asc "
		Set objRs2=objCnn.Execute(strSql)

		Do Until objRs2.Eof
			option_idx		= objRs2("option_idx")
			option_name		= objRs2("option_name")
			option_view		= objRs2("option_view")
			option_set		= objRs2("option_set")
			option_set_txt = fnc_option_set(option_set)


			If option_view="Y" Then 
				option_view="<span class='red'>����</span>"
			Else
				option_view="<span class='blue'>����</span>"
			End If

  %>
				<tr height=30>
					<td class="con5"><%=option_idx%></td>
					<td class="con2">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						(�ɼ�) <a href="option_list.asp?article_idx=<%=article_idx%>&option_idx=<%=option_idx%>">
						<%=option_name%></a>
					</td>
					<td class="con4"><%=option_view%></td>
					<td class="con4"><%=option_set_txt%></td>
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
   objRs.close
  %>   
		</table>
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