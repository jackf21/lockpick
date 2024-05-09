fx_version 'cerulean'

games { 'gta5' }

server_scripts {
    'server/main.lua'
}

client_scripts {
    'client/main.lua',
}

ui_page('client/html/Index.html')

files({
    'client/html/Index.html',
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
    'client/html/sounds/backup.ogg'
})