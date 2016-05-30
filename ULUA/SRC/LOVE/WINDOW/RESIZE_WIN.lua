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
