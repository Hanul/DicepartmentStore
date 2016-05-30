-- set background.
function SET_BACKGROUND(params)
	--REQUIRED: params
	--OPTIONAL: params.color

	local color = params.color

	if color ~= nil then
		local hex = color:sub(2)
		love.graphics.setBackgroundColor(tonumber('0x'..hex:sub(1, 2)), tonumber('0x'..hex:sub(3, 4)), tonumber('0x'..hex:sub(5, 6)))
	end
end
