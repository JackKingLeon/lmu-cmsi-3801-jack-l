function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

function first_then_lower_case(strs, fxn)
  for _, str in ipairs(strs) do
    if fxn(str) then
      return string.lower(str)
    end
  end
  return nil
end

function powers_generator(base, limit)
  local power_coroutine = coroutine.create(function ()
    local power = 0
    while math.floor(base^power) <= limit do
      coroutine.yield(math.floor(base^power))
      power = power + 1
    end
  end)
  return power_coroutine
end

function say(words)
  local function inner(word)
    if word == nil then
      return words
    end
    return say(words .. " " .. word)
  end

  if words == nil then return "" end
  return inner
end

function meaningful_line_count(file)
  local f = io.open(file, "r")
  if f ==nil then
    error("No such file")
  end

  local lines = {}
  for line in io.lines(file) do
    line = line:gsub("^%s*", "")
    if line ~= nil and line ~= "" and string.sub(line, 1, 1) ~= "#" then
      table.insert(lines, line)
    end
  end

  f:close()
  return #lines
end

Quaternion = (function (class, meta, prototype)
  class.new = function (a, b, c, d)
    return setmetatable({a = a, b = b, c = c, d = d}, meta)
  end

  prototype.conjugate = function (self)
    return class.new(self.a, -self.b, -self.c, -self.d)
  end

  prototype.coefficients = function (self)
    return {self.a, self.b, self.c, self.d}
  end

  meta.__index = prototype

  meta.__add = function (self, q)
    return class.new(self.a + q.a, self.b + q.b, self.c + q.c, self.d + q.d)
  end

  meta.__mul = function(self, q)
    return class.new(
    (self.a * q.a - self.b * q.b - self.c * q.c - self.d * q.d),
    (self.a * q.b + self.b * q.a + self.c * q.d - self.d * q.c),
    (self.a * q.c - self.b * q.d + self.c * q.a + self.d * q.b),
    (self.a * q.d + self.b * q.c - self.c * q.b + self.d * q.a)
    )
  end

  meta.__eq = function (self, q)
    if self.a == q.a and self.b == q.b and self.c == q.c and self.d == q.d then
      return true
    else
      return false
    end
  end

  local function has_decimal (num)
    return num % 1 > 0
  end

  meta.__tostring = function (self)
    local return_str = ""
    if self.a == 0 and self.b == 0 and self.c == 0 and self.d == 0 then
      return_str = "0"
    end

    if self.a ~= 0 then
      if has_decimal(self.a) then
        return_str = return_str .. string.format("%g", self.a)
      else
        return_str = return_str .. string.format("%.1f", self.a)
      end
    end

    if self.b ~= 0 then
      if has_decimal(self.b) then
        return_str = return_str .. string.format("%+gi", self.b)
      else
        return_str = return_str .. string.format("%+.1fi", self.b)
      end
    end
    if math.abs(self.b) == 1 then return_str = return_str:gsub("1.0","") end

    if self.c ~= 0 then
      if has_decimal(self.c) then
        return_str = return_str .. string.format("%+gj", self.c)
      else
        return_str = return_str .. string.format("%+.1fj", self.c)
      end
    end
    if math.abs(self.c) == 1 then return_str = return_str:gsub("1.0","") end

    if self.d ~= 0 then
      if has_decimal(self.d) then
        return_str = return_str .. string.format("%+gk", self.d)
      else
        return_str = return_str .. string.format("%+.1fk", self.d)
      end
    end
    if math.abs(self.d) == 1 then return_str = return_str:gsub("1.0","") end

    if return_str:sub(1,1) == "+" then return_str = return_str:sub(2,#return_str) end

    return return_str
  end

  return class
end)({}, {}, {})