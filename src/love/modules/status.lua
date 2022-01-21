local noResize

return {
	setNoResize = function(state)
		noResize = state
	end,
	getNoResize = function(state)
		return noResize
	end
}