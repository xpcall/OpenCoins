local links={
	{"Login","/opencoins/login.lua"},
	{"Register","/opencoins/register.lua"},
	{"Home","/opencoins/index.lua"},
	{"GitHub","https://github.com/P-T-/OpenCoins"},
}
return function(cur)
	local ot={}
	for k,v in pairs(links) do
		if v[1]~=cur then
			table.insert(ot,'\t\t\t<a href="'..v[2]..'">'..v[1].."</a>")
		end
	end
	return [[<!--
	My crappy HTML
-->
<html>
	<head>
		<title>OpenCoins</title>
		<link rel="stylesheet" type="text/css" href="/opencoins/style.css"/>
		<link rel="icon" type="image/ico" href="/opencoins/favicon.ico"/>
	</head>
	<body>
		<div id="logo">
			<img src="/opencoins/logo.png"/><br/>
]]..table.concat(ot,"&nbsp;&nbsp;&nbsp;\n")..[[
		</div>
		<div id="main">
			<center><div class="title">]]..cur..[[</div></center><br>
]]
end

