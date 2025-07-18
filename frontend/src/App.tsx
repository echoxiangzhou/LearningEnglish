import React from 'react'
import { RouterProvider } from 'react-router-dom'
import { Provider } from 'react-redux'
import { ConfigProvider } from 'antd'
import zhCN from 'antd/locale/zh_CN'
import { store } from './store/store'
import { router } from './router'
import { SessionTimeoutProvider } from './components/auth'
import './App.css'
import './styles/accessibility.css'
import './styles/responsive.css'
import './utils/authDebug'

function App() {
  return (
    <Provider store={store}>
      <ConfigProvider locale={zhCN}>
        <SessionTimeoutProvider timeoutMinutes={30} warningMinutes={5}>
          <RouterProvider router={router} />
        </SessionTimeoutProvider>
      </ConfigProvider>
    </Provider>
  )
}

export default App
