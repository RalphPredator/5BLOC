import Vue from 'vue';
import Router from 'vue-router';
import Profile from '@/views/Profile';
import List from '@/views/List';
import Register from '@/views/Register';
import TokenCreate from '@/views/tokens/create.vue';
import TokenIndex from '@/views/tokens/index.vue';

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            name: 'List',
            component: List
        },
        {
            path: '/profile',
            name: 'Profile',
            component: Profile
        },
        {
            path: '/register',
            name: 'Register',
            component: Register
        },
        {
            path: '/token/create',
            name: 'TokenCreate',
            component: TokenCreate
        },
        {
            path: '/token/index',
            name: 'TokenIndex',
            component: TokenIndex
        },
    ],
    linkActiveClass: 'active'
});
