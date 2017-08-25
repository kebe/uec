//import Vue from 'vue';
//Vue.config.devtools = true 
import App from '../dash/App';
import Router from './routes.js';
//import VueResource from 'vue-resource';
import Auth from '../plugins/Auth.js';
//Vue.config.devtools = true
Vue.use(VueResource);
Vue.use(Auth);

//configure alertify defaults
alertify.defaults.notifier.position = 'top-right';

Vue.http.interceptors.push(function(request, next) {
    if (request.url.includes('api/v1')) {
        request.url = process.env.API_URL + request.url;
        //request.url = "https://uectransport.herokuapp.com"+ request.url;

        var token = Vue.auth.getToken();
        if (token)
            request.headers.set('Authorization', 'Bearer ' + token);
    }

    next(function(response) {
        if (response.status == 422) {
            response.body.errors.forEach(function (e) {
                alertify.error(e);
            });
        }   
    });
});

//configure route guards
Router.beforeEach(function (to, from, next)  {
    //prevent access to 'requiresGuest' routes;
    if (to.matched.some(function(record) { return record.meta.requiresGuest })
        && Vue.auth.loggedIn())
    {
        next({
            path: '/dashboard'
        });
    }
    else if (to.matched.some(function(record) { return record.meta.requiresAuth })
        && !Vue.auth.loggedIn())
    {
        next({
            path: '/auth/login',
            query: { redirect: to.fullPath }
        });
    }
    else {
        next(); // make sure to always call next()!
    }
});

/* eslint-disable no-new */
new Vue({
    el: '#app',
    router: Router,
    template: '<App/>',
    components: { App }
});
