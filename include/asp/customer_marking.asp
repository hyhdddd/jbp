  <%
		'고객마킹 로직
		o_marking				= CInt(o_marking)
		g_date_yuchi_day		= dateDiff("d",g_date_yuchi, now)
		
		'response.write g_date_yuchi_day &":"&o_marking
		'o_marking = 1
		
		'마킹정책 미적용 권한.
		If ad_a_marking="A" Then
		else
			If g_date_yuchi_day>=(o_marking) And CInt(o_marking)<>0 Then 
				
				If Len(c_name)>=3 Then	
					c_name				= Left(c_name,1) & "*"& Mid(c_name,3) 
				Else	
					c_name				= Left(c_name,1)&"*"
				End If
											
				If Len(c_tel1)>=4			Then	c_tel1				= Left(c_tel1,Len(c_tel1)-4) & "****"		End if
				If Len(c_tel2)>=4			Then	c_tel2				= Left(c_tel2,Len(c_tel2)-4) & "****"		End if
				If Len(c_address)>=10		then	c_address			= Left(c_address,10)&"*****"				End If			
				If Len(g_address)>=10		then	g_address			= Left(g_address,10)&"*****"				End If			
				If Len(c_jumin2)>=1			then	c_jumin2			= Left(c_jumin2,1)& "******"				End If		
				If Len(c_jumin_date)>=1		then	c_jumin_date		=  "*****"									End If	
				If instr(c_email,"@")>0		Then	c_email				= "*****"& Mid(c_email,InStr(c_email,"@"))  End if
								
				'납부정보			
				If Len(g_bank_no)>=5		then	g_bank_no			= Left(g_bank_no,5)&"******"				End If				

				If Len(g_bank_name)>=3 Then	
					g_bank_name				= Left(g_bank_name,1) & "*"& Mid(g_bank_name,3) 
				Else	
					g_bank_name				= Left(g_bank_name,1)&"*"
				End If

				If Len(g_bank_jumin2)>=1	then	g_bank_jumin2		= Left(g_bank_jumin2,1)& "******"			End If		
				
				'카드정보		
				If Len(g_card_name)>=3 Then	
					g_card_name				= Left(g_card_name,1) & "*"& Mid(g_card_name,3) 
				Else	
					g_card_name				= Left(g_card_name,1)&"*"
				End If

				If Len(g_card_no)>=6		then	g_card_no			= left(g_card_no,6)&"******"				End If			
				If Len(g_card_jumin2)>=1	then	g_card_jumin2		= Left(g_card_jumin2,1)&"******"			End If			
				
				'사은품 정보			

				If Len(g_sp_bank_name)>=3 Then 
					g_sp_bank_name = Left(g_sp_bank_name,1) & "*"& Mid(g_sp_bank_name,3) 
				Else 
					g_sp_bank_name= Left(g_sp_bank_name,1)&"*" 
				End if			

				If Len(g_sp_bank_acount)>=5	then	g_sp_bank_acount	= Left(g_sp_bank_acount,5)&"******"			End If	
				If Len(g_sp_bank_jumin2)>=1	then	g_sp_bank_jumin2	= Left(g_sp_bank_jumin2,1)&"******"			End If			

				'번호이동정보
				If Len(g_move_name)>=3 Then 
					g_move_name			= Left(g_move_name,1) & "*"& Mid(g_move_name,3)  
				Else 
					g_move_name			= Left(g_move_name,1)&"*" 
				End if			

				If Len(g_move_tel1)>=10		Then	g_move_tel1			= left(g_move_tel1,3)&"-****-"&right(g_move_tel1,4)	End If
				If Len(g_move_tel2)>10		Then	g_move_tel2			= left(g_move_tel2,3)&"-****-"&right(g_move_tel2,4)	End If
				If Len(g_move_jumin2)>=1	then	c_jumin2			= "*******"						End If		
				
				g_bigo	= ""

				'가입번호
				If Len(g_service_no)>=4			Then	g_service_no	= Left(g_service_no,Len(g_service_no)-4) & "****"		End if

			End If			
			'고객마킹 로직
		End if
%>