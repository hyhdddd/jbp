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
  Response.AddHeader "X-Content-Type-Options", "no-sniff"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_c_code="N" then
	Alert_back session_m_name &"���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if
  
  combine_idx		= WORD_CHANGE(request("combine_idx"),10)
  
  if combine_idx<>"" then
  	strSql = " select combine_idx, article1_idx, combine_name, combine_view, combine_order from code_combine "
	strSql = strSql & " where combine_idx="& combine_idx &" "
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		combine_code	= ""
	Else
	article1_idx			= objRs("article1_idx")
	combine_idx				= objRs("combine_idx")
  	combine_name			= objRs("combine_name")
  	combine_view			= objRs("combine_view")
	combine_order			= objRs("combine_order")
	End If
	
	objRs.close
  end if	

  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script type="text/javascript">

function fnc_combine_del(link_url)
{
	ans=confirm("�ڵ带 ����ðڽ��ϱ�? ");
	if(ans==true)
	{
		location.replace(link_url);
	}
}

function fnc_combine_regist(form_name) 
{
	var frm= document.getElementById(form_name);
	
	if(frm.combine_name.value.length==0)
	{
		alert("�ڵ���� �Է��� �ּ���!");
		frm.combine_name.focus();
		return false;
	}	
	frm.submit();
}

</script>


<body>
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr height='400' valign='top'> 
	<td>
		<!------------------ ���� ����  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">�ڵ� ����</li>
		</ul>
		</div>

		<!--#include virtual="/include/asp/code_menu_list.asp"-->

		<form id="frm_combine" name="frm_combine" Method="POST" action="combine_regist_ok.asp">
		<input type="hidden" name="combine_idx" value="<%=combine_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_css">
		<tr>
			<th width="15%" class="head_Gray_TLB">ȸ�缱��</th>
			<td width="85%" class="list_TLBR_left">
				<select name="article1_idx" class='txtbox' style="width:150px;">
				<option value="0" <% if article1_idx="0" then %> selected <% end if %>>::ȸ�缱��::</option>
				<% 
				strSql = " select * from code_article where article_step2=0  order by article_order asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
				<option value="<%=article_idx%>" <% if article_idx=article1_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objRs.MoveNext
				Loop
				objRs.close
				%>	
			</select></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB">���� ��</th>
			<td class="list_LBR_left"><input type="Text" class="txtbox" name="combine_name" size="30"  value="<%=combine_name%>"  maxlength="30"></td>
		</tr>
		<tr height='30'>
			<th class="head_Gray_LB">����/���� </th>
			<td class="list_LBR_left">
				<input type="radio" name="combine_view" value="Y" <% If combine_view="Y" Or combine_view=""  Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
				<input type="radio" name="combine_view" value="N" <% If combine_view="N" Then %> checked <% End If %>>����&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr height='30'>
			<th class="head_Gray_LB">��¼��� </th>
			<td class="list_LBR_left">
				<input type="Text" class="txtbox" name="combine_order" size="10"  value="<%=combine_order%>"  maxlength="10" onKeyUp="fncOnlyNumber(this);">
			</td>
		</tr>

		<tr height=30> 
			<Td colspan='2'>
				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<a href="combine_list.asp"><span class="btn_m_white01">�űԵ��</span></a>					
				<% else %>
					<span class="btn_m_white01" onclick="alert('<%=session_m_name%> ���� ��� ������ �����ϴ�.');">�űԵ��</span>
				<% end if %>      									

				<% if ad_c_code="W" or ad_c_code="E" or ad_c_code="A" then %>
					<span class="btn_m_white01" onclick="fnc_combine_regist('frm_combine');">�����ϱ�</span>
				<% else %>
					<span class="btn_m_white01" onclick="alert('<%=session_m_name%> ���� ��� ������ �����ϴ�.');">�����ϱ�</span>
				<% end if %>       								
	
				<% If combine_idx<>"" Then %>
					<% if ad_c_code="A" then %>
						<span class="btn_m_white01" onclick="fnc_combine_del('combine_del_ok.asp?combine_idx=<%=combine_idx%>');"> �����ϱ�</span>
					<% else %>
						<span class="btn_m_white01" onclick="alert('<%=session_m_name%>���� �����ڵ� ���������� �����ϴ�.');">�����ϱ�</span>
					<% end if %>  
				<% End If %>
				</td>	
		</tr>
		</table>	

		<TABLE width="100%" cellspacing=0 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th class="head_Gray_TLB" width=50>��  ȣ</th>
			<th class="head_Gray_TLB" width=550>��ǰ���� ��</th>
			<th class="head_Gray_TLB" width=100>ǥ��</th>
			<th class="head_Gray_TLB" width=100>����</th>
			<th class="head_Gray_TLBR" width=100>������</th>
		</tr>
  <%

 

  strsql = " select * from code_article where article_step2=0  order by article_order asc "
  'Response.write strSql
  Set objRs1=objCnn.Execute(strSql)

  If objRs1.eof Or objRs1.bof Then
  %>
		<tr height=30>
			<td colspan='4' class="list_LBR_center"></td>
		</tr>
  <%
  Else

  Do Until objRs1.eof 
	  article_idx		= objRs1("article_idx")
	  article_name		= objRs1("article_name")
	  %>
		<tr height=30>
			<td class='list_LB_center' style="background:#e7e7e7"> <b> ȸ��� </b></td>
			<td colspan='4' class="list_LBR_left" style="background:#e7e7e7">&nbsp;<b><%=article_name%></b></td>
		</tr>
  <%
  strSql = " select * from code_combine where article1_idx="& article_idx &" order by combine_order asc"
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)
  
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td colspan='5' class="list_LBR_center"></td>
		</tr>
  <%
  else      		 

  	i = 1
  	Do until objRs.EOF 
  		combine_idx				= objRs("combine_idx")
  		combine_name			= objRs("combine_name")
  		combine_view			= objRs("combine_view")
		combine_order			= objRs("combine_order")
  		combine_writeday		= Left(objRs("combine_writeday"),10)

		If combine_view="Y" Then 
			combine_view="<span class='red'>����</span>"
		Else
			combine_view="<span class='blue'>����</span>"
		End If

  %>	
		<tr height=30>
			<td class="list_LB_center"><%=i%></td>
			<td class="list_LB_left"><a href="combine_list.asp?combine_idx=<%=combine_idx%>"><b><%=combine_name%></b></a></td>
			<td class="list_LB_center"><%=combine_view%></td>
			<td class="list_LB_center"><%=combine_order%></td>
			<td class="list_LBR_center"><%=combine_writeday%></td>
		</tr>

  <% 
		objRs.MoveNext
   		i=i+1 
    loop
   end if		
		

  objRs1.movenext
  loop
  End if   
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
</div>
  <%
  DBClose()
  %>