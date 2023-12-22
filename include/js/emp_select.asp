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
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"--> 
  <!--#include virtual="/include/asp/config.asp"--> 
  <%     
  Response.Write("var dealer_code	= new Array()" & Chr(13))
  Response.Write("var emp_m_id		= new Array()" & Chr(13))
  Response.Write("var emp_m_name	= new Array()" & Chr(13))
  
  j=0
 
  strSql = "SELECT m_dealer_code, m_id, m_name FROM emp_list where m_status='O' order by m_name asc"
  set objRs=objCnn.Execute(strSql)

  	Do Until objRs.EOF
		emp_dealer_code		= objRs("m_dealer_code")
        emp_m_id			= objRs("m_id")
        emp_m_name			= objRs("m_name")
        	        	
		Response.Write("dealer_code[" & j & "] = '" & CStr(emp_dealer_code) & "';")
		Response.Write("emp_m_id[" & j & "] = '" & CStr(emp_m_id) & "';")
		Response.Write("emp_m_name[" & j & "] = '" & CStr(emp_m_name) & "';")
		objRs.MoveNext
		j = j + 1
  	Loop

	objRs.Close
  %>

	  
function change_emp_select(dealer_code1,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt=0;
	dealer_code1		= dealer_code1.options[idx].value;

	y_id_length			= frm.g_yuchi_m_id.length;

	for(i=0; i<y_id_length;i++)
	{
		
		frm.g_yuchi_m_id.options[i] = null;
	}
	
	frm.g_yuchi_m_id.length=0;		
	frm.g_yuchi_m_id.options[cnt++] = new Option('::: 유치자 :::','0');

	for(i=0; i<dealer_code.length;i++)
	{	
		if(dealer_code[i].toUpperCase()==dealer_code1.toUpperCase())
		{
			frm.g_yuchi_m_id.options[cnt++] = new Option(emp_m_name[i],emp_m_id[i]);
		}	
	}

}


function s_change_emp_select(dealer_code1,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt=0;
	dealer_code1		= dealer_code1.options[idx].value;

	y_id_length			= frm.s_yuchi_m_id.length;

	for(i=0; i<y_id_length;i++)
	{
		
		frm.s_yuchi_m_id.options[i] = null;
	}
	
	frm.s_yuchi_m_id.length=0;		
	frm.s_yuchi_m_id.options[cnt++] = new Option('유치자','');

	for(i=0; i<dealer_code.length;i++)
	{	
		if(dealer_code[i].toUpperCase()==dealer_code1.toUpperCase())
		{
			frm.s_yuchi_m_id.options[cnt++] = new Option(emp_m_name[i],emp_m_id[i]);
		}	
	}

}