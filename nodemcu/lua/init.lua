
config = require("config")
passwords = require("passwords")
print("Heap Available: -c " .. node.heap())
led = require("led")
print("Heap Available: -l " .. node.heap())
if string.find(config.Model, "BME") then
  bme = require("bme")
  print("Heap Available: -b " .. node.heap())
end
app = require("publisher")
print("Heap Available: -m " .. node.heap())
if string.find(config.Model, "GD") then
  gd = require("GarageDoorOpenSensor")
  print("Heap Available: -gd " .. node.heap())
end
setup = require("setup")
print("Heap Available: -setup " .. node.heap())
led.boot()
print("Heap Available: -boot " .. node.heap())
setup.start()
print("Heap Available: -start " .. node.heap())
-- Never gets here
