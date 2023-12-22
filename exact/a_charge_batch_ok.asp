 <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
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
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	 
    
  g_charge_idx			= WORD_CHANGE(request("g_charge_idx"),0)
  g_charge_date1		= WORD_CHANGE(request("g_charge_date1"),20)
  g_charge_date2		= WORD_CHANGE(request("g_charge_date2"),20)
  g_charge_promise		= WORD_CHANGE(request("g_charge_promise"),20)
  g_charge_sp_top		= WORD_CHANGE(request("g_charge_sp_top"),20)
  g_charge_sp			= WORD_CHANGE(request("g_charge_sp"),20)
  g_charge_sale			= WORD_CHANGE(request("g_charge_sale"),20)
  g_charge_gita			= WORD_CHANGE(request("g_charge_gita"),20)
  g_charge_bundle		= WORD_CHANGE(request("g_charge_bundle"),20)
  g_charge_buga			= WORD_CHANGE(request("g_charge_buga"),20)
  g_charge_combine		= WORD_CHANGE(request("g_charge_combine"),20)
  g_charge_bigo			= WORD_CHANGE(request("g_charge_bigo"),0)
  date1_chk				= WORD_CHANGE(request("date1_chk"),20)
  date2_chk				= WORD_CHANGE(request("date2_chk"),20)
  date3_chk				= WORD_CHANGE(request("date3_chk"),20)
  g_charge_idx			= split(g_charge_idx,",")

  for i=0 to ubound(g_charge_idx)

		g_charge_idx1 = Trim(Mid(g_charge_idx(i),1,InstrRev(g_charge_idx(i),":")-1))
		g_goods_idx = Mid(g_charge_idx(i),InstrRev(g_charge_idx(i),":")+1)
	
		'response.write IsNull(g_charge_idx1)
		If g_charge_idx1<>"" Then

			strSql = " update customer_goods_charge set "
			strSql = strSql &" o_code				= o_code "

			If g_charge_promise<>"" Then
			strSql = strSql &", g_charge_promise	=  "& g_charge_promise &" "
			End if

			If g_charge_sp<>"" Then
			strSql = strSql &", g_charge_sp			=  "& g_charge_sp &" "
			End if

			If g_charge_sp_top<>"" Then
			strSql = strSql &", g_charge_sp_top		=  "& g_charge_sp_top &" "
			End if

			If g_charge_sale<>"" Then
			strSql = strSql &", g_charge_sale		=  "& g_charge_sale &" "
			End if

			If g_charge_gita<>"" Then
			strSql = strSql &", g_charge_gita		=  "& g_charge_gita &" "
			End if

			If g_charge_bundle<>"" Then
			strSql = strSql &", g_charge_bundle		=  "& g_charge_bundle &" "
			End If

			If g_charge_buga<>"" Then
			strSql = strSql & ", g_charge_buga		=  "& g_charge_buga &" "
			End If

			If g_charge_bigo<>"" Then
			strSql = strSql &", g_charge_bigo		= '"& g_charge_bigo &"' "
			End If

			If date1_chk="Y" Then
			strSql = strSql &", g_charge_date1		= null "
			Else				
				If g_charge_date1<>"" Then
				strSql = strSql &", g_charge_date1	= '"& g_charge_date1 &"' "
				End If
			End If
			
			If date2_chk="Y" Then
			strSql = strSql &", g_charge_date2		= null "
			Else
				If g_charge_date2<>"" Then
				strSql = strSql &", g_charge_date2	= '"& g_charge_date2 &"' "
				End If
			End if

			strSql = strSql &" where g_charge_idx	=  "& g_charge_idx1
			Set objRs=objCnn.Execute(strSql)			
		Else
			strSql = "Select * from customer_goods_charge where g_goods_idx="&g_goods_idx
			Set objRs_chk = objCnn.Execute(strSql)

			If objRs_chk.eof Or objRs_chk.bof then

				strSql =" insert into customer_goods_charge(g_goods_idx, o_code, g_charge_type, "
				strSql = strSql &" g_charge_promise, g_charge_sp_top, g_charge_sp, g_charge_sale, g_charge_gita, g_charge_bundle, g_charge_buga, "
				strSql = strSql &" g_charge_date1,g_charge_date2, g_charge_bigo, g_charge_writeday) "
				strSql = strSql &" values ("& g_goods_idx &",'"& o_code &"','G' "

				strSql = strSql &",  "& money_chk(g_charge_promise) &" "
				strSql = strSql &",  "& money_chk(g_charge_sp_top) &" "
				strSql = strSql &",  "& money_chk(g_charge_sp) &" "
				strSql = strSql &",  "& money_chk(g_charge_sale) &" "
				strSql = strSql &",  "& money_chk(g_charge_gita) &" "
				strSql = strSql &",  "& money_chk(g_charge_bundle) &" "
				strSql = strSql &",  "& money_chk(g_charge_buga) &" "

				If date1_chk="Y" Then
				strSql = strSql &", null "
				Else				
					If g_charge_date1="" Then
					strSql = strSql &", null"
					else
					strSql = strSql &", '"& g_charge_date1 &"' "
					End If
				End If
				
				If date2_chk="Y" Then
				strSql = strSql & " ,null"
				Else
					If g_charge_date2="" Then
					strSql = strSql &", null "
					else
					strSql = strSql &", '"& g_charge_date2&"' "
					End If
				End if

				strSql = strSql &", '"& g_charge_bigo &"' "
				strSql = strSql &", getdate() )"
				Set objRs=objCnn.Execute(strSql)			
			End If
		End If
  Next

  Alert " 정산이 일괄 처리 되었습니다."
  DBClose()
  %>
<script language="javascript">
  <!--
	opener.document.location.reload();
    parent.window.close();
	window.close();
  -->
  </script>
