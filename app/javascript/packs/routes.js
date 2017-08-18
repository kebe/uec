//import Vue from 'vue';
//import VueRouter from 'vue-router';

import Auth from '../auth/Auth.vue';
import Login from '../auth/Login.vue';
import Register from '../auth/Register.vue';
import Dashboard from '../dash/Dashboard.vue';
import Dash from '../dash/Dash.vue';
import Route from '../dash/Route.vue';
import ServiceTicket from '../dash/ServiceTicket.vue';

Vue.use(VueRouter);

var router = new VueRouter({
    routes: [
        {
            path: '/',
            component: Dash,
            redirect: '/dashboard',
            children: [
                {
                    path: 'dashboard',
                    component: Dashboard,
                    meta: { requiresAuth: true }
                },
                {
                    path: 'route/:id/leave',
                    component: Route,
                    meta: { requiresAuth: true }
                },
                {
                    path: 'route/:id/return',
                    component: Route,
                    meta: { requiresAuth: true }
                },
                {
                    path: 'service-tickets/me',
                    component: ServiceTicket,
                    meta: { requiresAuth: true }
                }
            ]
        },
        {
            path: "/auth",
            component: Auth,
            redirect: '/auth/login',
            children: [
                {
                    path: "login",
                    component: Login,
                    meta: { requiresGuest: true }
                },
                {
                    path: "register",
                    component: Register,
                    meta: { requiresGuest: true }
                }
            ]
        }
    ]
});

export default router;