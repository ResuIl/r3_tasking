fx_version "adamant"
game "gta5"

author "! Resul#0001"

ui_page 'html/index.html'

client_script "client.lua"

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	"config.lua",
	"server.lua"
}

files {
	'html/index.html',
	'html/script.js',
    'html/style.css'
}