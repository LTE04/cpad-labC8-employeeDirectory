// src/api/employeeApi.js
import axios from 'axios'

// 1. Single shared Axios instance
const apiClient = axios.create({
  baseURL: 'http://localhost:3001',
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  }
})

// 2. Request interceptor — logs every outgoing request
apiClient.interceptors.request.use(
  (config) => {
    console.log(`[API] ${config.method?.toUpperCase()} ${config.url}`)
    return config
  },
  (error) => Promise.reject(error)
)

// 3. Response interceptor — centralised error handling
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    let msg = 'Something went wrong'
    if (error.response) {
      msg = error.response.data?.error
            || `Server error ${error.response.status}`
    } else if (error.request) {
      msg = 'No response from server. Is the API running on :3001?'
    }
    return Promise.reject(new Error(msg))
  }
)

// 4. CRUD helper functions
export const getEmployees   = (params = {}) =>
  apiClient.get('/employees', { params })

export const getEmployee    = (id) =>
  apiClient.get(`/employees/${id}`)

export const createEmployee = (data) =>
  apiClient.post('/employees', data)

export const updateEmployee = (id, data) =>
  apiClient.put(`/employees/${id}`, data)

export const deleteEmployee = (id) =>
  apiClient.delete(`/employees/${id}`)

export default apiClient