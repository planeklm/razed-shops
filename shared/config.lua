Config = {}

Config.Debug = true

-- If you add a shop below, you need to run this command in game with the same name to add it to the database
Config.Command = 'addstore'
Config.SubText = 'Add store to database (Admin Only)'

Config.StartStock = 0
Config.StartCapacity = 100

Config.Zones = {
    {
        name = 'store1',
        title = 'Awesome Store 1',
        price = 259000,
        blip = 52,
        hideBlip = false,
        coords = vector3(26.79, -1355.07, 29.34)
    },
    {
        name = 'store2',
        price = 259000,
        title = 'Awesome Store 2',
        blip = 52,
        hideBlip = false,
        coords = vector3(35.23, -1355.64, 29.31),
    }
}