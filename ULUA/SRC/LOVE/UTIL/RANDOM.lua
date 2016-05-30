-- generate random integer.
function RANDOM(limitOrParams)
	--REQUIRED: limitOrParams
	--OPTIONAL: limitOrParams.min
	--OPTIONAL: limitOrParams.max
	--OPTIONAL: limitOrParams.limit

	local min
	local max
	local limit

	if type(limitOrParams) ~= 'table' then
		limit = limitOrParams.limit
	else
		min = limitOrParams.min
		max = limitOrParams.max
		limit = limitOrParams.limit
	end

	if min == nil then
		min = 0
	end

	if limit ~= nil then
		max = limit - 1;
	end

	return love.math.random(min, max)
end
