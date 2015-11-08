local sqlite3 = require( "sqlite3" )

local pontuacao = 0
local NAME_KEY_PONTUACAO_ = 'pontuacao'

local path = system.pathForFile( "math-ninja.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

-- Handle the "applicationExit" event to close the database
local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then
        db:close()
    end
end

-- Set up the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY, key, value);]]
db:exec( tablesetup )

-- print( "SQLite version " .. sqlite3.version() )

local function deleteByKey( key )
    local queryDelete = [[ DELETE FROM settings WHERE key = ']]..key..[['; ]]
    db:exec( queryDelete )
end

local function getByKey( key )
    for row in db:nrows("SELECT * FROM settings WHERE key = '" .. NAME_KEY_PONTUACAO_ .. "'") do
        return row.value
    end

    return 0
end

function setPontuacao( )
    deleteByKey( NAME_KEY_PONTUACAO_ )

    local tablefill = [[INSERT INTO settings VALUES (null, 'pontuacao', ']].. NAME_KEY_PONTUACAO_ ..[['); ]]

    db:exec( tablefill )
end

function unsetPontucao()
    deleteByKey( NAME_KEY_PONTUACAO_ )
end

function getPontuacao()
    return getByKey( NAME_KEY_PONTUACAO_)
end

Runtime:addEventListener( "system", onSystemEvent )