<template>
     <transition name="modal">
        <div class="modal modal-overlay">
            <div class="modal-window w-75">
                <div class="modal-content">
                    <h3>記録をシェア!!</h3>
                    <p>行なったトレーニングをシェアしよう!!</p>
                    <div id="todo-complete">
                        <slot name="complete_form">
                        </slot>
                    </div>

                </div>
                <footer class="modal-footer">
                    <slot name="footer">
                    </slot>
                </footer>
            </div>
        </div>
    </transition>
</template>
<script>
export default {
    props: ['errors']
}
</script>
<style lang="scss" scoped>
.modal {
  .modal-window{
      margin-top: 80px;
  }
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
