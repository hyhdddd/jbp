  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  filename="협력점정책표(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  Login_chk(Session_m_id)

  if ad_r_y_exact="N" then
 	Alert_URL session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	
  
  policy_idx		= WORD_CHANGE(Request("policy_idx"),10)



  strSql = " Select m_dealer_code from emp_list where m_id='"&Session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code		= objRs(0)
  objRs.close

  
  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">

<style type="text/css">
<!--  
	A:link    {color:#000000;text-decoration:none;}
	A:visited {color:#000000;text-decoration:none;}
	A:active  {color:#000000;text-decoration:none;}
	A:hover  {color:#8CC84B;text-decoration:none}

	body 
	{
		scrollbar-face-color: #ffffff; scrollbar-shadow-color: #666666; 
		scrollbar-highlight-color: #666666; scrollbar-3dlight-color: #ffffff; 
		scrollbar-darkshadow-color: #ffffff; scrollbar-track-color: #ffffff;
		scrollbar-arrow-color: #666666
	}
	td	{font: 9pt 돋움,GulimChe,Gulim;color: black;}	
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
  <%
  strSql = " select  A.policy_idx, B.policy_date, B.policy_title, A.policy_txt, B.policy_passwd, A.policy_txt, "
  strSql = strSql & "  B.policy_file1   from policy_list_article A left outer join policy_list B on A.policy_idx=B.policy_idx "
  strSql = stRSql & "		where A.policy_idx="&policy_idx &" order by A.board_idx asc" 
  Set objRs=objCnn.Execute(strSql)

  i=1
  Do Until objRs.eof
	policy_idx		= objRs("policy_idx") 
	policy_title	= objRs("policy_title")
	policy_date		= fnc_date_change(objRs("policy_date"))

	policy_passwd	= objRs("policy_passwd")
	policy_file1	= objRs("policy_file1")
	policy_txt		= objRs("policy_txt")
	
    if len(policy_file1)>0 then
		filepath1	= o_code&"/policy/"&left(policy_file1, InstrRev(policy_file1,"/"))  
  		filename1	= mid(policy_file1, InstrRev(policy_file1,"/")+1)  
    end If

  %>

			<%=policy_txt%> 
  <%
	objRs.movenext
  Loop
  %>