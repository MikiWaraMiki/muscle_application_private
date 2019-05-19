<template>
    <div>
        <transition name="modal">
        <div class="modal modal-overlay" @click.self="$emit('close')">
            <div class="modal-window w-75">
                <div class="modal-content">
                    <h3>ユーザ登録</h3>
                    <label for="email">メールアドレス</label>
                    <input type='email' id='email' v-model="user.email" placeholder="sample@gmail.com">
                    <label for="password">パスワード</label>
                    <input type='password' id='password' v-model="user.password" placeholder="password">
                </div>
                <footer class="modal-footer">
                    <slot name="footer">
                    <button class="btn-sm btn-primary btn" v-on:click="signin">ログイン</button>
                    </slot>
                </footer>
            </div>
        </div>
        </transition>
    </div>
</template>
<script>
    import { mapState, mapActions} from 'vuex'

    export default {
        data: function () {
            return {
                user: {
                    email: "",
                    password: ""
                }
            }
        },
        computed: {
            ...mapState( ['logedIn'] )
        },
        methods: {
            ...mapActions( ['login'] ),
            onLogOut: function(){
                this.logout({
                    router: this.$router
                })
            },
            signin: function () {
                const payload = { 
                    email: this.user.email,
                    password: this.user.password
                }
                this.login({
                    router: this.$router,
                    payload: payload
                })
            }
        }
    }

</script>
<style lang="sass" scoped>
.modal {
  &.modal-overlay {
    display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    z-index: 30;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
  }

  &-window {
    background: #fff;
    border-radius: 4px;
    overflow: hidden;
  }

  &-content {
    padding: 10px 20px;
  }

  &-footer {
    background: #ccc;
    padding: 10px;
    text-align: right;
    .btn{
        margin: 0 auto;
    }
  }
}

// オーバーレイのトランジション
.modal-enter-active, .modal-leave-active {
  transition: opacity 0.4s;

  // オーバーレイに包含されているモーダルウィンドウのトランジション
  .modal-window {
    transition: opacity 0.4s, transform 0.4s;
  }
}

// ディレイを付けるとモーダルウィンドウが消えた後にオーバーレイが消える
.modal-leave-active {
  transition: opacity 0.6s ease 0.4s;
}

.modal-enter, .modal-leave-to {
  opacity: 0;

  .modal-window {
    opacity: 0;
    transform: translateY(-20px);
  }
}
</style>
