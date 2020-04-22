import Vue from 'vue'
import Router from 'vue-router'
import PhotoViewer from '@/components/PhotoViewer'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'PhotoViewer',
      component: PhotoViewer
    }
  ]
})
