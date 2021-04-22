require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
enable :sessions




get('/') do
    slim(:register)
end

post('/users/new') do
    username = params[:username]
    password = params[:password]
    confirm_password = params[:confirm_password]

    if (password == confirm_password)
        #Lägg till användaren
        password_digest = BCrypt::Password.create(password)
        db = SQLite3::Databse.new('db/youtuberipoff.db')
        db.execute("INSERT INTO users (username,pwdigest) VALUES (?,?)",username,password_digest)
        redirect('/')
    else
        #felhantering
        'Du skrev in fel lösenord'
    end
end
