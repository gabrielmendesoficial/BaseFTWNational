fx_version "bodacious"
game {"gta5"}

ui_page "nui/index.html"

server_scripts {
    "@vrp/lib/utils.lua",
    'config.lua',
    'server/*',
}

client_scripts  {
	"@vrp/lib/utils.lua",
	'config.lua',
    "client/*"
}

files {
	"nui/assets/*.svg",
	"nui/assets/*.png",
	"nui/*.png",
	"nui/index.html",
	"nui/index.js",
	"nui/styles.css"
}

              