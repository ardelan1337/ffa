fx_version 'cerulean'
game 'gta5'
lua54 'yes'

files {
    'html/index.html',
    'html/**/**/*.*'
}

ui_page 'html/index.html'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'@mysql-async/lib/MySQL.lua',
    '@async/async.lua',
    'config/*.lua',
    'server/*.lua'
}

client_scripts {
    'config/sh_config.lua',
    'client/main.lua'
}

escrow_ignore {
    'config/*.lua',
    'html/index.html',
    'html/**/**/*.*'
}

export 'inFFA' -- only client sided

-- exports.ultra_ffa:inFFA() | returns true if is in ffa and false if not