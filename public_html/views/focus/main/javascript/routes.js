const routes = [
  { path: '/east', component: East },
  { path: '/central', component: Central, props: { Central: true } },
  { path: '/southwest', component: Southwest },
  { path: '/south', component: South },
  { path: '/northwest', component: Northwest }
]
  
const router = new VueRouter({
  routes
})
  