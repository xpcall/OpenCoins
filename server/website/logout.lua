res.headers["Set-Cookie"]="nil"
res.headers["Location"]="http://"..(cl.headers["Host"] or "pt.ptoast.tk").."/opencoins/index.lua"
res.code="302 Found"
print("")
