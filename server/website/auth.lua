local username,pass=(cl.headers["Cookie"] or ""):match("^(.-):(.+)$")
local user
if username then
	user=opencoins.user({username=username})
end
auth={}
function auth.redirect(rd)
	res.headers["Location"]="http://"..(cl.headers["Host"] or "pt.ptoast.tk").."/opencoins/index.lua"
	res.code="302 Found"
end
auth.user=user
if not user or not opencoins.auth(user,pass) then
	return false
end
return user
