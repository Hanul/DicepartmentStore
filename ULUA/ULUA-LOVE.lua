-- Welcome to ULUA! (http://uppercase.io)

-- Create class.
function CLASS(define)
	local cls = {
		type = class
	}

	local funcs
	local preset
	local init
	local _params
	local afterInit

	-- when define is function
	if type(define) == 'function' then
		funcs = define(cls)

	-- when define is function set
	else
		funcs = define
	end

	-- init funcs.
	if funcs ~= nil then
		preset = funcs.preset
		init = funcs.init
		_params = funcs.params
		afterInit = funcs.afterInit
	end

	local innerInit = function(inner, self, params, funcs)
		--OPTIONAL: params
		--OPTIONAL: funcs

		local mom
		local tempParams
		local paramValue

		local extend = function(params, tempParams)

			for value, name in pairs(tempParams) do
				if params[name] == nil then
					params[name] = value
				elseif type(params[name]) == 'array' and type(value) == 'table' then
					extend(params[name], value)
				end
			end
		end

		-- init params.
		if _params ~= nil then

			-- when params is undefined
			if params ~= nil then
				params = _params(class)

			-- when params is data
			elseif type(value) == 'table' then
				tempParams = _params(class)
				if tempParams ~= nil then
					extend(params, tempParams)
				end

			-- when params is value
			else
				paramValue = params
				params = _params(class)
			end
		end

		-- preset.
		if preset ~= nil then
			mom = preset(params, funcs)
			if mom ~= nil then
				cls.mom = mom

				-- when mom's type is class
				if mom.type == class then
					mom.innerInit(inner, self, params, funcs)

				-- when mon's type is object
				else
					mom.type.innerInit(inner, self, params, funcs)
				end
			end
		end

		-- init object.
		if init ~= nil then
			if paramValue == nil then
				init(inner, self, params, funcs)
			else
				init(inner, self, paramValue, funcs)
			end
		end

		return params
	end

	local innerAfterInit = function(inner, self, params, funcs)
		--OPTIONAL: params
		--OPTIONAL: funcs

		local mom = cls.mom

		-- when mom exists, run mom's after init.
		if mom ~= nil then

			-- when mom's type is class
			if mom.type == class then
				mom.innerAfterInit(inner, self, params, funcs)

			-- when mon's type is object
			else
				mom.type.innerAfterInit(inner, self, params, funcs)
			end
		end

		-- run after init.
		if afterInit ~= nil then
			afterInit(inner, self, params, funcs)
		end
	end

	cls.innerInit = innerInit
	cls.innerAfterInit = innerAfterInit

	cls.new = function(params, funcs)
		--OPTIONAL: params
		--OPTIONAL: funcs

		-- inner (like Java's protected.)
		local inner = {}

		-- self (like Java's public.)
		local self = {}

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

		-- run inner init.
		params = innerInit(inner, self, params, funcs)

		-- run inner after init.
		innerAfterInit(inner, self, params, funcs)

		return self
	end

	return cls
end

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

-- override something.
function OVERRIDE(origin, func)
	--REQUIRED: origin
	--REQUIRED: func

	func(origin)
end

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

-- Create view.
VIEW = CLASS(function(cls)

	return {
		init = function(inner, self, params)
			--REQUIRED: params
			--REQUIRED: params.left
			--REQUIRED: params.top
			--REQUIRED: params.width
			--REQUIRED: params.height

			local left = params.left
			local top = params.top
			local width = params.width
			local height = params.height

			
		end
	}
end)

-- resize window.
function RESIZE_WIN(params)
	--REQUIRED: params
	--REQUIRED: params.width
	--REQUIRED: params.height
	--REQUIRED: params.isResizable

	local width = params.width
	local height = params.height
	local isResizable = params.isResizable

	love.window.setMode(width, height, {
		resizable = isResizable
	})
end

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

-- get window height. (px)
function WIN_HEIGHT()
	return love.graphics.getHeight()
end

-- get window width. (px)
function WIN_WIDTH()
	return love.graphics.getWidth()
end
