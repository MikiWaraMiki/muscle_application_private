<template>
    <div>
        <div class="col-md-12 col-sm-12 my-3">
            <h1>Welcome</h1>
        </div>
        <div id="task-table" class="col-sm-12 col-md-12">
            <button type="button" class="btn btn-primary btn-sm pull-left" >タスクの登録</button>
            <vuetable ref="vuetable"
                api-url="https://vuetable.ratiw.net/api/users"
                :fields="['name', 'email', 'birthdate']">
            </vuetable>
        </div>
        <div id="graph" class="col-sm-12 col-md-12">
            
        </div>
    </div>
</template>
<script>
import Vuetable from 'vuetable-2/src/components/Vuetable'

export default {
    components: {
        Vuetable
    }
}
</script>