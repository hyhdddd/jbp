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
		dealer_name		= Replace(dealer_name,"'", "`")

        	
       	job_position  = position_name+"_"+duty_name+"_("&dealer_name&")"
        	
       	Response.Write("m_id[" & board_idx & "] = '" & CStr(m_id) & "';")
       	Response.Write("to_name[" & board_idx & "] = '" & CStr(to_name) & "';")
       	Response.Write("job_position[" & board_idx & "] = '" & CStr(job_position) & "';")
       	objRs.MoveNext
       	board_idx = board_idx + 1
  Loop

  objRs.Close	
  %>


// �޴� ��� �̸� �� ���� ġ�� �߻��ϴ� �̺�Ʈ.
function Mail_EnterCheck(frm) 
{  
	var frm=eval("document.all."+frm);
	var board_idx_num = new Array();
	
	board_idx_num_cnt	= 0;

	if(event.keyCode==13)   
	{   
		event.keyCode = 0;
		send_name=frm.send_name.value;
		sabun_chk_cnt=0;			
		for(i=0; i < to_name.length; i++)
		{
			if(send_name==to_name[i])
			{
				sabun_chk_cnt=sabun_chk_cnt+1;
				board_idx_num[board_idx_num_cnt]=i;
				board_idx_num_cnt=board_idx_num_cnt+1
			}			
		}
		
		if(sabun_chk_cnt==1)
		{
			select_name_change(frm,board_idx_num[0])
		}	
		else
		{
			//���� �̸��� ������ �϶���,,,, 
			for(i=0; i < board_idx_num_cnt; i++)
			{
				select_name_change(frm,board_idx_num[i])
			}

			//alert(sabun_chk_cnt);
		}
	}
	frm.send_name.value="";
	frm.send_name.focus();
} 


//�޴� ��� �߰� 
function select_name_change(frm,board_idx_num)
{
	var chk1="O";
	cnt=frm.select_name.length;
	for(i = 0; i < frm.select_name.length; i++) 
   	{
  		//������ �ߺ� üũ
		receipt_str = frm.select_name.options[i].value;
		
		if(receipt_str == m_id[board_idx_num])
		{
			chk1="X";
		}
	}

	if(chk1!="X")
	{
		opt_value=to_name[board_idx_num]+"_"+job_position[board_idx_num];
		sabun_chk=m_id[board_idx_num];
		frm.select_name.options[cnt++] = new Option(opt_value,sabun_chk);
	}
	
	return;
}

//���õ� ��� ����Ʈ �������(���Ͼ���)
function select_name_del1(frm)
{
	var frm=eval("document.all."+frm);
	if(frm.select_name.selectedIndex=="-1")
	{
		alert("����� ������ �ּ���");
		return;
	}
	else
	{
		frm.select_name.options[frm.select_name.selectedIndex] = null;
	}
}


// ���Ͼ��� �Ϸ�
function send_mail_message(frm) 
{
	var frm=eval("document.all."+frm);

	chk1="X"
	
	frm.select_name_hid.value="";
	hid_str="";
	
	if(frm.select_name.length!=0)
	{
		for(i = 0; i < frm.select_name.length; i++) 
       	{
	     	receipt_str = frm.select_name.options[i].value+"_";
			hid_str=hid_str+receipt_str;
		}
	}
	
	if(frm.subject.value=="")
	{
		alert("���� ������ �־��ּ���!");
		return;
	}
	
	frm.select_name_hid.value=hid_str;
	frm.submit();
} 



function Mail_Re_Check(frm) 
{ 
	var frm=eval("document.all."+frm);

	var board_idx_num = new Array();	
	board_idx_num_cnt	= 0;

	send_name=frm.send_name.value;
	sabun_chk_cnt=0;	
	
	for(i=0; i < to_name.length; i++)
	{
		if(send_name==to_name[i])
		{
			sabun_chk_cnt=sabun_chk_cnt+1;
			board_idx_num[board_idx_num_cnt]=i;
			board_idx_num_cnt=board_idx_num_cnt+1
		}			
	}
	
	if(sabun_chk_cnt==1)
	{
		select_name_change(frm,board_idx_num[0])
	}	
	else
	{
		//���� �̸��� ������ �϶���,,,, 
		for(i=0; i < board_idx_num_cnt; i++)
		{
			select_name_change(frm,board_idx_num[i])
		}

		//alert(sabun_chk_cnt);
	}
	
	frm.send_name.value="";
	frm.send_name.focus();
	
	return;
} 
