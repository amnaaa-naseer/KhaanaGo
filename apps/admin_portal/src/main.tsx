import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { ScreenApp } from '../../../packages/khaana-web/src/ScreenApp'

createRoot(document.getElementById('root')!).render(
  <StrictMode><ScreenApp role="admin" homeId="E1-US3-UI8" /></StrictMode>,
)
