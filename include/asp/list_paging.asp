<style>
 /* 페이징 */
.pg_wrap {clear:both; margin:0 0 10px;font-size:100%;padding:10px 0 0;text-align:center;font-size:12px;}
.pg_page, .pg_current {display:inline-block;padding:0 8px;height:25px;color:#000;letter-spacing:0;line-height:2.2em;vertical-align:middle}
.pg_page {background:#e4eaec;text-decoration:none}
.pg_current {display:inline-block;margin:0 4px 0 0; background:#333;color:#fff;font-weight:normal}
a.pg_page {padding:0 8px;}
</style>


<nav class="pg_wrap">
  <%
		' Request mychoice
		' Request totalpage
		' Request page
		' Request nowblock
		' Request link_url
		' Request link_tail
		If paging_chk="X" Then
		else
			tot_block=int(totalpage / mychoice)   
			if tot_block = (totalpage / mychoice)  then  
				tot_block=tot_block-1
			end if
	
			if Cint(nowblock)>0 then 
				response.write " <a href='"&link_url&"page="&(nowblock-1)*mychoice+1&"&nowblock="&nowblock-1&link_tail&"' class='pg_page'>이전 10개</a> "
			end if

			if page <> 1 then
				response.write " <a href='"&link_url&"page="&page-1&"&nowblock="&nowblock&link_tail&"' class='pg_page'>이전</a> "
			end if
      	
			if Cint(tot_block) <> Cint(nowblock) then 
				for i=1 to mychoice
					if cint(nowblock*mychoice)+i=cint(page) then 
						response.write "<span class='pg_current'>"&(cint(nowblock*mychoice) + i)&"</span> "
					else  
						response.write "<a href='"&link_url&"page="&(int(nowblock*mychoice) + i)&"&nowblock="&nowblock&link_tail&"' class='pg_page'> "&(int(nowblock*mychoice) + i)&"</a> "
					end if
				next 
			else
				if (totalpage mod mychoice)=0 then
					j=10
				else
					j=(totalpage mod mychoice)
				end if
	
				for i = 1 to j 
					if cint(nowblock*mychoice)+i=cint(page) then 
						response.write "<span class='pg_current'>"&(cint(nowblock*mychoice) + i)&"</span> "
					else  
      					response.write "<a href='"&link_url&"page="&(int(nowblock*mychoice) + i)&"&nowblock="&nowblock&link_tail&"' class='pg_page'>"&(int(nowblock*mychoice) + i)&"</a> "
					end if
				next
			end if

			if Cint(page) <> Cint(totalpage) then
      			response.write "<a href='"&link_url&"page="&page+1&"&nowblock="&nowblock&link_tail&"' class='pg_page'>다음</a> " 
			end if 
        
			if (Cint(tot_block) > 0) and (Cint(nowblock) < Cint(tot_block)) then 
				response.write "<a href='"&link_url&"page="&(nowblock+1)*mychoice+1&"&nowblock="&nowblock+1&link_tail&"' class='pg_page'>다음 10개</a> "
			end if 
		End if
  %>
  
  <% If recordcount<>"" Then %>
  <span class='pg_page'><b><%=money_change(recordcount)%> 건</b></span>
  <% End If %>
  </nav>