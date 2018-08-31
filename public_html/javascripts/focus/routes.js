const routes = [
  { path: '/', redirect: '/Welcome' },
  { path: '/welcome', component: Welcome},
  { path: '/east', component: East },
  { path: '/central', component: Central, props: { Central: true } },
  { path: '/southwest', component: Southwest },
  { path: '/south', component: South },
  { path: '/alaska', component: Alasks },
  { path: '/northwest', component: Northwest },
  { path: '*', component: Welcome}
] 
  
const router = new VueRouter({
  routes
})
  