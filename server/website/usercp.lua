print(dofile("www/opencoins/header.lua")("User CP"))
if user then
	print('\t\t\tur coinz: '..user.coins)
else
	auth.redirect()
end
print(dofile("www/opencoins/footer.lua"))
