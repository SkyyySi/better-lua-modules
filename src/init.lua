local module = { __mt = {} }
setmetatable(module, module.__mt)
module.__mt.__name = "SkyyySi"
module.__mt.__index = module.__mt

--- Create a new module
---@param args {name: string, imutable?: boolean}
function module.create_module(args)
	args = args or {}
	assert(args.name, "The module must have a name")

	local new_module = {
		__mt = {},
		__properties = {},
		__imutable = args.imutable or false,
	}
	setmetatable(new_module, new_module.__mt)
	new_module.__mt.__name = args.name

	function new_module.__mt.__index(self, key)
		if self.__properties[key] and self.__properties[key].get then
			return self.__properties[key].get(self)
		end

		return rawget(self, key) or rawget(self, "__mt")[key]
	end

	function new_module.__mt.__newindex(self, key, value)
		if self.__imutable then
			error("Attempt to set field '"..tostring(key).."' (to '"..tostring(value).."') on an immutable module")
		end

		if self.__properties[key] and self.__properties[key].set then
			self.__properties[key].set(self, value)
			return
		end

		rawset(self, key, value)
	end

	return new_module, new_module.__mt
end

return module
