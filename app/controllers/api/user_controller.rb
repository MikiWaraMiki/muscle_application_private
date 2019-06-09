module Api
    class Api::UserController < ApplicationController
        protect_from_forgery with: :null_session
        before_action :authenticate_api_user!

        def index
            @user  = current_api_user
            # タスク一覧
            @todos     = @user.todos
            # グラフ描画用データ
            @complete_todos_groupby = @user.todos.where(cleared:true).group('title').count
            @return_json_data = {user: @user.name, todos: @todos.where(cleared:false), graphdata: @complete_todos_groupby}
            render :json => @return_json_data
        end

        def show
            # 取得するユーザIDを取得
            id = params[:id]
            if id=="own" then
                show_current_user
            else
                @user = User.find(params[:id])
                render :json => @user
            end
        end

        def follow
            @user = current_api_user
            follow_user = User.find(follow_user_params[:user_id])
            if @user.following?(follow_user)
                @return_json_data = {mes: "すでにフォローしています"}
                render :json => @return_json_data, status: 422
            else @user.follow!(follow_user)
                if @user.save
                    @return_json_data = {'follow': follow_user}
                    render  :json => @return_json_data, status: 200
                else
                    @return_json_data = {mes: "フォローに失敗しました"}
                    render :json => @return_json_data, status: 422
                end
            end
        end

        def unfollow
            @user = current_api_user
            unfollow_user = User.find(follow_user_params[:user_id])
            if @user.following?(unfollow_user)
                @user.unfollow!(unfollow_user)
                if @user.save
                    @return_json_data = {'unfollow': unfollow_user}
                    render :json => @return_json_data, status: 200
                else
                    @return_json_data = {mes: "失敗しました"}
                    render :json => @return_json_data, status: 422
                end
            else
                @return_json_data = {mes: "フォローしていません"}
                render :json => @return_json_data, status: 422
            end
        end
        
        def pie
            @user = User.includes(:todos).find(current_api_user.id)
            @complete_todos_groupby = @user.todos.where(cleared:true).group('title').count
            return_json_data = {graphdata: @complete_todos_groupby}
            render :json => return_json_data
        end

        def create_line_data(data_type)
            user = User.includes(:todos).find(current_api_user.id)
            graph_array_data = []
            user.todos.where(cleared: true).each do |todo|
                index = has_graph_array_data(graph_array_data, todo.title)
                if index
                    #同じタイトルのデータがすでに存在する場合
                    if data_type == "weight"
                        graph_array_data[index][:data].push({x:format_chart_date(todo.clear_date), y:todo.weight})
                    elsif data_type == "count"
                        graph_array_data[index][:data].push({x:format_chart_date(todo.clear_date), y:todo.set_count})
                    end
                else
                    #dataが含まれていない場合
                    one_data = {
                        label:  todo.title,
                        borderColor: createColorCode(),
                        backgroudColor: "transparent",
                        data: []
                    }
                    if data_type == "weight"
                        one_data[:data].push({x: format_chart_date(todo.clear_date), y:todo.weight})
                    elsif data_type == "count"
                        one_data[:data].push({x: format_chart_date(todo.clear_date), y:todo.set_count})
                    end
                    graph_array_data.push(one_data)
                    puts "array is #{graph_array_data}"
                end
            end
            graph_array_data
        end
        def line_weight
            @graph_data = create_line_data("weight")
            render :json => {graphdata: @graph_data}, status: 200 
        end
        
        def line_count
            @graph_data = create_line_data("count")
            render :json => {graphdata: @graph_data}, status:200
        end

        private
        def createColorCode
            r,g,b = Random.rand(0 .. 255), Random.rand(10 .. 245), Random.rand(20 .. 235)
            "rgba(#{r},#{g},#{b},1)"
        end
        def has_graph_array_data(array_data, title)
            if array_data.length > 0
                target_obejct = array_data.find {|item|
                    item[:label] == title
                }
                array_data.index(target_obejct) 
            else
                false
            end
        end
        def show_current_user
            #ログインしているユーザ情報
            @user     = current_api_user
            @return_json_data = {user: @user, posts: @user.posts, following: @user.followings, follower: @user.followers }
            render :json => @return_json_data
        end

        def follow_user_params
            params.require(:user).permit(:user_id)
        end

        def format_chart_date(non_format_date)
            "#{non_format_date.year}-#{non_format_date.month}-#{non_format_date.day}"
        end

    end
end