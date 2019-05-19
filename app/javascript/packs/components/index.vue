<template>
    <div>
    <div class="jumbotron jumbotron-fruid img-responsive" id="hero"  style="background-image:url(/assets/hero.jpg)">
        <div class="col-12 col-md-8">
            <h1>Welcome to Muscle Application</h1>
            <p>筋トレ好きのためのシェアサイトです</p>
            <p>自身の筋トレ記録や筋トレに関わる記事を共有することができます</p>
            <h3>どんなアプリケーション?</h3>
            <ul id="feature">
                <li class="my-2">筋トレのタスク管理を行います</li>
                <li class="my-2">
                    <p class="my-0">あなたが行なった筋トレをみんなにシェアすることができます</p>
                    <small>ユーザ登録が必要です</small>
                </li>
                <li class="my-2">
                    <p class="my-0">筋トレに関わる記事を閲覧・投稿することができます</p>
                    <small>投稿にはユーザ登録が必要です</small>
                </li>
            </ul>
            <router-link to="/signup" class="btn btn-primary mr-3">ユーザ登録する</router-link>
            <router-link to="/" class="btn btn-primary mr-3">ログインする</router-link>
        </div>
    </div>
        <div class="container" id="about">
            <h2 class="text-center p-2 m-2" id="app-mes">About</h2>
            <h3 class="feature">筋トレ専用のToDo管理</h3>
            <p>トレーニングメニューのToDoをシンプルに登録・管理することができます</p>
            <p>ついついサボりがちな筋トレをToDo管理することで確実なトレーニング実施の手助けをします</p>
            <router-link to="/todo" class="btn-lg btn-primary button">登録を見てみる</router-link>
            <h3 class="feature">トレーニング実績を可視化</h3>
            <p>完了したトレーニングの累計をグラフで表示します</p>
            <p>自分が今までどんなトレーニングをしてきたか、筋肉は成長しているのか、感覚的にしか分からないことが多くなると思います</p>
            <p>Muscle ToDoは過去のトレーニング実績を分かりやすいグラフで表示することで筋力の成長度を可視化します</p>
            <router-link to="/graph" class="btn-lg btn-primary button">みんなの記録を見てみる</router-link>
          <h3 class="feature">筋トレメニューのシェア</h3>
            <p>みんながどんなトレーニングをしているのか、どれぐらいの頻度でトレーニングしているのか簡単にチェックすることができます</p>
            <p>トレーニングがマンネリ化したり、モチベーションが上がらない時に他の人のトレーニングを見ることでモチベーションをあげることができます</p>
            <router-link to="/article" class="btn-lg btn-primary button">投稿記事を見てみる</router-link>            
        </div>
    </div>
</template>
<style lang="sass">
    #hero{
        background-repeat: no-repeat;
        background-size: cover;
        color: white;
    }
   #app-mes{
        border-bottom: 1px solid;
   }
   #about{
        .feature{
            border-left: solid 3px #87cefa;
            padding-left: 1.5rem;
            margin-top: 1em;
            margin-bottom: 1em;
        }
        .button{
            color: white;
        }
   }
</style>