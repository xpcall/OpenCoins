print(dofile("www/opencoins/header.lua")("Coins"))
if user then
	local newtokentxt=""
	local usetokentxt=""
	local md=""
	local dat=postdata or urldata or {}
	local ocoins=user.coins
	if dat.action=="newtoken" then
		if dat.dorevert then
			if dat.revert then
				local res,err=opencoins.revertTokens(dat.revert,user)
				if res then
					newtokentxt='\t\t\t<div class="success">'..#res..' tokens reverted</div>\n'
				else
					newtokentxt='\t\t\t<div class="error">Error: '..err..'</div>\n'
				end
			elseif dat.token then
				local res,err=opencoins.newToken(dat.token,user)
				if res then
					newtokentxt='\t\t\t<div class="success">1 tokens reverted</div>\n'
					dat.token=nil
				else
					newtokentxt='\t\t\t<div class="error">Error: '..err..'</div>\n'
				end
			end
		elseif dat.worth then
			local res,err=opencoins.newToken(dat.worth,dat.revert,user)
			if res then
				newtokentxt='\t\t\t<div class="success">Token created! '..res..'</div>\n'
			else
				newtokentxt='\t\t\t<div class="error">Error: '..err..'</div>\n'
			end
		end
	elseif dat.action=="usetoken" and dat.token then
		local res,err=opencoins.useToken(dat.token,user)
		if res then
			usetokentxt='\t\t\t<div class="success">Token used!</div>\n'
			dat.token=nil
		else
			usetokentxt='\t\t\t<div class="error">Error: '..err..'</div>\n'
		end
	end
	
	print('\t\t\tWelcome '..htmlencode(user.name).."!<br>\n")
	local dt=user.coins-ocoins
	if dt==0 then
		print('\t\t\tYour coins: '..user.coins..'<br><br>\n')
	else
		print('\t\t\tYour coins: '..user.coins..' '..(dt>0 and "<green>(+" or "<red>(-")..math.abs(dt)..(dt>0 and ")</green>" or ")</red>")..'<br><br>\n')
	end
	
	print('\t\t\t<div class="section">Create token</div>')
	print(newtokentxt)
	print('\t\t\t<form method="post" action="coins.lua"><table>')
	print('\t\t\t\t<tr><td>New token worth: </td><td><input type="text" name="worth" value="'..htmlencode(dat.action=="newtoken" and dat.worth or "")..'"/></td></tr>')
	print('\t\t\t\t<tr><td>Revert code: </td><td><input type="text" name="revert" value="'..htmlencode(dat.action=="newtoken" and dat.revert or "")..'"/></td></tr>')
	print('\t\t\t\t<tr><td><input type="hidden" name="action" value="newtoken"></td></tr>')
	print('\t\t\t\t<tr><td><input type="submit" value="Submit"> <input type="submit" name="dorevert" value="Revert"></td></tr>')
	print('\t\t\t</table></form>')
	
	print('\t\t\t<div class="section">Use token</div>')
	print(usetokentxt)
	print('\t\t\t<form method="post" action="coins.lua"><table>')
	print('\t\t\t\t<tr><td>Token: </td><td><input type="text" size="64" name="token" value="'..htmlencode(dat.action=="usetoken" and dat.token or "")..'"/></td></tr>')
	print('\t\t\t\t<tr><td><input type="hidden" name="action" value="usetoken"></td></tr>')
	print('\t\t\t\t<tr><td><input type="submit" value="Submit"></td></tr>')
	print('\t\t\t</table></form>')
else
	auth.redirect()
end
print(dofile("www/opencoins/footer.lua"))

