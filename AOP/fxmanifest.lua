fx_version 'cerulean'
game 'gta5'

lua54 'yes'

name 'aop'
author 'Hyper'
description 'AOP System'
version '1.0.0'

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
