print(dofile("www/opencoins/header.lua")("Login"))
local dat=postdata or urldata
if next(dat or {}) then
	local err={}
	if (dat.username or "")=="" then
		table.insert(err,"No username field")
	end
	if (dat.password or "")=="" then
		table.insert(err,"No password field")
	end
	if err[1] then
		print('\t\t\t<div class="error">'..table.concat(err,"<br>\n\t\t\t").."</div>")
	else
		local user=opencoins.user({username=dat.username})
		if not user then
			print('\t\t\t<div class="error">No such username</div>')
		else
			if opencoins.auth(user,dat.password) then
				res.headers["Set-Cookie"]=dat.username..":"..dat.password
				res.headers["Location"]="http://"..(cl.headers["Host"] or "pt.ptoast.tk").."/opencoins/usercp.lua"
				res.code="302 Found"
			else
				print('\t\t\t<iframe width="186" height="105" src="//www.youtube.com/embed/gvdf5n-zI14?autoplay=1" frameborder="0" allowfullscreen></iframe>')
			end
		end
	end
end
dat=dat or {}
print([[
			<form method="post" action="login.lua">
				<p>Username: <input type="text" name="username" value="]]..htmlencode(dat.username or "")..[["/></p>
				<p>Password: <input type="password" name="password" value="]]..htmlencode(dat.password or "")..[["/></p>
				<input type="submit" value="Submit">
			</form>
]])
print(dofile("www/opencoins/footer.lua"))
