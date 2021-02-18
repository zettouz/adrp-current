resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX ADRP Race'

version '0.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'server/race.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/race.lua',
	'client/slip.lua',
	'client/utils/scaleform.lua',
	'client/utils/spectate.lua',
	'client/utils/ui.lua'
}

dependency 'es_extended'