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
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" ���� ��ü ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	 

  g_goods_idx		= WORD_CHANGE(Request("g_goods_idx"),20)

  %>


<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>


<div class="outerContainer">

	<table width=100% border=0 cellspacing="1" cellpadding="0" class="table_css">
	<tr height='30'>
		<td colspan='12' style='text-align:left;'>&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;<b>�� �Է� ���� </b></td>
	</tr>
	<tr>
		<th class="head_Gray_TLB" width="20" rowspan='2'>No</th>
		<th class="head_Gray_TLB" width="60" rowspan='2'>����</th>
		<th class="head_Gray_TLB" width="200" rowspan='2'>���� ���</th>
		<th class="head_Gray_TLB" width="100" rowspan='2'>����������</th>
		<th class="head_Gray_TLB" width="300" colspan='5'>���� �׸�</th>
		<th class="head_Gray_TLB" width="100" rowspan='2'>���������</th>
		<th class="head_Gray_TLB" width="100" rowspan='2'>�ΰ�����</th>
		<th class="head_Gray_TLBR" width="100" rowspan='2'>���ռ�����</th>
	</tr>
	<tr>
		<th class="head_Gray_LB" width="100">���� ����ǰ</th>
		<th class="head_Gray_LB" width="100">����ǰ����</th>
		<th class="head_Gray_LB" width="100">����������</th>
		<th class="head_Gray_LB" width="100">�̺񼭷�</th>
		<th class="head_Gray_LB" width="100">��Ÿ����</th>
	</tr>
  <%
  strSql = " select * from customer_goods_charge where g_goods_idx="&g_goods_idx&" order by g_charge_idx asc "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  %>
	<tr height='30'>
		<td class='list_LBR_center' colspan='11'> �߰����� ������ �������� �ʽ��ϴ�.</td>
	</tr>
  <%
  Else
	i=1
	Do Until objRs.eof
			g_charge_idx		= objRs("g_charge_idx")
			g_charge_type		= objRs("g_charge_type")
			g_charge_type_txt	= fnc_charge_type(g_charge_type)

			g_goods_idx			= objRs("g_goods_idx")
			
			g_charge_promise	= money_chk(objRs("g_charge_promise"))
			g_charge_sp_top		= money_chk(objRs("g_charge_sp_top"))
			g_charge_sp			= money_chk(objRs("g_charge_sp"))
			g_charge_sale		= money_chk(objRs("g_charge_sale"))
			g_charge_document	= money_chk(objRs("g_charge_document"))
			g_charge_gita		= money_chk(objRs("g_charge_gita"))
			g_charge_bundle		= money_chk(objRs("g_charge_bundle"))
			g_charge_buga		= money_chk(objRs("g_charge_buga"))
			g_charge_combine	= money_chk(objRs("g_charge_combine"))

			g_charge_bigo		= objRs("g_charge_bigo")

			g_charge_promise	= money_change(g_charge_promise)
			g_charge_sp_top		= money_change(g_charge_sp_top)
			g_charge_sp			= money_change(g_charge_sp)
			g_charge_sale		= money_change(g_charge_sale)
			g_charge_document	= money_change(g_charge_document)
			g_charge_gita		= money_change(g_charge_gita)
			g_charge_bundle		= money_change(g_charge_bundle)
			g_charge_combine	= money_change(g_charge_combine)


			g_charge_date1		= objRs("g_charge_date1")				'���� ������
			g_charge_date2		= objRs("g_charge_date2")				'���� �Ϸ���

			g_charge_writeday	= Left(objRs("g_charge_writeday"),10)
  %>
	<tr height='30'>
		<td class="list_LB_center"><%=i%></td>
		<td class="list_LB_center"><a href="a_charge_regist.asp?g_goods_idx=<%=g_goods_idx%>&g_charge_idx=<%=g_charge_idx%>"><span class="btn_s_white01"><%=g_charge_type_txt%></span></td>
		<td class="list_LB_center"><a href="a_charge_regist.asp?page=<%=page%>&nowblock=<%=nowblock%>&g_charge_idx=<%=g_charge_idx%>&g_goods_idx=<%=g_goods_idx%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>"><%=g_charge_bigo%></a> </td>
		<td class="list_LB_center"><%=g_charge_promise%></td>
		<td class="list_LB_center"><%=g_charge_sp_top%></td>
		<td class="list_LB_center"><%=g_charge_sp%></td>
		<td class="list_LB_center"><%=g_charge_sale%></td>
		<td class="list_LB_center"><%=g_charge_document%></td>
		<td class="list_LB_center"><%=g_charge_gita%></td>
		<td class="list_LB_center"><%=g_charge_bundle%></td>
		<td class="list_LB_center"><%=g_charge_buga%></td>
		<td class="list_LBR_center"><%=g_charge_combine%></td>
		
	</tr>
  <%
		i=i+1
		objRs.movenext
	loop

  End if
  %>
	<tr height='30'>
		<td colspan='12' style="text-align:right;">
			<a href="a_charge_regist.asp?g_goods_idx=<%=g_goods_idx%>"><span class="btn_m_white01"> �߰�����</span></a>
		</td>
	</tr>
	</table>
</div>