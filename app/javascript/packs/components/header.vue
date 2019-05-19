<template>
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="header">
            <h1 class="navbar-brand">Muscle Todo!</h1>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="nav navbar-nav justify-content-end">
                    <li class="nav-item">
                        <router-link to="/" class="nav-link">Home</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link to="/timeline" class="nav-link">Timeline</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link to="/articke" class="nav-link">Article</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link to="/contact" class="nav-link">Contact</router-link>
                    </li>
                </ul>
            </div>
        </nav>
    
</template>
<style lang="sass">
.fixed-top{
    background-color: #87cefa;
    .navbar-brand{
        letter-spacing: 1.1em;
        font-size: 1.2em;
        color: white !important;
    }
    ul.nav{
        width:100%;
        float: right
    }
    li.nav-item{
        margin-right: 20px;
        font-size: 1.1em;
        &:hover{
            color:white !important;
        }
        .nav-link{
            color: #ffffff;
        }
    }
}
</style>