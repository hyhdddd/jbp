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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)
 
  set FSO=Server.CreateObject("Scripting.FileSystemObject")

  tname				= WORD_CHANGE(request("tname"),20)
  w_board_idx		= WORD_CHANGE(request("w_board_idx"),10)

  strsql = "delete emp_work_report where w_board_idx = "&w_board_idx	
  Set objRs=objCnn.Execute(strSql) 	
    
  Alert_url "���� ���� �Ǿ����ϴ�.","work_report_list.asp"
  %>