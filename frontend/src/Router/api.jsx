import axios from 'axios';
const apiUrl = process.env.REACT_APP_API_URL || 'localhost:8080';

const api = axios.create({
  baseURL: `http://${apiUrl}`,
});

api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('jwtToken'); 
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default api;
