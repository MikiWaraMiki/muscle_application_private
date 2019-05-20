import axios from 'axios'

export default {
    request(method, url, options){
        var promise = null;
        var params  = {};
        var headers = {};
        // request parameter set
        if(options.params){
            params = options.params;
        }

        // heaeder set
        if(options.header){
            headers = options.header;
        }

        // authorize parameter set
        if(options.auth){
            //ローカルストレージからトークンを取得(ローカルストレージにAuthenticationTokenで保存されている前提)
            const authentication_token = localStorage.getItem("Token");
            const authentication_client = localStorage.getItem("Client");
            const authentication_expiry = localStorage.getItem("Expiry");
            const authentication_uid = localStorage.getItem("Uid");
            const authentication_token_type = localStorage.getItem("TokenType");
            var authorization_header = {
                "access-token": authentication_token,
                "client": authentication_client,
                "expiry": authentication_expiry,
                "uid": authentication_uid,
                "token-type": authentication_token_type
            };
            
            console.log(authentication_token)
            //Headerに認証トークンをセット
            headers = Object.assign(headers, authorization_header);
        }

        // Ruby on Rails CSRF Token settings
        var csrf_token = document.getElementsByName('csrf-token')[0].getAttribute('content');
        // Added CSRFTokent to Header
        headers['X-CSRF-TOKEN'] = csrf_token;
        // axios生成
        promise = axios({
            method: method,
            url: url,
            data: params,
            headers: headers
        })
        return promise;
    },
    //各種リクエストメソッドの定義
    get(url, options){
        return this.request('get', url, options);
    },
    post(url, options){
        return this.request('post', url, options);
    },
    patch(url, options){
        return this.request('patch', url, options);
    },
    delete(url, options){
        return this.request('delete', url, options);
    }
}