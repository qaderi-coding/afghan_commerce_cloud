import { lazy } from 'react'

// project imports
import Loadable from 'components/Loadable'
import DashboardLayout from 'layout/Dashboard'
import AuthGuard from 'utils/route-guard/AuthGuard'

// render - Dashboard
const DashboardDefault = Loadable(lazy(() => import('pages/dashboard/default')))

// ==============================|| MAIN ROUTING ||============================== //

const MainRoutes = {
  path: '/',
  element: (
    // <AuthGuard>
      <DashboardLayout />
    // </AuthGuard>
  ),
  children: [
    {
      path: '/',
      element: <DashboardDefault />
    }
  ]
}

export default MainRoutes
