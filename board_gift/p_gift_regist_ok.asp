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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  if ad_p_gift="N" then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If

  page				= WORD_CHANGE(Request("page"),20)
  gift_idx			= WORD_CHANGE(Request("gift_idx"),20)
  gift_date			= WORD_CHANGE(Request("gift_date"),20)
  gift_money		= WORD_CHANGE(money_chk(Request("gift_money")),20)
  gift_m_id			= session_m_id
  
  bank_idx				= WORD_CHANGE(Request("bank_idx[]"),0)
  bank_name				= WORD_CHANGE(Request("bank_name[]"),0)
  bank_no				= WORD_CHANGE(Request("bank_no[]"),0)
  bank_owner			= WORD_CHANGE(Request("bank_owner[]"),0)
  bank_money			= WORD_CHANGE(Request("bank_money[]"),0)


  bank_idx				= split(bank_idx,",")
  bank_name				= split(bank_name,",")
  bank_no				= split(bank_no,",")
  bank_owner			= split(bank_owner,",")
  bank_money			= split(bank_money,",")


  If gift_date="" Then
	Alert_back "�߸��� �����Դϴ�."
	Response.end
  End If
  
  If gift_idx<>"" Then
	
	strSql = " update board_gift set "
	strSql = strSql &"  gift_date		= '"& gift_date &"' "
	strSql = strSql &", gift_money		=  "& gift_money &"  "
	strSql = strSql &"  where gift_idx	=  "& gift_idx

	set objRs=objCnn.Execute(strSql)

  Else
	strSql = "Select ISNULL(MAX(gift_idx)+1,1) from board_gift"
	set objRs=objCnn.Execute(strSql)
	gift_idx	= objRs(0)
	  
	strSql = " INSERT INTO board_gift (gift_idx, gift_m_id, gift_date, gift_money, gift_status, gift_writeday)"
	strSql = strSql &" values ("
	strSql = strSql &"   "& gift_idx &" "
	strSql = strSql &", '"& gift_m_id &"' "
	strSql = strSql &", '"& gift_date &"' "	
	strSql = strSql &",  "& gift_money &" "
	strSql = strSql &", '��û', getdate()) "
	set objRs=objCnn.Execute(strSql)
  End If
  

  strSql = "update board_gift_bank set bank_upchk='N' where gift_idx="& gift_idx
  Set objRs=objCnn.Execute(strSql)


  For i=0 To UBound(bank_idx)
	
	'�з��� ���õ� �����͸� �����Ѵ�.
	If Trim(bank_name(i))<>"" Or Trim(bank_no(i))<>"" Or Trim(bank_owner(i))<>"" Or Trim(bank_money(i))<>"" Then

		If Trim(bank_idx(i))="0" Then
			strSql = "insert into board_gift_bank (gift_idx, bank_name, bank_no, bank_owner, bank_money, bank_upchk) "
			strSql = strSql &" values ("& gift_idx &", '"& Trim(bank_name(i)) &"', '"& Trim(bank_no(i)) &"', "
			strSql = strSql &" '"& Trim(bank_owner(i)) &"', "& Trim(bank_money(i)) &", 'Y') "
			Set objRs=objCnn.Execute(strSql)
		Else
			strSql = "update board_gift_bank set "
			strSql = strSql &"  bank_name		= '"& Trim(bank_name(i)) &"' "			
			strSql = strSql &", bank_no			= '"& Trim(bank_no(i)) &"'  "			
			strSql = strSql &", bank_owner		= '"& Trim(bank_owner(i)) &"'  "			
			strSql = strSql &", bank_money		=  "& Trim(bank_money(i)) &"  "			
			strSql = strSql &", bank_upchk		= 'Y' "			
			strSql = strSql &"	where bank_idx	= "& Trim(bank_idx(i))
			Set objRs=objCnn.Execute(strSql)
		End If
		
	End If

  Next

  strSql = "delete  board_gift_bank where bank_upchk='N' and  gift_idx="& gift_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url "�߰�����ǰ ��û�� �Ϸ� �Ǿ����ϴ�.","p_gift_list.asp?page="&page
  DBClose() 
  %>
