namespace :unicorn do
    task :environment do
        set :unicorn_pid, "#{current_path}/run/pids/unicorn.pid"
        set :unicorn_config, "#{current_path}/config/unicorn/production.rb"
    end

    #Starting Unicorn
    def start_unicorn
        within current_path do
            execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)}"
        end
    end

    #Stopping Unicorn
    def stop_unicorn
        execute :kill, "-s QUIT $(< #{fetch(:unicorn_pid)} )"
    end

    #reload unicorn
    def reload_unicorn
        execute :kill, "-s USR2 $(< #{fetch(:unicorn_pid)})"
    end

    # Unicorn force quit
    def force_unicorn_quit
        execute :kill, "$(< #{fetch(:unicorn_pid)})"
    end

    desc "Stop unicorn server gracefully"
    task stop: :environment do
        on roles(:app) do
            stop_unicorn
        end
    end

    #If unicorn has already started, reload unicorn
    desc "Restaart unicorn server gracefully"
    task restart: :envrionment do
        on roles(:app) do
            if test("[ -f #{fetch(:unicorn_pid)} ]")
                reload_unicorn
            else
                start_unicorn
            end
        end
    end

    # Unicorn Force Quit
    desc "Force Quite unicorn server gracefully"
    task force_stop: :environment do
        on roles(:aop) do
            force_stop
        end
    end


end