-- Create object.
function OBJECT(define)
	local cls = CLASS(define)

	local inner = {}
	local self = {}
	local params = {}

	self.type = cls

	-- check is instance of.
	self.checkIsInstanceOf = function(checkCls)
		local targetCls = cls

		-- check moms.
		while targetCls ~= nil do
			if targetCls == checkCls then
				return true
			end
			targetCls = targetCls.mom
		end

		return false
	end

	cls.innerInit(inner, self, params)
	cls.innerAfterInit(inner, self, params)

	return self
end
