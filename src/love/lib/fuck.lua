-- good luck! (I dont even understand it myself 😭)
local fuck = {}

local floor = math.floor 
local tostring = tostring
local table_insert = table.insert

local chars = {
    ':', 
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', "!", "@", "#",
    "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "[", "]",
    "{", "}", "|", ";", ":", "'", '"', ",", ".", "<", ">", "/", "?"
}

local function db85(num)
	local base = 85

	local final = {}
	while num > 0 do
		table_insert(final,1,num % base)
		num = floor(num / base)
	end

	while #final < 5 do 
		table_insert(final,1,0)
	end 

	return final
end

local function b85d(b85)
	local base = 85

	local l = #b85
	local final = 0

	for i=l,1,-1 do 
		local digit = b85[i]
		local val = digit * base^(l-i)
		final = final + val
	end 

	return final 
end 

local function dtb(num)
	local base = 2
	local bits = 8 

	local final = ""
	while num > 0 do
		final = "" ..  (num % base ) .. final
		num = floor(num / base)
	end

	local l = final:len()
	if l == 0 then 
		final = "0"..final 
	end

	while final:len()%8 ~=0 do 
		final = "0"..final 
	end 

	return final
end

local function btd(bin)
	local base = 2 

	local l = bin:len()
	local final = 0

	for i=l,1,-1 do 
		local digit = bin:sub(i,i)
		local val = digit * base^(l-i)
		final = final + val
	end 
	return final 
end 

function fuck.e(self, str)
    local final = ""
    local l = str:len()
    for i=1,l do 
        local char = str:sub(i,i)
        local charCode = char:byte()
        local binary = dtb(charCode)
        local b85 = db85(charCode)
        local b85Str = ""
        for i=1,#b85 do 
            local char = chars[b85[i]+1]
            b85Str = b85Str .. char
        end 
        final = final .. b85Str
    end 
    return final
end

function fuck.d(self, str)
    local final = ""
    local l = str:len()
    for i=1,l,5 do 
        local b85Str = str:sub(i,i+4)
        local b85 = {}
        for i=1,5 do 
            local char = b85Str:sub(i,i)
            local charCode = 0
            for i=1,#chars do 
                if chars[i] == char then 
                    charCode = i-1
                    break
                end 
            end 
            table_insert(b85,charCode)
        end 
        local charCode = b85d(b85)
        local char = string.char(charCode)
        final = final .. char
    end 
    return final
end

return fuck