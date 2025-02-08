-- Basic resource metadata
fx_version 'cerulean'
game 'gta5'

-- Force enable Lua 54
lua54 'yes'

-- Name and description
name 'aop'
author 'Hyper'
description 'AOP System'
version '1.0.0'

-- Manifest ordering is important
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'ox_lib'
} 