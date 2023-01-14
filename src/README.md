# Better Lua modules

Modules created with better-modules provide the following features:

They *always* store their name. This is *sometimes* done, but here, it's guaranteed.

An already set-up metatable, which is returned alongside a new module when creating one.

Properties. This allows you to override the getters/setters of fields:

```lua
local bm = require("better-modules")

---@class datetime
local datetime = bm.create_module {
	name = "datetime",
}

datetime.date = {
	---@param self datetime
	---@return string The current date
	get = function(self)
		return os.date()
	end,

	---@param self datetime
	---@param date string
	set = function(self, date)
		--- (blah blah you get the point...)
	end,
}
```

Immutability that can be toggled on or off. Note: this only applies to creating new fields;
properties and existing fields are uneffected and can be still changed.

---

This module is very simple as you can see. But having all that boilerplate in each file would be gross.
