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
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
  end if		 

  s_article_idx1		= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2		= WORD_CHANGE(Request("s_article_idx2"),20)
  s_option_idx			= WORD_CHANGE(Request("s_option_idx"),20)
  
  s_gaetong_code		= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(WORD_CHANGE(Request("s_date_end"),20)
  date_chk				= WORD_CHANGE(Request("date_chk"),20)
  
  g_charge_date1		= WORD_CHANGE(request("g_charge_date1"),20)
  g_charge_date2		= WORD_CHANGE(request("g_charge_date2"),20)
  dealer_code			= WORD_CHANGE(Request("dealer_code"),0)		' 선택된 거래처 
  dealer_code			= split(dealer_code,",")

  If s_article_idx1=""	Then	s_article_idx1="0"		End If
  If s_article_idx2=""	Then	s_article_idx2="0"		End If
  If s_option_idx=""	Then	s_option_idx="0"		End If
   
  If date_chk=""		Then	date_chk="0"			End If  
 
  If date_chk="0" Then
  	s_date_start=""
	s_date_end=""
  End If

  for i=0 to ubound(dealer_code)

		t_dealer_code = Trim(dealer_code(i))

		If t_dealer_code<>"" Then
			
			strSql = "update customer_goods_charge set o_code=o_code "

			If g_charge_date1="" Or IsNull(g_charge_date1) Then
			else
				strSql = strSql & ", g_charge_date1='"& g_charge_date1 &"' " 				
			End If

			If g_charge_date2="" Or IsNull(g_charge_date2) Then
			else
				strSql = strSql & ", g_charge_date2='"& g_charge_date2 &"' " 				
			End If
		
			strSql = strSql & " where g_charge_idx in "
			strSql = strSql &  "	(select H.g_charge_idx from   customer_goods A full  "
			strSql = strSql & "  			 join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx "
			strSql = strSql & "			where  (A.g_trans_in_dealer='"&t_dealer_code&"') "	

			'회사
			If s_article_idx1<>"0" Then
				strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
			End if

			'상품
			If s_article_idx2<>"0" Then
				strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
			End If

			'옵션
			If s_option_idx<>"0" Then
				strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
			End If

			'개통
			If s_gaetong_code<>"" Then
				strSql = strSql & "		and (A.g_code_gaetong_idx='"& s_gaetong_code &"') "	
			End If

			'접수일
			If date_chk="1" Then
				strSql = strSql & "		and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
				strSql = strSql & "		and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
			End If

			'개통일
			If date_chk="2" Then
				strSql = strSql & "		and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
				strSql = strSql & "		and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
			End If

			'해약일
			If date_chk="3" Then
				strSql = strSql & "		and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
				strSql = strSql & "		and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
			End If

			'정산예정일
			If date_chk="4" Then
				strSql = strSql & "		and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
				strSql = strSql & "		and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
			End If

			'정산완료일
			If date_chk="5" Then
				strSql = strSql & "		and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
				strSql = strSql & "		and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
			End If


			'정산예정일 + 미완료
			If date_chk="6" Then
				strSql = strSql & "		and (H.g_charge_date1>='"&s_date_start&"') "
				strSql = strSql & "		and (H.g_charge_date1<='"&s_date_end&"') "	
				strSql = strSql & "		and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
			End If
					  

			strSql = strSql & "				) "

			Set objRs=objCnn.Execute(strSql)


		End if
  Next

  Alert " 정산이 일괄 처리 되었습니다."
  win_reload_modal()
  win_close_modal()
  %>
