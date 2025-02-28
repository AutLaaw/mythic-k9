fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'AutLaaw'
description 'K-9 Script, original author hashx_k9 edited by FjamZoo#0001, converted to MFW and improved by AutLaaw'

client_scripts {
    'client/*'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
}
