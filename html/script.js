$(window).ready(function() {
    window.addEventListener('message', (event) => {
        let data = event.data;
        if (data.action == true){
            $("body").show();
            document.getElementById('task-list').innerHTML = '';
            for (var i in data.data) {
                if (data.data[i].finished == true) {
                    document.getElementById('task-list').innerHTML = document.getElementById('task-list').innerHTML + '<li class="task-list-item" v-for="task in tasks"> <label class="task-list-item-label"> <input id="checkbox" type="checkbox" checked disabled> <span>'+ data.data[i].TaskName +'</span> </label> </li>';     
                }
                else {
                    document.getElementById('task-list').innerHTML = document.getElementById('task-list').innerHTML + '<li class="task-list-item" v-for="task in tasks"> <label class="task-list-item-label"> <input id="checkbox" type="checkbox" disabled> <span>'+ data.data[i].TaskName +'</span> </label> </li>';
                }  
            }
            //
        } else if(data.action == false) {
            $("body").hide();
        }
    });
});