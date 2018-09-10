const routes = [
  { path: '/', redirect: '/Welcome' },
  { path: '/welcome', component: Welcome},
  { path: '/east', component: East },
  { path: '/central', component: Central, props: { Central: true } },
  { path: '/southwest', component: Southwest },
  { path: '/south', component: South },
  { path: '/alaska', component: Alaska },
  { path: '/northwest', component: Northwest },
  { path: '/groups', component: Groups },
  { path: '/groupsDialog', component: GroupsDialog },
  { path: '/signup', component: Signup },
  { path: '/signin', component: Signin },
  { path: '*', component: Welcome}
] 
  
const router = new VueRouter({
  routes
  // mode: 'history'
})
  