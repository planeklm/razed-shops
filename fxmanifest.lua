fx_version 'cerulean'

game "gta5"

author "Xirvin"
version '0.0.1'

lua54 'yes'


ui_page 'html/index.html'
-- ui_page 'http://localhost:3000/' --for dev

client_script {
  '@PolyZone/client.lua',
  '@PolyZone/CircleZone.lua',
  'client/**',
}
server_script {
  "server/**",
  '@oxmysql/lib/MySQL.lua',
  }
shared_script {
  '@ox_lib/init.lua',
  "shared/**",
  }

files {
  'html/**',
}
