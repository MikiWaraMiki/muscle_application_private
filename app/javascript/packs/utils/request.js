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
            var authentication_token = localStorage.getItem("AuthenticationToken");
            var authorization_header = {Authorization: authentication_token};
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