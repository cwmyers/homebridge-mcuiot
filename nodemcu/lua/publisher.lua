local module = {}


function module.publish(id, temp, baro)
    m = mqtt.Client(id, 120)

    m:connect(config.localMqttServer, 1883, 0, function(client)
      print("connected to " .. config.localMqttServer)
      
      client:publish("/" .. id .. "/temp" , temp, 0, 1, function(client) print("sent") end)
      client:publish("/" .. id .. "/baro" , baro, 0, 1, function(client) print("sent") end)
    end, function(client, reason)
        print("failed reason: " .. reason)
        end)

    m:close();

    m1 = mqtt.Client(id, 120, passwords.adafruitUsername, passwords.adafruitPassword)

    m1:connect("io.adafruit.com", 1883, 0, function(client)
      print("connected to adafruit")
      
      client:publish(passwords.adafruitUsername .."/feeds/temp" , temp, 0, 1, function(client) print("sent temp") end)
      client:publish(passwords.adafruitUsername .."/feeds/baro" , baro, 0, 1, function(client) print("sent baro") end)
    end, function(client, reason)
        print("failed reason: " .. reason)
        end)

    m1:close();


end

function module.start()
    tmr.alarm(3, 60000, tmr.ALARM_AUTO, function()
      local temp = -999
      local baro = -999
      
      status, temp, baro = bme.read()
      print("Temp:" .. temp)
      module.publish(config.ID, temp, baro)
    end)
end

return module