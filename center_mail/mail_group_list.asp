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

  group_idx		= WORD_CHANGE(request("group_idx"),20)
  
  if group_idx<>"" then
  	strSql = " select group_idx, group_name from sms_group "
	strSql = strSql & " where group_idx='"&group_idx&"'"
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof or objRs.bof Then
		group_idx	= ""
	else
	group_idx			= objRs("group_idx")
  	group_name			= objRs("group_name")
	End If
	
	objRs.close
  end if	
  
  %>
<!DOCTYPE html>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function code_group_del(code)
	{
		ans=confirm("�ڵ� ����ñ� ���ؼ��� ���õ� �׷쿡 ����� ����� �մϴ�. \n\n �ڵ带 ����ðڽ��ϱ�? ");
		if(ans==true)
		{
			location.href="mail_group_del_ok.asp?group_idx="+code
		}
	}

	//  �׷��ڵ� ���    
	function send_mail_group() 
	{
		frm=document.all.frm_group;
		if(frm.group_name.value.length==0)
		{
			alert("�׷���� �Է��� �ּ���!");
			frm.group_name.focus();
			return false;
		}	
		frm.submit();
	}



	function mail_submit()
	{
		var frm=document.all.frm_group;

		var chk=0
		aaa=frm.group_idx1;
		
		if(aaa==undefined)
		{
			alert("�׷�������� �׷��� ���� ����� �ֽñ� �ٶ��ϴ�.");
			return;
		}

		if(frm.group_idx1.length==undefined)
		{
			if(frm.group_idx1.checked==true)
			{
				chk++;
			}
		}
		else
		{
			for(i=0;i<frm.group_idx1.length;i++)
			{
				if(frm.group_idx1[i].checked==true)
				{
					chk++;
				}
			}
		}
		if(chk==0)
		{
			alert("��� �׷��� �������ּ���!");
			return;
		}
		
		frm.action="mail_group_list_ok.asp";
		frm.submit();

	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellpadding="0" cellspacing="0">
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		
		<!------------------ ���� ����  ------------------>    								
		
		<div class="sub_title"><img src="/images/common/sub12_t04_4.gif" width='680'></div>

		<form id="frm_group" name="frm_group" Method="POST" action="mail_group_regist_ok.asp">
		<input type="hidden" name="group_idx" value="<%=group_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height=30> 
			<th width='100'>�׷� �ڵ��</th>
			<td>
				<input type="Text" class="txtbox" name="group_name" size="30"  value="<%=group_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);"></td>
		</tr>
		<tr height=30> 
			<Td colspan='2'>
				<% if ad_b_a_custom="W" or ad_b_a_custom="E" or ad_b_a_custom="A" then %>
					<a href="mail_group_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>���� �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_b_a_custom="W" or ad_b_a_custom="E" or ad_b_a_custom="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_mail_group();">
				<% else %>
					<a href ='javascript:alert("<%=session_name%> ���� �ڵ� ��� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %>   
				
				<% If group_idx<>"" Then %>
					<% if ad_b_a_custom="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="code_group_del('<%=group_idx%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> ���� �ڵ� ���������� �����ϴ�.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
			</td>	
		</tr>
		</table>				
	
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td class="head" width=50>��  ȣ</td>
			<td class="head" width=50>�ϰ�</td>
			<td class="head" width=500>�׷� �ڵ� ��</td>
			<td class="head" width=150>��� ����</td>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select * from sms_group order by group_name asc"

  strSql = " select A.group_idx , A.group_name , A.group_writeday , isnull(B.group_cnt,0) as group_cnt  from sms_group A  "
  strSql = strsql & " Left outer join "
  strSql = strSql & " (SELECT group_idx, count(group_idx) as group_cnt FROM sms_group_emp  GROUP BY group_idx ) B "
  strSql = strSql & "		ON A.Group_idx=B.group_idx "
  strSql = strSql & "     		 ORDER BY A.group_name ASC "


  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 9
  
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
    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount

  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
  		group_idx			= objRs("group_idx")
  		group_name			= objRs("group_name")
		group_writeday		= objRs("group_writeday")
		group_cnt			= objRs("group_cnt")
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con4"><input type="checkbox" name="group_idx1" value="<%=group_idx%>"></td>
			<td class="con2">
				<a href="mail_group_list.asp?group_idx=<%=group_idx%>&page=<%=page%>&nowblock=<%=nowblock%>"><%=group_name%> (&nbsp;<%=group_cnt%>��)</a></td>
			<td class="con4">
				<span onclick="NewWindow('/sms/sms_group_emp_add.asp?group_idx=<%=group_idx%>','sms_emp_add','580','600','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_add.gif" align="absmiddle">&nbsp;�߰�</a></span> | 
				<span onclick="NewWindow('/sms/sms_group_emp_sub.asp?group_idx=<%=group_idx%>','sms_emp_add','580','600','yes');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_sub.gif" align="absmiddle">&nbsp;����</span></td>
		</tr>
  <% 
		objRs.MoveNext
   		i=i+1 
    loop
  %>							
  <%
   objRs.close
   end if					
%>   
		<tr height='30'>
			<td class='con5' colspan='2'><img src="/images/button/mail_send.gif" align='absmiddle' onclick="mail_submit();"></td>
			<td class='con4' colspan='6'>&nbsp;</td>
		</tr>
		</table>

		<div class="pagelist">
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :������ Request ��
			mychoice=10
			link_url = "mail_group_list.asp?"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>
		</form>
		<!------------------ ���� ����  ------------------>
	</td>
</tr>
</table>
