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
  Response.Write("var m_id = new Array()" & Chr(13))
  Response.Write("var to_name = new Array()" & Chr(13))
  Response.Write("var job_position = new Array()" & Chr(13))
  
  board_idx=0
 
  strSql = " SELECT A.m_name, A.m_id, B.duty_name, C.position_name, D.dealer_name " 
  strSql = strSql & "	FROM emp_list A left outer "
  strSql = strSql & "			join code_duty B ON A.m_duty=B.duty_code"
  strSql = strSql & "	   left join code_position C ON A.m_position=C.position_code "
  strSql = strSql & "	   left join dealer_info D ON A.m_dealer_code=D.dealer_code "  
  set objRs=objCnn.Execute(strSql)

  Do Until objRs.EOF
      	m_id			= objRs("m_id")
       	to_name			= objRs("m_name")
       	position_name	= objRs("position_name")
       	duty_name		= objRs("duty_name")
       	dealer_name		= objRs("dealer_name")
        	
       	job_position  = position_name+"_"+duty_name+"_("&dealer_name&")"
        	
       	Response.Write("m_id[" & board_idx & "] = '" & CStr(m_id) & "';")
       	Response.Write("to_name[" & board_idx & "] = '" & CStr(to_name) & "';")
       	Response.Write("job_position[" & board_idx & "] = '" & CStr(job_position) & "';")
       	objRs.MoveNext
       	board_idx = board_idx + 1
  Loop

  objRs.Close	
  %>
	
function mail_submit()
{
	var form=document.all.mail_frm.elements;
	emp_list="";
	mail_del_chk="";
	for( var i=0; i<form.length; i++) 
	{
		var ele = form.elements[i];
		if(ele.name == 'chk')
		{
			if(ele.checked == true)
			{
				mail_del_chk="O";
				emp_list=emp_list+ele.value+"_";
			}
		}		
	}	
		
	if(mail_del_chk=="O")
	{
		emp_list = emp_list.substring(0, emp_list.length-1);  
		//alert(emp_list);
		select_name_change_all(emp_list);
	}
	else
	{
		alert(" 사원은 한명 이상 체크하세요!");
		return;
	}	
}


function select_name_change_all(emp_list)
{
	emp_list=emp_list.split("_");
	var frm=opener.document.all.frm_mail;

	var test,sabun_chk;
	var board_idx_num1 = new Array();	
	board_idx_num_cnt	= 0;
	cnt=frm.select_name.length;
	var chk1="O";
	var aa;
	for(j=0; j<emp_list.length; j++)
	{
		send_name=emp_list[j];
		chk1="O";
		sabun_chk_cnt=0;
		for(i=0; i < to_name.length; i++)
		{
			if(send_name==to_name[i])
			{
				sabun_chk_cnt=sabun_chk_cnt+1;
				board_idx_num1[0]=i;
				board_idx_num_cnt=board_idx_num_cnt+1
				//alert(board_idx_num_cnt);
			}			
		}
		
		if(sabun_chk_cnt==1)
		{	
			test=board_idx_num1[0];
			opt_value=to_name[test]+"_"+job_position[test];
			sabun_chk=m_id[test];

			
			for(i = 0; i < frm.select_name.length; i++) 
			{
				//수신자 중복 체크
				receipt_str = frm.select_name.options[i].value;
				//alert(receipt_str+":"+m_id[test]);
				if(receipt_str == m_id[test])
				{
					chk1="X";
				}
			}
			if(chk1!="X")
			{
				aa=window.opener.OnConditionAdded( opt_value, sabun_chk );
				//alert(aa);
			}	
			chk1="O";
		}	
		else
		{
			//같은 이름이 여러명 일때는,,,, 
			for(i=0; i < board_idx_num_cnt; i++)
			{
				test=board_idx_num1[0];
				opt_value=to_name[test]+"_"+job_position[test];
				sabun_chk=m_id[test];
				//alert(cnt);
				chk1="O";

				for(k = 0; k < frm.select_name.length; k++) 
				{
					//수신자 중복 체크
					receipt_str = frm.select_name.options[k].value;
					
					if(receipt_str == m_id[test])
					{
						chk1="X";
					}
				}

				if(chk1!="X")
				{
					aa=window.opener.OnConditionAdded( opt_value, sabun_chk );
				}		

				
			}
			chk1="O";

		}
	}
	
	self.close();
}	